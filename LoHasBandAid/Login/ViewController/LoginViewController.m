//
//  LoginViewController.m
//  Mavic
//
//  Created by zhangxiaoqiang on 2017/3/30.
//  Copyright © 2017年 LoHas-Tech. All rights reserved.
//

#import "LoginViewController.h"
#import "YYKit.h"
#import "LoginView.h"
#import "LoginApi.h"
#import "LoginEntities.h"
#import "LoginManager.h"
#import "MBProgressHUD.h"
@interface LoginViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) LoginApi *api;
@property (nonatomic, strong) LoginView *loginV;

@property (nonatomic, strong) NSArray *historyUsers;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _loginV = (LoginView *)self.view;
    [_loginV.loginApp addTarget:self action:@selector(loginBtnDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_loginV.historyUserDrop addTarget:self action:@selector(dropUserDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    // 查找历史登录用户
    self.historyUsers = [self.api getUsersFormMainDB];
    
    _loginV.historyUserDropList.delegate   = self;
    _loginV.historyUserDropList.dataSource = self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 登录按钮点击事件
- (void)loginBtnDidClicked:(UIButton *)sender {
    [self allTextResignFirstRespond];
    
    NSString *name = _loginV.nameField.text;
    NSString *pwd  = _loginV.passWordField.text;
    if (name.length == 0) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.labelText = @"帐号不能为空";
        hud.mode = MBProgressHUDModeText;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1.5 * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        });
        return;
    }
    else if (pwd.length == 0) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.labelText = @"密码不能为空";
        hud.mode = MBProgressHUDModeText;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1.5 * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        });
        return;
    }
    
    
    [self.api loginWithUserName:name pwd:pwd completion:^(BOOL success, id result, NSString *msg) {
        if (success) {
            // 登录成功
            NSDictionary *dic  = result;
            User *user         = [[User alloc] initWithDictionary:dic];
            user.isLatestLogin = YES;
            user.password      = pwd;
            
            LoginManager *lm   = [LoginManager defaultManager];
            lm.currentUser     = user;
            
            // 保存到数据库
            [self.api saveCurrentUser:user];
            
            [self dismissViewControllerAnimated:YES completion:^{
                
            }];
        }
        else {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.labelText      = msg;
            hud.mode           = MBProgressHUDModeText;
            
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1.5 * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                // 清空文本
                [self clearInputView];
                [MBProgressHUD hideHUDForView:self.view animated:YES];
            });
        }
    }];
}

#pragma mark - 查看用户列表
- (void)dropUserDidClicked:(UIButton *)sender {
    if (sender.selected) {
        [UIView animateWithDuration:0.5 animations:^{
            CGFloat x      = _loginV.historyUserDropList.origin.x;
            CGFloat y      = _loginV.historyUserDropList.origin.y;
            CGFloat width  = _loginV.historyUserDropList.width;
            CGRect frame = CGRectMake(x, y, width, 0);
            _loginV.historyUserDropList.frame = frame;
        }];
    }
    else {
        [UIView animateWithDuration:0.5 animations:^{
            CGFloat x      = _loginV.historyUserDropList.origin.x;
            CGFloat y      = _loginV.historyUserDropList.origin.y;
            CGFloat width  = _loginV.historyUserDropList.width;
            CGRect frame = CGRectMake(x, y, width, self.historyUsers.count*30);
            _loginV.historyUserDropList.frame = frame;
        }];
    }
    sender.selected = !sender.selected;
}

#pragma mark - 清空文本框
- (void)clearInputView {
    _loginV.nameField.text     = @"";
    _loginV.passWordField.text = @"";
}
#pragma mark - 文本框退出焦点
- (void)allTextResignFirstRespond {
    [_loginV.nameField resignFirstResponder];
    [_loginV.passWordField resignFirstResponder];
    
    [UIView animateWithDuration:0.5 animations:^{
        CGFloat x      = _loginV.historyUserDropList.origin.x;
        CGFloat y      = _loginV.historyUserDropList.origin.y;
        CGFloat width  = _loginV.historyUserDropList.width;
        CGRect frame = CGRectMake(x, y, width, 0);
        _loginV.historyUserDropList.frame = frame;
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self allTextResignFirstRespond];
}

#pragma mark - UITableView Delegate&DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.historyUsers.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    User *user = self.historyUsers[indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.backgroundColor = UIColorHex(ffffff76);
    cell.textLabel.text = user.login_name;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    User *user = self.historyUsers[indexPath.row];
    _loginV.nameField.text     = user.login_name;
    _loginV.passWordField.text = user.password;
    
    [self dropUserDidClicked:_loginV.historyUserDrop];
}

#pragma mark - properties
- (LoginApi *)api {
    if (!_api) {
        _api = [LoginApi biz];
    }
    return _api;
}

@end

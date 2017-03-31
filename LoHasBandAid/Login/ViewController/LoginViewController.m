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
@interface LoginViewController ()

@property (nonatomic, strong) LoginApi *api;
@property (nonatomic, strong) LoginView *loginV;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _loginV = (LoginView *)self.view;
    [_loginV.loginApp addTarget:self action:@selector(loginBtnDidClicked:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [self dismissViewControllerAnimated:YES completion:^{
//        
//    }];
}

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
    
    _api = [LoginApi biz];
    [_api loginWithUserName:name pwd:pwd completion:^(BOOL success, id result, NSString *msg) {
        if (success) {
            // 登录成功
            NSDictionary *dic = result;
            User *user = [[User alloc] initWithDictionary:dic];
            user.isLatestLogin = YES;
            
            LoginManager *lm = [LoginManager defaultManager];
            lm.currentUser = user;
            
            // 保存到数据库
            [_api saveCurrentUser:user];
            
            [self dismissViewControllerAnimated:YES completion:^{
                
            }];
        }
        else {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.labelText = msg;
            hud.mode = MBProgressHUDModeText;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1.5 * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                // 清空文本
                [self clearInputView];
                [MBProgressHUD hideHUDForView:self.view animated:YES];
            });
        }
    }];
}

#pragma mark 清空文本框
- (void)clearInputView {
    _loginV.nameField.text     = @"";
    _loginV.passWordField.text = @"";
}
#pragma mark 文本框退出焦点
- (void)allTextResignFirstRespond {
    [_loginV.nameField resignFirstResponder];
    [_loginV.passWordField resignFirstResponder];
}



@end

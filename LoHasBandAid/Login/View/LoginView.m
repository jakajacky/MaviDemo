//
//  LoginView.m
//  Mavic
//
//  Created by zhangxiaoqiang on 2017/3/30.
//  Copyright © 2017年 LoHas-Tech. All rights reserved.
//

#import "LoginView.h"
#import "YYKit.h"
#import "NSString+CheckStyle.h"
#import "MBProgressHUD.h"

@interface LoginView () <UITextFieldDelegate>
{
    BOOL _isLoginBtnSelected;
    BOOL _isKboradAppear;
    CGRect _oldFrame;
    CGRect _newFrame;
    
}

@property (weak, nonatomic) IBOutlet UIView *lineView;

@property (weak, nonatomic) IBOutlet UIView *mainContainerView;



@end

@implementation LoginView

- (void)awakeFromNib {
    [super awakeFromNib];
    _isLoginBtnSelected = YES;
    [self reloadViews];
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(keyboradWillAppear:) name:UIKeyboardWillShowNotification object:nil];
    [center addObserver:self selector:@selector(keyboradWillDisappear:) name:UIKeyboardWillHideNotification object:nil];
    [center addObserver:self selector:@selector(keyboradDidAppear:) name:UIKeyboardDidShowNotification object:nil];
}

- (void)reloadViews {
    // 容器视图
    _containerView.backgroundColor = UIColorHex(ffffff51);
    [self setViewCornersWithView:_containerView byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight];
    
    // Login & Register 试图切换按钮
    _login.backgroundColor = UIColorHex(ffffff51);
    [self setViewCornersWithView:_login byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight];
    
    _registerBtn.backgroundColor = UIColorHex(00000026);
    _lineView.backgroundColor    = UIColorHex(ffffff51);
    [self setViewCornersWithView:_registerBtn byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight];
    
    // 登录表单
    self.nameField.layer.cornerRadius = 6;
    self.nameField.borderStyle = 0;
    self.nameField.tag = 111;
    self.nameField.layer.borderWidth = 0.5;
    self.nameField.layer.borderColor = (__bridge CGColorRef)([UIColor colorWithWhite:1 alpha:0.6]);
    self.nameField.backgroundColor = UIColorHex(ffffff76);
    
    self.passWordField.layer.cornerRadius = 6;
    self.passWordField.borderStyle = 0;
    self.passWordField.tag = 112;
    self.passWordField.layer.borderWidth = 0.5;
    self.passWordField.layer.borderColor = (__bridge CGColorRef)([UIColor cyanColor]);
    self.passWordField.backgroundColor = UIColorHex(ffffff76);
    
    
    self.passWordField.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"lock"]];
    self.nameField.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"user"]];
    self.nameField.leftViewMode = UITextFieldViewModeAlways;
    self.passWordField.leftViewMode = UITextFieldViewModeAlways;
    self.passWordField.secureTextEntry = YES;
    
    self.nameField.rightView         = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"drop"]];
    self.passWordField.rightView     = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nosee"]];
    self.nameField.rightViewMode     = UITextFieldViewModeAlways;
    self.passWordField.rightViewMode = UITextFieldViewModeAlways;
    
    self.historyUserDropList.backgroundColor = [UIColor clearColor];
    
}

#pragma mark - 灵活设置view的圆角
- (void)setViewCornersWithView:(UIView *)view byRoundingCorners:(UIRectCorner)corner {
    UIBezierPath *maskPath  = [UIBezierPath bezierPathWithRoundedRect:view.bounds
                                                    byRoundingCorners:corner
                                                          cornerRadii:CGSizeMake(10, 10)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame         = view.bounds;
    maskLayer.path          = maskPath.CGPath;
    view.layer.mask         = maskLayer;
}

#pragma mark - 注册和登录 页面的切换
- (IBAction)LoginViewAppear:(id)sender {
    
    if (_isLoginBtnSelected) {
        return;
    }
    _isLoginBtnSelected          = YES;
    _login.backgroundColor       = UIColorHex(ffffff51);
    _registerBtn.backgroundColor = UIColorHex(00000026);
    
    CGFloat l_x      = _login.frame.origin.x;
    CGFloat l_y      = _login.frame.origin.y;
    CGFloat l_width  = _login.width;
    CGFloat l_height = _login.height;
    _login.frame     = CGRectMake(l_x, l_y, l_width, l_height + 2);
    
    CGFloat r_x        = _registerBtn.frame.origin.x;
    CGFloat r_y        = _registerBtn.frame.origin.y;
    CGFloat r_width    = _registerBtn.width;
    CGFloat r_height   = _registerBtn.height;
    _registerBtn.frame = CGRectMake(r_x, r_y, r_width, r_height - 2);
    
    _lineView.hidden = YES;
}

- (IBAction)RegisterViewAppear:(id)sender {
    if (!_isLoginBtnSelected) {
        return;
    }
    _isLoginBtnSelected          = NO;
    _login.backgroundColor       = UIColorHex(00000026);
    _registerBtn.backgroundColor = UIColorHex(ffffff51);
    
    CGFloat l_x      = _login.frame.origin.x;
    CGFloat l_y      = _login.frame.origin.y;
    CGFloat l_width  = _login.width;
    CGFloat l_height = _login.height;
    _login.frame     = CGRectMake(l_x, l_y, l_width, l_height - 2);
    
    CGFloat r_x        = _registerBtn.frame.origin.x;
    CGFloat r_y        = _registerBtn.frame.origin.y;
    CGFloat r_width    = _registerBtn.width;
    CGFloat r_height   = _registerBtn.height;
    _registerBtn.frame = CGRectMake(r_x, r_y, r_width, r_height + 2);
    _lineView.hidden = NO;
    
    
}

#pragma mark - 监听键盘事件
- (void)keyboradWillAppear:(NSNotification *)notifi {
       
    if (_isKboradAppear) {

        return;
    }
    _isKboradAppear = YES;
    
    CGRect kb_frame   = [notifi.userInfo[@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];
    _oldFrame = _mainContainerView.frame;

    _mainContainerView.transform = CGAffineTransformMakeTranslation(0, -kb_frame.size.height+160);
    
}

- (void)keyboradWillDisappear:(NSNotification *)notifi {
    _isKboradAppear = NO;
    _mainContainerView.transform = CGAffineTransformMakeTranslation(0, 0);
    
}

- (void)keyboradDidAppear:(NSNotification *)notifi {
    if (_nameField.editing) {
        [_nameField selectAll:self];
    }
}

#pragma mark - 文本框Delegate
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    [UIView animateWithDuration:0.5 animations:^{
        CGFloat x      = _historyUserDropList.origin.x;
        CGFloat y      = _historyUserDropList.origin.y;
        CGFloat width  = _historyUserDropList.width;
        CGRect frame = CGRectMake(x, y, width, 0);
        _historyUserDropList.frame = frame;
    }];
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField reason:(UITextFieldDidEndEditingReason)reason {
    if (textField.tag == 111) {
        if (![textField.text isValidPhoneNumber] && textField.text.length>0) {
            // 手机号格式不正确
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.containerView animated:YES];
            hud.labelText = @"请输入正确的手机号";
            hud.mode = MBProgressHUDModeText;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1.5 * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                // Do something...
                textField.text = @"";
                [MBProgressHUD hideHUDForView:self.containerView animated:YES];
            });
        }
    }
}

#pragma mark 文本框rightview点击事件
- (IBAction)pwdFieldRightViewClicked:(UIButton *)sender {
    EZLog(@"pwd click");
    self.passWordField.secureTextEntry = sender.selected;
    if (!sender.selected) {
        self.passWordField.rightView   = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"see"]];
    }
    else {
        self.passWordField.rightView   = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nosee"]];
    }
    sender.selected = !sender.selected;
    
}

- (IBAction)rememberPwdClicked:(UIButton *)sender {
    sender.selected = !sender.selected;
}



@end

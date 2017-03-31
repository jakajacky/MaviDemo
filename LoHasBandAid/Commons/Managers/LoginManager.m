//
//  LoginManager.m
//  Mavic
//
//  Created by zhangxiaoqiang on 2017/3/30.
//  Copyright © 2017年 LoHas-Tech. All rights reserved.
//

#import "LoginManager.h"

@implementation LoginManager

- (User *)getLastUserInfo {
    User *user = [[User alloc] init];
    user.userName = @"18515982821";
    user.password = @"123456";
    user.isLatestLogin = YES;
    
    return user;
}

@end

//
//  LoginManager.m
//  Mavic
//
//  Created by zhangxiaoqiang on 2017/3/30.
//  Copyright © 2017年 LoHas-Tech. All rights reserved.
//

#import "LoginManager.h"
#import "LoginApi.h"

@implementation LoginManager

static LoginManager *loginM = nil;

+ (instancetype)defaultManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        loginM = [[self alloc] init];
    });
    return loginM;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    @synchronized (self) {
        if (!loginM) {
            loginM = [super allocWithZone:zone];
        }
        return loginM;
    }
}

- (id)copyWithZone:(NSZone *)zone {
    return self;
}

- (void)getLastUserInfo {
    LoginApi *api = [LoginApi biz];
    _currentUser = [api getCurrentUserFormMainDB];
}

@end

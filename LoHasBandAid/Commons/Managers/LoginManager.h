//
//  LoginManager.h
//  Mavic
//
//  Created by zhangxiaoqiang on 2017/3/30.
//  Copyright © 2017年 LoHas-Tech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoginEntities.h"

@interface LoginManager : NSObject

- (User *)getLastUserInfo;

@end

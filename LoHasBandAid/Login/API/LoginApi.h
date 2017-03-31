//
//  LoginApi.h
//  Mavic
//
//  Created by zhangxiaoqiang on 2017/3/31.
//  Copyright © 2017年 LoHas-Tech. All rights reserved.
//

#import "DCBiz.h"
#import "LoginEntities.h"

@interface LoginApi : DCBiz

- (void)loginWithUserName:(NSString *)name pwd:(NSString *)password completion:(void(^)(BOOL, id, NSString *))complete;


- (void)saveCurrentUser:(User *)user;


- (User *)getCurrentUserFormMainDB;

- (NSArray *)getUsersFormMainDB;
@end

//
//  LoginEntities.h
//  Mavic
//
//  Created by zhangxiaoqiang on 2017/3/30.
//  Copyright © 2017年 LoHas-Tech. All rights reserved.
//

#import "DCObject.h"
#import "DCDatabaseObject.h"
@interface User : DCDatabaseObject

@property (copy) NSString *userName;
@property (copy) NSString *password;
@property (copy) NSString *phoneNumber;
@property        BOOL      isLatestLogin;

@end


/**
 *  此类对应的数据表，只保存一条记录，保存时注意清空原记录
 */
@interface LatestLoginTime : DCDatabaseObject

@property (nonatomic) long long authTime;
@property (nonatomic) long long onlineLoginTime;
@property (nonatomic) long long offlineLoginTime;

@end

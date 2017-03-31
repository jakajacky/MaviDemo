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


@property (copy) NSString *password;

@property        BOOL     isLatestLogin;
@property        BOOL     isRememberPwd;

@property (copy) NSString *Id;//" : "149077228125127828",
@property (copy) NSString *login_name;//" : "18515982821",
@property (copy) NSString *mobile;//" : "18515982821",
@property        NSInteger is_del;//" : 0,
@property (copy) NSString *create_by;//" : "-1",
@property (copy) NSString *create_date;//" : "2017-03-29 15:24:41",
@property (copy) NSString *update_by;//" : "-1",
@property (copy) NSString *update_date;//" : "2017-03-29 15:25:04",
@property (copy) NSString *gender;//" : "男",
@property        NSInteger age;//" : 43,
@property        NSInteger height;//" : 170,
@property        NSInteger weight;//" : 70,
@property (copy) NSString *smoking_freq;//" : "0",
@property        NSInteger is_training;//" : 0,
@property        NSInteger is_medi_history;//" : 0,
@property (copy) NSString *habits;//" : "3,",
@property        NSInteger is_long_sit_rmd;//" : 0,
@property        NSInteger is_call_rmd;//" : 0,
@property (copy) NSString *birth;//" : "1974-01-01",
@property (copy) NSString *app_KEY;//" : 149077228125127828,
@property (copy) NSString *app_TOKEN;//" : "bdwA-z3gw-DkP8-4xd3"

@end


/**
 *  此类对应的数据表，只保存一条记录，保存时注意清空原记录
 */
@interface LatestLoginTime : DCDatabaseObject

@property (nonatomic) long long authTime;
@property (nonatomic) long long onlineLoginTime;
@property (nonatomic) long long offlineLoginTime;

@end

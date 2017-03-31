//
//  LoginApi.m
//  Mavic
//
//  Created by zhangxiaoqiang on 2017/3/31.
//  Copyright © 2017年 LoHas-Tech. All rights reserved.
//

#import "LoginApi.h"
#import "DCHttpRequest.h"

@interface LoginApi ()
{
    NSDictionary *params;
}
@property (nonatomic, strong) DCHttpRequest *request;
@property (nonatomic, strong) DCDatabase *mainDatabase;

@end

@implementation LoginApi

- (void)loginWithUserName:(NSString *)name pwd:(NSString *)password completion:(void(^)(BOOL, id, NSString *))complete {
    params = @{@"login_name" : name,
               @"password"   : password};
    [self loadRequestProperties];
    
    [self.request startWithSuccess:^(id result) {
        complete(YES, result, @"");
        
    } failure:^(NSInteger errCode, NSString *errMsg, NSDictionary *userInfo) {
        complete(NO, userInfo,errMsg);
    }];
}



- (void)loadRequestProperties
{
    [self.request cancelRequest];
    
    self.request.type    = DCHttpRequestTypePOST;
    self.request.baseUrl = BASE_URL;
    self.request.method  = @"auth/login";
    self.request.params  = params;
    
    self.request.allowsLogMethod       = kLogEnabled;
    self.request.allowsLogHeader       = kHttpRequestAllowsLogHeader;
    self.request.allowsLogResponseGET  = kHttpRequestAllowsLogResponseGET;
    self.request.allowsLogResponsePOST = kHttpRequestAllowsLogResponsePOST;
    self.request.allowsLogRequestError = kHttpRequestAllowsLogRequestError;
    
    [self.request setValue:ACCESS_TOKEN
        forHTTPHeaderField:@"ACCESS_TOKEN"];
    [self.request setValue:@"application/json"
        forHTTPHeaderField:@"Content-Type"];
    
    
    
}

- (DCHttpRequest *)request {
    if (!_request) {
        _request = [[DCHttpRequest alloc] init];
    }
    return _request;
}

#pragma mark 数据库操作
- (void)saveCurrentUser:(User *)user {
    self.mainDatabase.allowsLogError = YES;
    self.mainDatabase.allowsLogStatement = YES;
    [self.mainDatabase updateObjects:@[user]];
}

- (User *)getCurrentUserFormMainDB {
    NSString *sql = [NSString stringWithFormat:
                     @"SELECT * FROM %@ WHERE isLatestLogin = ?",
                     [User tableName]];
    
    NSArray *result = [self.mainDatabase query:sql withArguments:@[@YES] convertTo:[User class]];
    
    return result.firstObject;
}

- (DCDatabase *)mainDatabase {
    return [self database:@"main.db" withKey:@"1234567890ABCDEF"];
}

@end

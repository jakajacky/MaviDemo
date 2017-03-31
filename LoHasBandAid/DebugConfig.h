//
//  DebugConfig.h
//  Mavic
//
//  Created by zhangxiaoqiang on 2017/3/30.
//  Copyright © 2017年 LoHas-Tech. All rights reserved.
//

#ifndef DebugConfig_h
#define DebugConfig_h

#ifdef DEBUG

#define EZLog(...) NSLog(__VA_ARGS__)
#else
#define EZLog(...)
#endif


#define kLogEnabled      1
#define kIConsoleEnabled 0

#if kLogEnabled
#if kIConsoleEnabled
#import "iConsole.h"
#define NSLog(fmt, ...) [iConsole log:(fmt),##__VA_ARGS__]
#endif
#else
#define NSLog(fmt, ...)
#endif

/**
 *  HttpRequest Configs
 */
#define kHttpRequestAllowsLogMethod       YES
#define kHttpRequestAllowsLogHeader       YES

#define kHttpRequestAllowsLogResponseGET  YES
#define kHttpRequestAllowsLogResponsePOST YES
#define kHttpRequestAllowsLogResponseHEAD YES

#define kHttpRequestAllowsLogRequestError YES


#endif /* DebugConfig_h */

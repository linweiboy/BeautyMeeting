//
//  Logging.h
//  
//
//  Created by vinsent on 16/12/7.
//  Copyright © 2016年 vint. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Aspects.h"

static NSString *LoggingTrackedEvents = @"LoggingTrackedEvents";
static NSString *LoggingEventName = @"LoggingEventName";
static NSString *LoggingDescribe = @"LoggingDescribe";
static NSString *LoggingSelectorName = @"LoggingSelectorName";

@interface Logging : NSObject

+ (void)setupWithConfiguration;

///打开数据库
+ (void)openSqlite;
///序列化数据库数据
+ (NSDictionary *)serilizationSQLite;
///删除数据库数据
+ (void) deleteSQLiteData;
//关闭数据库
+ (void)closeSQLite;
@end

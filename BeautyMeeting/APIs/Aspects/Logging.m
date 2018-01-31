//
//  Logging.m
//
//
//  Created by vinsent on 16/12/7.
//  Copyright © 2016年 vint. All rights reserved.
//

#import "Logging.h"
#import "BeautyMeeting-Swift.h"
#import <sqlite3.h>


#define TABLENAME @"personinfo"
#define PAGENAME @"pageName"
#define PAGEDESCRIBE @"pageDescribe"
#define PAGESTARTTIME @"pageStartTime"
#define PAGEENDTIME @"pageEndTime"
#define PAGEWAITETIME @"pageWaiteTime"


@import UIKit;

NSDate *inDate;
sqlite3 *db;

@implementation Logging


+ (void)setupWithConfiguration{
    NSDictionary *configs = [self dictionaryFromUserStatisticsConfigPlist];
    for (NSString *classN in configs) {
        //获取命名空间
        NSString *nameSpace = [NSBundle mainBundle].infoDictionary[@"CFBundleExecutable"];
        NSString *targetName =[NSString stringWithFormat:@"%@.",nameSpace];
        NSString *className = [NSString stringWithFormat:@"%@%@",targetName,classN];
        Class clazz = NSClassFromString(className);
        NSDictionary *config = configs[classN];
        if (config[LoggingTrackedEvents]) {
            for (NSDictionary *event in config[LoggingTrackedEvents]) {
                SEL selector = NSSelectorFromString(event[LoggingSelectorName]);
                [clazz aspect_hookSelector:selector
                               withOptions:AspectPositionAfter
                                usingBlock:^(id<AspectInfo> aspectInfo) {
                                    //记录时间
                                    NSDate *date = [NSDate date];
                                    if ([event[LoggingEventName] isEqual:@"进入"]) {
                                        inDate = date;
                                    }
                                    if ([event[LoggingEventName]  isEqual: @"离开"]) {
                                        if (![inDate isEqual:@""]) {
                                            NSTimeInterval waitTime = [date timeIntervalSinceDate:inDate];
                                            if (waitTime > 1) {
                                                UIViewController *vc = aspectInfo.instance;
                                                NSString *pageName;
                                                if (vc.navigationItem.title) {
                                                    pageName = vc.navigationItem.title;
                                                }
                                                
                                                NSString *waitDateStr = [NSString stringWithFormat:@"%ds",[[NSString stringWithFormat:@"%f",waitTime] intValue]];

                                                //打开数据库
                                                [self openSqlite];
                                                //创建表格及字段
                                                NSString *sqlCreateTable = @"CREATE TABLE IF NOT EXISTS PERSONINFO (ID INTEGER PRIMARY KEY AUTOINCREMENT, pageName TEXT, pageDescribe TEXT, pageStartTime TEXT, pageEndTime TEXT, pageWaiteTime TEXT)";
                                                [self execSql:sqlCreateTable];
                                                
                                                //插入数据
                                                NSString *sql1 = [NSString stringWithFormat:
                                                                  @"INSERT INTO '%@' ('%@', '%@', '%@', '%@', '%@') VALUES ('%@', '%@', '%@', '%@', '%@')",
                                                                  TABLENAME,PAGENAME, PAGEDESCRIBE, PAGESTARTTIME, PAGEENDTIME, PAGEWAITETIME, pageName, event[LoggingDescribe], [self dateStringWith:inDate], [self dateStringWith:date], waitDateStr];
                                                [self execSql:sql1];
                                                
                                                sqlite3_close(db);
                                            }
                                        }
                                    }
                                } error:NULL];
            }
        }
    }
}

//创建数据库
+ (void)openSqlite {
    NSString *database_path = [self getDbPath];
    if (sqlite3_open([database_path UTF8String], &db) != SQLITE_OK) {
        sqlite3_close(db);
    }
}

+ (NSString *)getDbPath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documents = [paths objectAtIndex:0];
    NSString *database_path = [documents stringByAppendingPathComponent:@"personinfo.sqlite"];
    return database_path;
}

//执行sqlite语句
+ (void)execSql:(NSString *)sql {
    char *err;
    if (sqlite3_exec(db, [sql UTF8String], NULL, NULL, &err) != SQLITE_OK) {
        sqlite3_close(db);
    }
}

//查询数据库并序列化
+ (NSDictionary *)serilizationSQLite {
    
    NSMutableDictionary *paraDic = [NSMutableDictionary dictionary];
    NSMutableArray *jsonArr = [NSMutableArray array];
    
    NSString *updateSQL = @"select * from personinfo";
    sqlite3_stmt *ppStmt;
    
    int prepareResult =   sqlite3_prepare_v2(db, updateSQL.UTF8String, -1, &ppStmt, NULL);
    
    if(prepareResult == SQLITE_OK){
        while (sqlite3_step(ppStmt) == SQLITE_ROW) {
            
            NSMutableDictionary *jsonDic = [NSMutableDictionary dictionary];
            
            const unsigned char * pageName =  sqlite3_column_text(ppStmt, 1);
            const unsigned char * describe =  sqlite3_column_text(ppStmt, 2);
            const unsigned char * start =  sqlite3_column_text(ppStmt, 3);
            const unsigned char * endTime =  sqlite3_column_text(ppStmt, 4);
            const unsigned char * waitTime =  sqlite3_column_text(ppStmt, 5);

            jsonDic[@"pageName"] = [[NSString alloc] initWithUTF8String:(const char *)pageName];
            jsonDic[@"pageDescribe"] = [[NSString alloc] initWithUTF8String:(const char *)describe];
            jsonDic[@"pageStartTime"] = [[NSString alloc] initWithUTF8String:(const char *)start];
            jsonDic[@"pageEndTime"] = [[NSString alloc] initWithUTF8String:(const char *)endTime];
            jsonDic[@"pageWaiteTime"] = [[NSString alloc] initWithUTF8String:(const char *)waitTime];
            jsonDic[@"device"] = [self currentDevice];
            
            [jsonArr addObject:jsonDic];
            
        }
        NSDictionary *para = @{@"data" : jsonArr};
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:para options:0 error:nil];
        NSString *JsonStr = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        paraDic[@"operationJson"] = JsonStr;

        //释放sqlite3_stmt
        sqlite3_finalize(ppStmt);
    }
    return paraDic;
}

//关闭数据库
+ (void)closeSQLite {
    sqlite3_close(db);
}

//删除数据库
+ (void) deleteSQLiteData {
    NSString *dele = @"delete from personinfo";
    [self execSql:dele];
    NSString *dbPath = [self getDbPath];
    NSFileManager *manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:dbPath]) {
        [manager removeItemAtPath:dbPath error:NULL];
    }
}

+ (NSDictionary *)dictionaryFromUserStatisticsConfigPlist
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"FuncLog" ofType:@"plist"];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:filePath];
    return dic;
}

+ (NSString *)currentDate {
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSString *dateStr = [formatter stringFromDate:date];
    return dateStr;
}

+ (NSString *)dateStringWith: (NSDate *)date {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    return [formatter stringFromDate:date];
}

+ (NSString *)currentDevice {
    UIDevice *de = [UIDevice currentDevice];
    NSString *currentName = [de model];
    NSString *currentVersion = [de systemVersion];
    return [NSString stringWithFormat:@"%@-iOS%@",currentName,currentVersion];
}
@end

























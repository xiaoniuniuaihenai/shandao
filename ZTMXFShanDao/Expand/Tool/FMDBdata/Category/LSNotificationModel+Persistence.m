//
//  LSNotificationModel+Persistence.m
//  Himalaya
//
//  Created by 苏伟丽 on 16/8/20.
//  Copyright © 2016年 ala. All rights reserved.
//




/*
 极光推送本身带有相关的字段：
 title：  JPushInterface.EXTRA_NOTIFICATION_TITLE
 message：JPushInterface.EXTRA_ALERT
 extra：	 JPushInterface.EXTRA_EXTRA
 
 
 

 */
#import "LSNotificationModel+Persistence.h"

@implementation LSNotificationModel (Persistence)

+(BOOL)notification_insertArray:(NSArray *)array{
    NSMutableArray *marray =[[NSMutableArray alloc] init];
    for (LSNotificationModel *userinfo in array) {
        [marray addObject:[userinfo valueAndSqlTable:@"t_push"]];
    }
    
    return [FMDBHelper executeBatch2:marray useTransaction:YES];
}


/**
 *  获取通知信息列表
 *

 */
+(NSArray *)notifi_selectNotificationInfoList{
    NSString * userPone = [LoginManager userPhone];

    NSArray *array = [FMDBHelper query:@"t_push" where:[NSString stringWithFormat:@"userName ='%@' ORDER BY time DESC",userPone], nil];
    NSMutableArray *arrayModel= [[NSMutableArray alloc] init];
    if (array&&array.count>0) {
        
        for (NSDictionary *dic in array) {
            [arrayModel addObject:[LSNotificationModel notifi_notifiInfoWithDBDictionary:dic]];
        }
    }
    return arrayModel;
}
/**
 *  根据pid获取通知信息
 *

 */
+(LSNotificationModel *)notifi_selectNotificationInfoByPid:(NSString *)pid{
    NSString * userPone = [LoginManager userPhone];

    NSArray *array = [FMDBHelper query:@"t_push" where:[NSString stringWithFormat:@"userName ='%@' AND pid = '%@'",userPone,pid ], nil];
    LSNotificationModel *model = nil;
    if (array&&array.count>0) {
        NSDictionary *dic = array[0];
        model = [LSNotificationModel notifi_notifiInfoWithDBDictionary:dic];
    }
    return model;
}
/**
 *  所有未读消息个数
 *
 */
+(NSInteger )notifi_updateAllNumNotificationInfoNotRead
{
    NSString * userPone = [LoginManager userPhone];
    //    NSString * where = [NSString stringWithFormat:@"isRead = '0' AND userName ='%@'",userPone];
    //    NSInteger theNum =   [FMDBHelper totalRowOfTable:@"t_push" where:where];
    NSArray *array = [FMDBHelper query:@"t_push" where:[NSString stringWithFormat:@"isRead = '0' AND userName ='%@'",userPone], nil];
    //    theNum = array.count;
    //    return theNum;
    return array.count;
}
/**
 *  将未读消息变成已读
 *
 *
 */
+(BOOL)notifi_updateNotificationInfoNotReadWithCardCouponsPush
{
    NSString * userPone = [LoginManager userPhone];
    return [FMDBHelper update:[NSString stringWithFormat:@"UPDATE t_push SET isRead='1' WHERE userName ='%@'",userPone]];
    
}


+(LSNotificationModel *)notifi_notifiInfoWithPushDictionary:(NSDictionary *)dic{
    NSString * userPone = [LoginManager userPhone];

    LSNotificationModel *model = [[LSNotificationModel alloc] init];
    NSDictionary *dataDic = dic[@"aps"];
    model.pid = [NSString stringWithFormat:@"%@",dic[@"pid"]];
    model.title = [NSString stringWithFormat:@"%@",dic[@"title"]];
    model.time = [NSString stringWithFormat:@"%@",dic[@"time"]];
    model.message = [NSString stringWithFormat:@"%@",dataDic[@"alert"]];
    model.userName = [NSString stringWithFormat:@"%@",dic[@"userName"]?dic[@"userName"]:userPone];
    
    model.pushJumpType = [NSString stringWithFormat:@"%@",dic[@"pushJumpType"]];
    model.data = [NSString stringWithFormat:@"%@",dic[@"data"]];
    model.isRead = [NSString stringWithFormat:@"%@",dic[@"isRead"]?dic[@"isRead"]:@"0"];

    if ([[dic allKeys] containsObject:@"pushNoticeType"]) {
        model.pushNoticeType = [NSString stringWithFormat:@"%@",dic[@"pushNoticeType"]];

    }
    if ([[dic allKeys] containsObject:@"pushLandingPage"]) {
        model.pushLandingPage = [NSString stringWithFormat:@"%@",dic[@"pushLandingPage"]];
    }
    return model;
    
}

//自定义消息或者db数据库dic转化
+(LSNotificationModel *)notifi_notifiInfoWithDBDictionary:(NSDictionary *)dic{
    NSString * userPone = [LoginManager userPhone];

    LSNotificationModel *model = [[LSNotificationModel alloc] init];
    model.pid = [NSString stringWithFormat:@"%@",dic[@"pid"]];
    model.title = [NSString stringWithFormat:@"%@",dic[@"title"]?dic[@"title"]:@""];
    model.time = [NSString stringWithFormat:@"%@",dic[@"time"]?dic[@"time"]:[NSString stringWithFormat:@"%f",([NSDate date].timeIntervalSince1970*1000)]];
    model.userName =  [NSString stringWithFormat:@"%@",dic[@"userName"]?dic[@"userName"]:userPone];
    
    model.message = [NSString stringWithFormat:@"%@",dic[@"message"]?dic[@"message"]:(dic[@"content"]?dic[@"content"]:@"")];
    model.pushJumpType = [NSString stringWithFormat:@"%@",dic[@"pushJumpType"]];
    model.data = [NSString stringWithFormat:@"%@",dic[@"data"]];
    model.isRead = [NSString stringWithFormat:@"%@",dic[@"isRead"]?dic[@"isRead"]:@"0"];
    
    if ([[dic allKeys] containsObject:@"pushNoticeType"]) {
        model.pushNoticeType = [NSString stringWithFormat:@"%@",dic[@"pushNoticeType"]];
        
    }
    if ([[dic allKeys] containsObject:@"pushLandingPage"]) {
        model.pushLandingPage = [NSString stringWithFormat:@"%@",dic[@"pushLandingPage"]];
    }

    return model;
    
}

@end

//
//  LSNotificationModel+Persistence.h
//  Himalaya
//
//  Created by 苏伟丽 on 16/8/20.
//  Copyright © 2016年 ala. All rights reserved.
//

#import "LSNotificationModel.h"

@interface LSNotificationModel (Persistence)
+(BOOL)notification_insertArray:(NSArray *)array;
/**
 *  所有未读消息个数
 *
 */
+(NSInteger )notifi_updateAllNumNotificationInfoNotRead;
/**
 *  获取通知信息列表
 *
 
 */
+(NSArray *)notifi_selectNotificationInfoList;
/**
 *  将未读消息变成已读
 *
 *
 */
+(BOOL)notifi_updateNotificationInfoNotReadWithCardCouponsPush;
/**
 *  根据pid获取通知信息
 *
 
 */
+(LSNotificationModel *)notifi_selectNotificationInfoByPid:(NSString *)pid;

+(LSNotificationModel *)notifi_notifiInfoWithPushDictionary:(NSDictionary *)dic;
//自定义消息或者db数据库dic转化
+(LSNotificationModel *)notifi_notifiInfoWithDBDictionary:(NSDictionary *)dic;
@end

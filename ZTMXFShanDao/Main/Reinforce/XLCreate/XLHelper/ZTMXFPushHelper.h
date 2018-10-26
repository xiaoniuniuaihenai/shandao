//
//  ZTMXFPushHelper.h
//  ZTMXFXunMiaoiOS
//
//  Created by 陈传亮 on 2018/4/19.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LSNotificationModel;
@interface ZTMXFPushHelper : NSObject

/**
 极光推送  自定义消息
 */
+ (void)networkDidReceiveMessage:(NSNotification *)notification;
/**
 根据收到的推送做相应的处理
 */
+ (void)handlePushMessage:(NSDictionary *)userInfo click:(BOOL)isClick;
/**
 根据推送跳转到详情页
 */
+(void)pushDetailsPageWithNotificationModel:(LSNotificationModel *)notificationModel controller:(UIViewController *)viewController;
/**
 点击推送栏 跳转到详情页
 */
+(void)pushDetailsPageWithUserInfo:(NSDictionary *)userInfo;

@end

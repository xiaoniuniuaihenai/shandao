//
//  LSMessageManager.h
//  ZTMXFXunMiaoiOS
//
//  Created by 朱吉达 on 2018/1/18.
//  Copyright © 2018年 LSCredit. All rights reserved.
//  消息中心跳转类型

#import <Foundation/Foundation.h>

@interface LSMessageManager : NSObject
+(void)messagePushViewControllerWithMsgModel:(LSNotificationModel *)notModel;
@end

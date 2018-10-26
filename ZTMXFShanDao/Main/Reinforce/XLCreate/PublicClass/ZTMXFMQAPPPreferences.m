//
//  ZTMXFMQAPPPreferences.m
//  ZTMXFXunMiaoiOS
//
//  Created by 陈传亮 on 2018/3/27.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "ZTMXFMQAPPPreferences.h"
#import "UIViewController+Visible.h"
@implementation ZTMXFMQAPPPreferences

+(void)userNotificationSettings
{
    UIUserNotificationSettings *setting = [[UIApplication sharedApplication] currentUserNotificationSettings];
    if (UIUserNotificationTypeNone == setting.types) {
        NSLog(@"推送关闭");
        int num = arc4random() % 10;
        if (num == 5) {
            
        }
    }else{
        NSLog(@"推送打开");
    }
}
/**
 去设置页面
 */
+(void)openSet
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
}


@end

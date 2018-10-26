//
//  ZTMXFMQAPPPreferences.h
//  ZTMXFXunMiaoiOS
//
//  Created by 陈传亮 on 2018/3/27.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZTMXFMQAPPPreferences : NSObject
/**
 查看通知权限
 */
+(void)userNotificationSettings;
/**
 去设置页面
 */
+(void)openSet;
/**
 查看相册权限
 */
+(void)checkPhotoAlbumPermissions;

/**
 查看相机权限
 */
+(void)checkCameraPermissions;

@end

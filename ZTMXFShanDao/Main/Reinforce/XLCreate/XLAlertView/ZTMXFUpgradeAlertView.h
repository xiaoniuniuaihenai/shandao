//
//  ZTMXFUpgradeAlertView.h
//  ZTMXFXunMiaoiOS
//
//  Created by 陈传亮 on 2018/4/20.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum : NSUInteger {
    XLUpgradeAlertDefault,        // 不强制
    XLPermissionsForce,          //  强制
    
} XLUpgradeAlertType;

@interface ZTMXFUpgradeAlertView : UIView
/**
 message:更新内容
 version:最新版本号
 upgradeAlertType: 是否强制更新
 appUrlStr:app跳转路径
 */
+(void)showWithMessageArr:(NSArray *)messageArr version:(NSString *)version upgradeAlertType:(XLUpgradeAlertType)upgradeAlertType appUrlStr:(NSString *)appUrlStr;

@end

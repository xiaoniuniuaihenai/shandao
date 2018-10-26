//
//  ALAUpgradeAlert.h
//  ALAFanBei
//
//  Created by Ryan on 2017/8/18.
//  Copyright © 2017年 讯秒. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZTMXFALAUpgradeAlert : NSObject

//强制升级
+ (void)showForceUpgradeAlertWithMessage:(NSArray *)message
                      version:(NSString *)version
                 confirmBlock:(void(^)())confirmBlock;

//非强制更新
+ (void)showNormalUpgradeAlertWithMessage:(NSArray *)message
                       version:(NSString *)version
                  confirmBlock:(void(^)())confirmBlock
                   cancelBlock:(void(^)())cancelBlock;

@end

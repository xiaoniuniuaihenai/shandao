//
//  ZTMXFPermissionsAlertView.h
//  ZTMXFXunMiaoiOS
//
//  Created by 陈传亮 on 2018/4/18.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import <UIKit/UIKit.h>

//  借钱类型
typedef enum : NSUInteger {
    XLPermissionsCamera,        // 相机
    XLPermissionsPhoto,          //  相册
    XLPermissionsGPS,           //  位置
    XLPermissionsetwork,         //  网络
    XLPermissionsLoanFailure,    //  借钱失败
} XLPermissionsType;

typedef void(^clickHandle)(void);

@interface ZTMXFPermissionsAlertView : UIView


+ (void)showAlert:(XLPermissionsType)permissionsType Click:(clickHandle)click;

+ (void)showAlert:(XLPermissionsType)permissionsType ErrorMessage:(NSString *)message Click:(clickHandle)click;
@end

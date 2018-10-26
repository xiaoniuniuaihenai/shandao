//
//  SVProgressHUD+addition.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/9/21.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "SVProgressHUD.h"

typedef void(^completeLoading)(void);

@interface SVProgressHUD (addition)

/** 有蒙版只显示加载loading */
+ (void)showLoading;
/** 有蒙版的加载 */
+ (void)showLoadingWithText:(NSString *)text;

/** 没有蒙版只显示加载loading */
+ (void)showLoadingWithOutMask;
/** 没有蒙版的加载 */
+ (void)showLoadingWithOutMaskText:(NSString *)text;

/** 几秒后自动消失 */
+ (void)dismissAfterDuration:(NSTimeInterval)duration mask:(BOOL)mask complete:(completeLoading)complete;


@end

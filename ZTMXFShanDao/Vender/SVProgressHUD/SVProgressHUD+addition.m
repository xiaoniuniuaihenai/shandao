//
//  SVProgressHUD+addition.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/9/21.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "SVProgressHUD+addition.h"

@implementation SVProgressHUD (addition)

/** 几秒后自动消失 */
+ (void)dismissAfterDuration:(NSTimeInterval)duration mask:(BOOL)mask complete:(completeLoading)complete{
    if (mask) {
        [self showLoading];
    } else {
        [self showLoadingWithOutMask];
    }
    if (duration <= 0) {
        duration = 1;
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (complete) {
            complete();
        }
        [SVProgressHUD dismiss];
    });
}

/** 有蒙版只显示加载loading */
+ (void)showLoading{
    [self showLoadingWithMaskType:SVProgressHUDMaskTypeClear loadingText:nil];
}
/** 有蒙版的加载 */
+ (void)showLoadingWithText:(NSString *)text{
    [self showLoadingWithMaskType:SVProgressHUDMaskTypeClear loadingText:text];
}

/** 没有蒙版只显示加载loading */
+ (void)showLoadingWithOutMask{
    [self showLoadingWithMaskType:SVProgressHUDMaskTypeNone loadingText:nil];
}
/** 没有蒙版的加载 */
+ (void)showLoadingWithOutMaskText:(NSString *)text{
    [self showLoadingWithMaskType:SVProgressHUDMaskTypeNone loadingText:text];
}

+ (void)showLoadingWithMaskType:(SVProgressHUDMaskType)maskType loadingText:(NSString *)text{
    
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeFlat];

    //  设置转圈图片的半径(不显示文字text时候)
    [SVProgressHUD setRingNoTextRadius:10.0];
    //  设置背景view的圆角
    [SVProgressHUD setCornerRadius:4.0];
    //  设置转圈图片的宽度
    [SVProgressHUD setRingThickness:2];
    //  设置转圈图片的半径(显示文字text的时候)
    [SVProgressHUD setRingRadius:10];
    
    // 设置自定义的样式(设置下面两个自定义)
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    //  设置转圈的颜色和字体的颜色
    [SVProgressHUD setForegroundColor:[UIColor colorWithRed:213.0 / 255.0 green:35.0 / 255.0 blue:55.0 / 255.0 alpha:1.0]];
    //  设置背景颜色
    [SVProgressHUD setBackgroundColor:[UIColor colorWithRed:220.0 / 255.0 green:220.0 / 255.0 blue:220.0 / 255.0 alpha:1.0]];
    [SVProgressHUD setFont:[UIFont systemFontOfSize:11]];

    
    //  设置自定义蒙版
    if (maskType) {
        [SVProgressHUD setDefaultMaskType:maskType];
    } else {
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    }
    
    if (text) {
        [SVProgressHUD showWithStatus:text];
    } else {
        [SVProgressHUD showWithStatus:@"加载中..."];
    }
}

@end

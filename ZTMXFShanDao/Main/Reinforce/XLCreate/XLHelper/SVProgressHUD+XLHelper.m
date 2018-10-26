//
//  SVProgressHUD+XLHelper.m
//  ZTMXFXunMiaoiOS
//
//  Created by 陈传亮 on 2018/5/22.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "SVProgressHUD+XLHelper.h"
#import "UIImage+GIF.h"
#import "UIImage+FX.h"

@implementation SVProgressHUD (XLHelper)


+(void)showXLHelperHUD
{
    // 设置显示最小时间 以便观察效果
    [SVProgressHUD setMinimumDismissTimeInterval:30];
    //    // 设置背景颜色为透明色
    [SVProgressHUD setImageViewSize:CGSizeMake(60, 60)];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    [SVProgressHUD setBackgroundColor:[UIColor clearColor]];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    UIImage * image = [[UIImage alloc] init];
    image = [UIImage sd_animatedGIFNamed:@"loading"];
    image = [image imageWithCornerRadius:3];
    [SVProgressHUD showImage:image status:@""];
}




@end

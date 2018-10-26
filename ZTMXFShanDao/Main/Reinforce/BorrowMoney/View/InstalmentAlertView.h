//
//  InstalmentAlertView.h
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2017/12/14.
//  Copyright © 2017年 LSCredit. All rights reserved.
//  分期明细

#import <UIKit/UIKit.h>

@interface InstalmentAlertView : UIView

- (instancetype)initWithInstalmentDays:(NSString *)days amountMoney:(CGFloat)amount;

-(void)show;

@end

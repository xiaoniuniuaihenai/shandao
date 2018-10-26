//
//  LSRealNameProgressView.h
//  ZTMXFXunMiaoiOS
//
//  Created by Try on 2017/9/18.
//  Copyright © 2017年 LSCredit. All rights reserved.
//  认证进度

#import <UIKit/UIKit.h>

@interface LSRealNameProgressView : UIView
-(instancetype)initWithProgress;
//进度
-(void)updateProgressViewFloatValue:(CGFloat)pgValue;
@end

//
//  UIButton+Administer.h
//  ZTMXFXunMiaoiOS
//
//  Created by 朱吉达 on 2017/10/18.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Administer)
//  设置边框虚线
-(CAShapeLayer*)setupViewDotWdith:(CGFloat)width dotColor:(UIColor *)color fullLineWidth:(CGFloat)fullWidth blankWidth:(CGFloat)blankWidth;
@end

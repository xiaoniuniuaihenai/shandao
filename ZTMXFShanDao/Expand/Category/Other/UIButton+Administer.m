//
//  UIButton+Administer.m
//  ZTMXFXunMiaoiOS
//
//  Created by 朱吉达 on 2017/10/18.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "UIButton+Administer.h"

@implementation UIButton (Administer)
//  设置边框虚线
-(CAShapeLayer*)setupViewDotWdith:(CGFloat)width dotColor:(UIColor *)color fullLineWidth:(CGFloat)fullWidth blankWidth:(CGFloat)blankWidth
{
    CAShapeLayer *border = [CAShapeLayer layer];
    border.strokeColor = color.CGColor;
    border.fillColor = nil;
    border.path = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
    border.frame = self.bounds;
    border.lineWidth = width;
    border.lineCap = @"square";
    if (fullWidth < 1.0) {
        fullWidth = 1.0;
    }
    if (blankWidth < 2.0) {
        blankWidth = 2.0;
    }
    NSNumber *fullwidthNum = [NSNumber numberWithFloat:fullWidth];
    NSNumber *blankwidthNum = [NSNumber numberWithFloat:blankWidth];
    border.lineDashPattern = @[fullwidthNum, blankwidthNum];
    [self.layer addSublayer:border];
    return border;
}
@end

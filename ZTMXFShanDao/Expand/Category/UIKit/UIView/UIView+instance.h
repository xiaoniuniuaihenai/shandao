//
//  UIView+instance.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/9/18.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (instance)

/** 创建一个view */
+ (UIView *)setupViewWithSuperView:(UIView *)superView withBGColor:(NSString *)colorStr;

/**
 ** lineView:       需要绘制成虚线的view
 ** lineLength:     虚线的宽度
 ** lineSpacing:    虚线的间距
 ** lineColor:      虚线的颜色
 **/
+ (void)drawDashLine:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor;
/**
 ** lineView:       需要绘制成虚线的view
 ** lineLength:     虚线的宽度
 ** lineSpacing:    虚线的间距
 ** lineColor:      虚线的颜色
 **/
+ (void)drawVerticalDashLine:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor;

//  绘制虚线
/**
 绘制虚线

 @param width 线宽
 @param color 虚线颜色
 @param fullWidth 空间距
 @param blankWidth 虚线宽度
 @param radius 圆角
 @return layer
 */
-(CAShapeLayer*)setupViewDotWdith:(CGFloat)width dotColor:(UIColor *)color fullLineWidth:(CGFloat)fullWidth blankWidth:(CGFloat)blankWidth radius:(CGFloat)radius;


/** 设置圆角view */
+ (UIView *)setupCircleViewWithColorStr:(NSString *)colorStr circleCorner:(CGFloat)corner;

@end

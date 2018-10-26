//
//  UIView+instance.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/9/18.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "UIView+instance.h"

@implementation UIView (instance)

/** 创建一个view */
+ (UIView *)setupViewWithSuperView:(UIView *)superView withBGColor:(NSString *)colorStr{
    UIView *view = [[UIView alloc] init];
    if (colorStr) {
        view.backgroundColor = [UIColor colorWithHexString:colorStr];
    } else {
        view.backgroundColor = [UIColor whiteColor];
    }
    [superView addSubview:view];
    return view;
}

/**
 ** lineView:       需要绘制成虚线的view
 ** lineLength:     虚线的宽度
 ** lineSpacing:    虚线的间距
 ** lineColor:      虚线的颜色
 **/
+ (void)drawDashLine:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor
{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:lineView.bounds];
    [shapeLayer setPosition:CGPointMake(CGRectGetWidth(lineView.frame) / 2, CGRectGetHeight(lineView.frame))];
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    //  设置虚线颜色为blackColor
    [shapeLayer setStrokeColor:lineColor.CGColor];
    //  设置虚线宽度
    [shapeLayer setLineWidth:CGRectGetHeight(lineView.frame)];
    [shapeLayer setLineJoin:kCALineJoinRound];
    //  设置线宽，线间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:lineLength], [NSNumber numberWithInt:lineSpacing], nil]];
    //  设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL,CGRectGetWidth(lineView.frame), 0);
    [shapeLayer setPath:path];
    CGPathRelease(path);
    //  把绘制好的虚线添加上来
    [lineView.layer addSublayer:shapeLayer];
}

/**
 ** lineView:       需要绘制成虚线的view 
 ** lineLength:     虚线的宽度
 ** lineSpacing:    虚线的间距
 ** lineColor:      虚线的颜色
 **/
+ (void)drawVerticalDashLine:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor
{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:lineView.bounds];
    
    [shapeLayer setPosition:CGPointMake(CGRectGetWidth(lineView.frame)/2., CGRectGetHeight(lineView.frame)/2.)];

    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    //  设置虚线颜色为blackColor
    [shapeLayer setStrokeColor:lineColor.CGColor];
    //  设置虚线宽度
    [shapeLayer setLineWidth:CGRectGetWidth(lineView.frame)];
    [shapeLayer setLineJoin:kCALineJoinRound];
    //  设置线宽，线间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:lineLength], [NSNumber numberWithInt:lineSpacing], nil]];
    //  设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL,0, CGRectGetHeight(lineView.frame));
    [shapeLayer setPath:path];
    CGPathRelease(path);
    //  把绘制好的虚线添加上来
    [lineView.layer addSublayer:shapeLayer];
}
/** 设置圆角view */
+ (UIView *)setupCircleViewWithColorStr:(NSString *)colorStr circleCorner:(CGFloat)corner{
    UIView *view = [[UIView alloc] init];
    UIColor *bgColor = [UIColor whiteColor];
    if (colorStr) {
        bgColor = [UIColor colorWithHexString:colorStr];
    }
    view.layer.cornerRadius = corner;
    view.backgroundColor = bgColor;
    return view;
}

//  设置边框虚线
-(CAShapeLayer*)setupViewDotWdith:(CGFloat)width dotColor:(UIColor *)color fullLineWidth:(CGFloat)fullWidth blankWidth:(CGFloat)blankWidth radius:(CGFloat)radius
{
    CAShapeLayer *border = [CAShapeLayer layer];
    border.strokeColor = color.CGColor;
    border.fillColor = nil;
    if (radius>0) {
        border.path = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:5].CGPath;

    }else{
            border.path = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
        
    }
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

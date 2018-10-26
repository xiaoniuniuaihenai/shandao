//
//  UIView+Administer.m
//  ZTMXFXunMiaoiOS
//
//  Created by 朱吉达 on 2017/9/25.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "UIView+Administer.h"

@implementation UIView (Administer)
///////////////////////////////////////////////////////////////////////////////////////////////////
/**
 * 移除当前视图下的所有子视图
 */
- (void)removeAllSubviews {
    while (self.subviews.count) {
        UIView* child = self.subviews.lastObject;
        [child removeFromSuperview];
    }
}
/**
 *  通过 CAShapeLayer 方式绘制虚线
 *
 *  param lineLength:     虚线的宽度
 *  param lineSpacing:    虚线的间距
 *  param lineColor:      虚线的颜色
 *  param lineDirection   虚线的方向  YES 为水平方向， NO 为垂直方向
 **/
- (void)drawLineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor lineDirection:(BOOL)isHorizonal {
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    
    [shapeLayer setBounds:self.bounds];
    
    if (isHorizonal) {
        
        [shapeLayer setPosition:CGPointMake(CGRectGetWidth(self.frame) / 2, CGRectGetHeight(self.frame))];
        
    } else{
        [shapeLayer setPosition:CGPointMake(CGRectGetWidth(self.frame) / 2, CGRectGetHeight(self.frame)/2)];
    }
    
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    //  设置虚线颜色为blackColor
    [shapeLayer setStrokeColor:lineColor.CGColor];
    //  设置虚线宽度
    if (isHorizonal) {
        [shapeLayer setLineWidth:CGRectGetHeight(self.frame)];
    } else {
        
        [shapeLayer setLineWidth:CGRectGetWidth(self.frame)];
    }
    [shapeLayer setLineJoin:kCALineJoinRound];
    //  设置线宽，线间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:lineLength], [NSNumber numberWithInt:lineSpacing], nil]];
    //  设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    
    if (isHorizonal) {
        CGPathAddLineToPoint(path, NULL,CGRectGetWidth(self.frame), 0);
    } else {
        CGPathAddLineToPoint(path, NULL, 0, CGRectGetHeight(self.frame));
    }
    
    [shapeLayer setPath:path];
    CGPathRelease(path);
    //  把绘制好的虚线添加上来
    [self.layer addSublayer:shapeLayer];
}
//  设置边框虚线
-(CAShapeLayer*)setupViewDotWdith:(CGFloat)width dotColor:(UIColor *)color fullLineWidth:(CGFloat)fullWidth blankWidth:(CGFloat)blankWidth
{
    CAShapeLayer *border = [CAShapeLayer layer];
    border.strokeColor = color.CGColor;
    border.fillColor = nil;
    border.path = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
    border.frame = self.bounds;
    border.cornerRadius = 5;
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

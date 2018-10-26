//
//  LSRefundProgress.m
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2017/11/20.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "LSRefundProgress.h"

#define BorderWidth 2

@interface LSRefundProgress ()

@property (nonatomic, assign) CGFloat lineWidth;//边框宽度

@property (nonatomic, assign) CGFloat progress;

@property (nonatomic, strong) CAShapeLayer *frontShapeLayer;
@property (nonatomic, strong) CAShapeLayer *backShapeLayer;
@property (nonatomic, strong) UIBezierPath *circleBezierPath;

@end

@implementation LSRefundProgress

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = frame.size.width/2.0f;
        self.layer.masksToBounds = true;
        
        self.lineWidth = BorderWidth;
    }
    return self;
}

-(void)drawRect:(CGRect)rect{
    
    CGFloat kWidth = rect.size.width;
    CGFloat kHeight = rect.size.height;
    
    if (!self.circleBezierPath){
        self.circleBezierPath = ({
            CGPoint pCenter = CGPointMake(kWidth * 0.5, kHeight * 0.5);
            CGFloat radius = MIN(kWidth, kHeight);
            radius = radius - self.lineWidth;
            UIBezierPath *circlePath = [UIBezierPath bezierPath];
            [circlePath addArcWithCenter:pCenter radius:radius * 0.5 startAngle:270 * M_PI / 180 endAngle:269 * M_PI / 180 clockwise:YES];
            [circlePath closePath];
            circlePath;
        });
    }
    
    if (!self.backShapeLayer) {
        self.backShapeLayer = ({
            CAShapeLayer *shapeLayer = [CAShapeLayer layer];
            shapeLayer.frame = rect;
            shapeLayer.path = self.circleBezierPath.CGPath;
            shapeLayer.fillColor = [UIColor clearColor].CGColor;
            shapeLayer.lineWidth = self.lineWidth;
            shapeLayer.strokeColor = self.minimumTrackTintColor.CGColor;
            shapeLayer.lineCap = kCALineCapRound;
            [self.layer addSublayer:shapeLayer];
            shapeLayer;
        });
    }
    
    if (!self.frontShapeLayer){
        self.frontShapeLayer = ({
            CAShapeLayer  *shapeLayer = [CAShapeLayer layer];
            shapeLayer.frame = rect;
            shapeLayer.path = self.circleBezierPath.CGPath;
            shapeLayer.fillColor = [UIColor clearColor].CGColor;
            shapeLayer.lineWidth = self.lineWidth;
            shapeLayer.strokeColor = self.maxmumTrackTintColor.CGColor;
            shapeLayer;
        });
        [self.layer addSublayer:self.frontShapeLayer];
    }
    
    [self startAnimationValue:self.progress];
}

- (void)startAnimationValue:(CGFloat)value{
    CABasicAnimation *pathAnima = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnima.duration = 1.0f;
    pathAnima.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pathAnima.fromValue = [NSNumber numberWithFloat:0.0f];
    pathAnima.toValue = [NSNumber numberWithFloat:value];
    pathAnima.fillMode = kCAFillModeForwards;
    pathAnima.removedOnCompletion = NO;
    [self.frontShapeLayer addAnimation:pathAnima forKey:@"strokeEndAnimation"];
}

- (void)setMinimumTrackTintColor:(UIColor *)minimumTrackTintColor{
    _minimumTrackTintColor = minimumTrackTintColor;
}

-(void)setMaxmumTrackTintColor:(UIColor *)maxmumTrackTintColor{
    _maxmumTrackTintColor = maxmumTrackTintColor;
}

- (void)setProgress:(CGFloat)progress{
    _progress = progress;
    [self setNeedsDisplay];
}

@end

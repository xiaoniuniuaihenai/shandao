//
//  LSWebProgressLayer.m
//  ALAFanBei
//
//  Created by yangpenghua on 2017/8/16.
//  Copyright © 2017年 讯秒. All rights reserved.
//

#import "LSWebProgressLayer.h"

static NSTimeInterval const kFastTimeInterval = 0.03;

@implementation LSWebProgressLayer
{
    NSTimer *_timer;
    CGFloat _plusWidth; ///< 增加点

}

+ (instancetype)layerWithFrame:(CGRect)frame{
    LSWebProgressLayer *layer = [self new];
    layer.frame = frame;
    
    return layer;
}

- (instancetype)init {
    if (self = [super init]) {
        [self initialize];
    }
    return self;
}

- (void)initialize {
    self.anchorPoint = CGPointMake(0, 0.5);
    self.lineWidth = 2;
    self.strokeColor = [UIColor colorWithHexString:@"FE963B"].CGColor;
    _timer = [NSTimer scheduledTimerWithTimeInterval:kFastTimeInterval target:self selector:@selector(pathChanged:) userInfo:nil repeats:YES];
    [self timerPause];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, 2)];
    [path addLineToPoint:CGPointMake(Main_Screen_Width, 2)];
    
    self.path = path.CGPath;
    self.strokeEnd = 0;
    _plusWidth = 0.01;
}


- (void)pathChanged:(NSTimer *)timer {
    if (self.strokeEnd >= 0.97) {
        [self timerPause];
        return;
    }
    
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    self.strokeEnd += _plusWidth;
    
    if (self.strokeEnd > 0.8) {
        _plusWidth = 0.001;
    }
    [CATransaction commit];
}



- (void)finishedLoad {
    [self closeTimer];
    
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    self.strokeEnd = 1.0;
    [CATransaction commit];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.hidden = YES;
        [self removeFromSuperlayer];
    });
}

- (void)dealloc {
    NSLog(@"progressView dealloc");
    [self closeTimer];
}
- (void)startLoad {
    [self resumeWithTimeInterval:kFastTimeInterval];
}
#pragma mark - private
- (void)closeTimer {
    [_timer invalidate];
    _timer = nil;
}

#pragma mark - timer 操作


- (void)timerResume {
    if (!_timer.isValid) return;
    [_timer setFireDate:[NSDate date]];
}

- (void)resumeWithTimeInterval:(NSTimeInterval)time {
    if (!_timer.isValid) return;
    [_timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:time]];
}
- (void)timerPause {
    if (!_timer.isValid) return;
    [_timer setFireDate:[NSDate distantFuture]];
}
@end

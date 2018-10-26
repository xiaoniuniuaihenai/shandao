//
//  LSProgressView.m
//  ZTMXFXunMiaoiOS
//
//  Created by 朱吉达 on 2017/10/31.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "LSProgressView.h"
@interface LSProgressView()
@property (nonatomic,strong) UIView * viProgressView;
@end
@implementation LSProgressView
-(instancetype)initWithFrame:(CGRect)frame{
    _trackTintColor = [UIColor colorWithHexString:COLOR_LIGHTBG_STR];
    _progressTintColor = [UIColor blackColor];
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.viProgressView];
        [_viProgressView setBackgroundColor:_progressTintColor];
    }
    return self;
}


-(void)setProgressTintColor:(UIColor *)progressTintColor{
    _progressTintColor = progressTintColor;
    [_viProgressView setBackgroundColor:_progressTintColor];
}
-(void)setTrackTintColor:(UIColor *)trackTintColor{
    _trackTintColor = trackTintColor;
    [self setBackgroundColor:_trackTintColor];
}
-(void)setProgress:(float)progress{
    _progress = progress;
    _viProgressView.top = 0;
    _viProgressView.left = 0;
    _viProgressView.width = progress*self.width;
}
-(UIView*)viProgressView{
    if (!_viProgressView) {
        _viProgressView = [[UIView alloc]init];
        [_viProgressView setFrame:CGRectMake(0, 0, 0, self.height)];
    }
    return _viProgressView;
}
- (void)setProgress:(float)progress animated:(BOOL)animated{
    _progress = progress;
    _viProgressView.top = 0;
    _viProgressView.left = 0;
    if (animated) {
        [UIView animateWithDuration:.2 animations:^{
            _viProgressView.width = progress*self.width;
        }];
    }else{
        _viProgressView.width = progress*self.width;
    }

}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [super drawRect:rect];
    _viProgressView.height = self.height;
    
//    CAGradientLayer *gradientLayer =  [CAGradientLayer layer];
//    gradientLayer.frame = _viProgressView.bounds;
//    [gradientLayer setColors:[NSArray arrayWithObjects:(id)[[UIColor colorWithHexString:@"f77c2f"] CGColor],(id)[[UIColor colorWithHexString:@"e8424e"] CGColor], nil]];
//    gradientLayer.startPoint = CGPointMake(0, 0);
//    gradientLayer.endPoint = CGPointMake(1,0);
//    [_viProgressView.layer addSublayer:gradientLayer];
//    _viProgressView.clipsToBounds = YES;
    
}


@end

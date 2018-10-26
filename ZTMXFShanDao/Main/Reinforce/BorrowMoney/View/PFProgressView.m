//
//  PFProgressView.m
//  ZBProgressView
//
//  Created by panfei mao on 2017/11/14.
//  Copyright © 2017年 xzb. All rights reserved.
//

#import "PFProgressView.h"
#import "LSBrwSatusInfoModel.h"
#import "LSRefundProgress.h"

@interface PFProgressView ()
{
    CADisplayLink *_disPlayLink;
    
    /**
     曲线的振幅
     */
    CGFloat _waveAmplitude;
    /**
     曲线角速度
     */
    CGFloat _wavePalstance;
    /**
     曲线初相
     */
    CGFloat _waveX;
    /**
     曲线偏距
     */
    CGFloat _waveY;
    
    /**
     曲线移动速度
     */
    CGFloat _waveMoveSpeed;
}

@property (nonatomic, assign) CGFloat progress;

@property (nonatomic, strong) UILabel *countDownLabel;
@property (nonatomic, strong) UILabel *daysLabel;

@property (nonatomic, strong) CAShapeLayer *waveLayer;

@property (nonatomic, strong) UIView *waveView;

@property (nonatomic, strong) LSRefundProgress *refundProgressView;

@end

@implementation PFProgressView

- (instancetype)initWithFrame:(CGRect)frame ProgressType:(LSProgressType)style{
    
    if (self) {
        self = [[PFProgressView alloc] initWithFrame:frame];
        
        _progressType = style;
        
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = frame.size.width/2.0f;
        self.layer.masksToBounds = true;
        
        if (style == LSOverdueType) {
//            self.backgroundColor = [UIColor colorWithHexString:COLOR_RED_STR];
            self.layer.borderWidth = 2;
            self.layer.borderColor = [UIColor colorWithRed:223.0/255 green:223.0/255 blue:223.0/255 alpha:1].CGColor;
            [self addSubview:self.waveView];
            _waveView.center = self.center;
        }else if (style == LSRefundType){
            [self addSubview:self.refundProgressView];
            _refundProgressView.center = self.center;
        }
        [self addSubview:self.countDownLabel];
        [self addSubview:self.daysLabel];
        
        self.countDownLabel.centerX = self.width/2.0;
        self.countDownLabel.centerY = self.height/2.0 - AdaptedWidth(10);
        
        self.daysLabel.centerX = _countDownLabel.centerX;
        self.daysLabel.centerY = self.height/2.0 + AdaptedWidth(10);
    }
    return self;
}

- (UIView *)refundProgressView{
    if (!_refundProgressView) {
        _refundProgressView = [[LSRefundProgress alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    }
    return _refundProgressView;
}

- (void)setMinimumTrackTintColor:(UIColor *)minimumTrackTintColor{
    _minimumTrackTintColor = minimumTrackTintColor;
    _refundProgressView.minimumTrackTintColor = minimumTrackTintColor;
}

-(void)setMaxmumTrackTintColor:(UIColor *)maxmumTrackTintColor{
    _maxmumTrackTintColor = maxmumTrackTintColor;
    _refundProgressView.maxmumTrackTintColor = maxmumTrackTintColor;
}

- (void)setBrwStatusInfo:(LSBrwSatusInfoModel *)brwStatusInfo{
    _brwStatusInfo = brwStatusInfo;
    
    NSString *dateStr;
    if (_brwStatusInfo.overdueStatus == 1) {
        //    逾期
        _countDownLabel.text = @"逾期";
        _countDownLabel.top = 10;
        [_countDownLabel setTextColor:[UIColor whiteColor]];
        dateStr = _brwStatusInfo.overdueDay;
        [self setProgress:1.0];
    }else{
        //    还款
        _countDownLabel.text = @"还剩";
        dateStr = _brwStatusInfo.deadlineDay;
        CGFloat progress = 1.0 - [_brwStatusInfo.deadlineDay floatValue] / [_brwStatusInfo.borrowDays floatValue];
        [self setProgress:progress];
    }
    if (dateStr.length<=0) {
//        防止后台给
        _daysLabel.text = @"0天";
        return;
    }
    NSMutableAttributedString *noteString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@天",dateStr]];
    [noteString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:[[NSString stringWithFormat:@"%@天",dateStr] rangeOfString:dateStr]];
    [_daysLabel setAttributedText: noteString];
}

- (void)setProgress:(CGFloat)progress{
    _progress = progress;
    [_refundProgressView setProgress:progress];
}

- (UILabel *)countDownLabel{
    if (!_countDownLabel) {
        _countDownLabel = [UILabel labelWithTitleColor:[UIColor colorWithHexString:COLOR_LIGHT_STR] fontSize:13 alignment:NSTextAlignmentCenter];
        _countDownLabel.frame = CGRectMake(0, 0, 30, 20);
    }
    return _countDownLabel;
}

- (UILabel *)daysLabel{
    if (!_daysLabel) {
        _daysLabel = [UILabel labelWithTitleColor:[UIColor colorWithHexString:@"4c4c4c"] fontSize:14 alignment:NSTextAlignmentCenter];
        _daysLabel.frame = CGRectMake(0, 0, 40, 20);
    }
    return _daysLabel;
}

- (UIView *)waveView{
    if (!_waveView) {
        _waveView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width-2, self.height-2)];
        _waveView.backgroundColor = [UIColor colorWithHexString:COLOR_RED_STR];
        _waveView.layer.cornerRadius = _waveView.width/2.0f;
        _waveView.layer.masksToBounds = true;
        [_waveView.layer addSublayer:self.waveLayer];
    }
    return _waveView;
}

- (CAShapeLayer *)waveLayer{
    if (!_waveLayer) {
        _waveLayer = [CAShapeLayer layer];
        _waveLayer.fillColor = [UIColor whiteColor].CGColor;
        _waveLayer.strokeColor = [UIColor clearColor].CGColor;
        
        [self buildData];
    }
    return _waveLayer;
}

//初始化数据
-(void)buildData
{
    //振幅
    _waveAmplitude = 8;
    //角速度
    _wavePalstance = M_PI/self.bounds.size.width;
    //偏距
    _waveY = self.bounds.size.height;
    //初相
    _waveX = 0;
    //x轴移动速度
    _waveMoveSpeed = _wavePalstance * 1;
    //以屏幕刷新速度为周期刷新曲线的位置
    _disPlayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateWave:)];
    [_disPlayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

-(void)updateWave:(CADisplayLink *)link
{
    _waveX += _waveMoveSpeed;
    [self updateWaveY];
    [self updateWave];
}

//更新偏距的大小 直到达到目标偏距 让wave有一个匀速增长的效果
-(void)updateWaveY
{
    CGFloat targetY = self.bounds.size.height - 0.6 * self.bounds.size.height;
    if (_waveY < targetY) {
        _waveY += 2;
    }
    if (_waveY > targetY ) {
        _waveY -= 2;
    }
}

-(void)updateWave
{
    //波浪宽度
    CGFloat waterWaveWidth = self.bounds.size.width;
    //初始化运动路径
    CGMutablePathRef path = CGPathCreateMutable();
    //设置起始位置
    CGPathMoveToPoint(path, nil, 0, _waveY);
    //初始化波浪其实Y为偏距
    CGFloat y = _waveY;
    //正弦曲线公式为： y=Asin(ωx+φ)+k;
    for (float x = 0.0f; x <= waterWaveWidth ; x++) {
        y = _waveAmplitude * cos(_wavePalstance * x + _waveX) + _waveY;
        CGPathAddLineToPoint(path, nil, x, y);
    }
    //填充底部颜色
    CGPathAddLineToPoint(path, nil, waterWaveWidth, self.bounds.size.height);
    CGPathAddLineToPoint(path, nil, 0, self.bounds.size.height);
    CGPathCloseSubpath(path);
    _waveLayer.path = path;
    CGPathRelease(path);
}

-(void)stop
{
    if (_disPlayLink) {
        [_disPlayLink invalidate];
        _disPlayLink = nil;
    }
}

-(void)dealloc
{
    [self stop];
    if (_waveLayer) {
        [_waveLayer removeFromSuperlayer];
        _waveLayer = nil;
    }
}

@end

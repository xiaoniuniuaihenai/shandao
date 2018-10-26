//
//  LSIndicatorView.m
//  tryTest
//
//  Created by 朱吉达 on 2017/11/7.
//  Copyright © 2017年 try. All rights reserved.
//
#define ScaleWidth 5.
#define CenterPoint  CGPointMake(CGRectGetWidth(self.frame)/2.,CGRectGetHeight(self.frame))
#define Progress_Speed .05   //速度
#import "NSObject+GCDDate.h"
#import "LSIndicatorView.h"
@interface LSIndicatorView ()

/**
 *  圆盘开始角度
 */
@property(nonatomic,assign)CGFloat startAngle;
/**
 *  圆盘结束角度
 */
@property(nonatomic,assign)CGFloat endAngle;
/**
 *  圆盘总共弧度弧度
 */
@property(nonatomic,assign)CGFloat arcAngle;
/**
 *  线宽
 */
@property(nonatomic,assign)CGFloat lineWidth;
/**
 *  刻度值长度
 */
@property(nonatomic,assign)CGFloat scaleValueRadiusWidth;
/**
 *  速度表半径
 */
@property(nonatomic,assign)CGFloat arcRadius;
/**
 *  刻度半径
 */
@property(nonatomic,assign)CGFloat scaleRadius;
/**
 *  刻度值半径
 */
@property(nonatomic,assign)CGFloat scaleValueRadius;

/**
 * 进度颜色
 */
@property(nonatomic,strong)UIColor * pgStrokeColor;

/**
 * 圆弧刻度颜色
 */
@property(nonatomic,strong)UIColor * strokeColor;
@property (nonatomic, strong) CAShapeLayer* shapeBgLayer;
@property (nonatomic, strong) CAShapeLayer *progressLayer;
@property (nonatomic,strong ) CAShapeLayer *scaleLayer;

@property (nonatomic,strong) UILabel * lbTitleLb;
@property (nonatomic,strong) UILabel * lbValueLb;

@property (strong, nonatomic) NSTimer *timer;
@property (assign,nonatomic ) CGFloat addAmount;

@end
@implementation LSIndicatorView
-(instancetype)initWithPgColor:(UIColor*)PgColor strokeColor:(UIColor*)strokeColor andLineWidth:(CGFloat)lineWidth{
    if (self = [super init]) {
        self.lineWidth=lineWidth;
        self.startAngle=-M_PI;
        self.endAngle=0;
        self.arcAngle=M_PI;
        self.pgStrokeColor = PgColor;
        self.strokeColor = strokeColor;
        [self addSubview:self.lbTitleLb];
        [self addSubview:self.lbValueLb];

    }
    return self;
}


-(UILabel *)lbValueLb{
    if (!_lbValueLb) {
        _lbValueLb = [[UILabel alloc]init];
        [_lbValueLb setFont:[UIFont systemFontOfSize:38]];
        [_lbValueLb setTextColor:[UIColor whiteColor]];
        _lbValueLb.textAlignment = NSTextAlignmentCenter;
    }
    return _lbValueLb;
}
-(UILabel*)lbTitleLb{
    if (!_lbTitleLb) {
        _lbTitleLb = [[UILabel alloc]init];
        [_lbTitleLb setFont:[UIFont systemFontOfSize:14]];
        [_lbTitleLb setTextColor:[UIColor whiteColor]];
        _lbTitleLb.textAlignment = NSTextAlignmentCenter;
    }
    return _lbTitleLb;
}
/**
 *  画弧度
 */
-(void)drawArc{
    //保存弧线宽度,开始角度，结束角度
    if (_shapeBgLayer) {
        [_shapeBgLayer removeFromSuperlayer];
    }
    UIBezierPath* outArc=[UIBezierPath bezierPathWithArcCenter:CenterPoint radius:self.arcRadius startAngle:_startAngle endAngle:_endAngle clockwise:YES];
    _shapeBgLayer=[CAShapeLayer layer];
    _shapeBgLayer.lineWidth=_lineWidth;
    _shapeBgLayer.fillColor=[UIColor clearColor].CGColor;
    _shapeBgLayer.strokeColor=_strokeColor.CGColor;
    _shapeBgLayer.path=outArc.CGPath;
    _shapeBgLayer.lineCap=kCALineCapRound;
    [self.layer addSublayer:_shapeBgLayer];
}
/**
 *  画刻度
 *
 *  @param divide      刻度几等分
 */
//center:中心店，即圆心
//startAngle：起始角度
//endAngle：结束角度
//clockwise：是否逆时针
-(void)drawScaleWithDivide:(int)divide{
    
    if (_scaleLayer) {
        [_scaleLayer removeFromSuperlayer];
    }
    _scaleLayer = [CAShapeLayer layer];
    UIBezierPath *tickPath = [UIBezierPath bezierPathWithArcCenter:CenterPoint radius:self.scaleRadius startAngle:_startAngle endAngle:_endAngle clockwise:YES];
    _scaleLayer.path = tickPath.CGPath;
    _scaleLayer.lineWidth = ScaleWidth;
    //虚线边框
    NSNumber * fillNumber = [NSNumber numberWithFloat:((_scaleRadius*M_PI-divide)/(divide-1))];
    _scaleLayer.lineDashPattern = @[@1,fillNumber];
    //实线边框
    //    borderLayer.lineDashPattern = nil;
    _scaleLayer.strokeStart = 0;
    _scaleLayer.strokeEnd = 0;
    _scaleLayer.fillColor = [UIColor clearColor].CGColor;
    _scaleLayer.strokeColor = [UIColor whiteColor].CGColor;
    [self.layer addSublayer:_scaleLayer];
    
}
/**
 *  进度条曲线
 */
- (void)drawProgressCicrle{
    
    if (_progressLayer) {
        [_progressLayer removeFromSuperlayer];
    }
    UIBezierPath *progressPath  = [UIBezierPath bezierPathWithArcCenter:CenterPoint radius:self.arcRadius startAngle:self.startAngle endAngle:self.endAngle clockwise:YES];
    CAShapeLayer *progressLayer = [CAShapeLayer layer];
    self.progressLayer = progressLayer;
    progressLayer.lineWidth = self.lineWidth+0.25f;
    progressLayer.fillColor = [UIColor clearColor].CGColor;
    progressLayer.strokeColor = _pgStrokeColor.CGColor;
    progressLayer.path = progressPath.CGPath;
    progressLayer.strokeStart = 0;
    progressLayer.strokeEnd = 0.0;
    progressLayer.lineCap=kCALineCapRound;
    [self.layer addSublayer:progressLayer];
}


- (void)progressChange
{
    if (_progressLayer.strokeEnd >= 1.0) {
        [self.timer invalidate];
        self.timer = nil;
    }
    
    _progressLayer.strokeEnd += Progress_Speed;
    _scaleLayer.strokeEnd += Progress_Speed;
   CGFloat sum = [_lbValueLb.text floatValue]+_addAmount;
    if (sum >[_amountStr floatValue]) {
        _lbValueLb.text = _amountStr;
    }else{
        _lbValueLb.text = [NSString moneyDeleteMoreZeroWithAmountStr:sum];
    }

}
-(void)runSpeedProgress{
    _progressLayer.strokeEnd = 0;
    _scaleLayer.strokeEnd = 0;
    _lbValueLb.text = @"0";
    //    销毁定时器
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.1
                                              target:self
                                            selector:@selector(progressChange)
                                            userInfo:nil
                                             repeats:YES];
    [_timer fire];
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    //获得处理的上下文
    CGFloat width = CGRectGetWidth(self.frame)/2.;
    CGFloat height = CGRectGetHeight(self.frame);
    CGFloat diametre = width >height?height:width;
    self.arcRadius= diametre;
    self.scaleRadius=self.arcRadius-self.lineWidth-5;
    self.scaleValueRadius=self.scaleRadius-self.lineWidth-5;
    _lbTitleLb.center = CGPointMake(CGRectGetWidth(self.frame)/2., _scaleRadius/2.-5);
    _lbValueLb.frame = CGRectMake(0.0, height - 40.0 , CGRectGetWidth(self.frame), 40);
    [self drawArc];
    [self drawProgressCicrle];
    [self drawScaleWithDivide:60];
}

- (void)setAmountStr:(NSString *)amountStr{
    _amountStr = amountStr;
    if (kStringIsEmpty(_amountStr)) {
        _amountStr = @"0";
    }
    _addAmount = [_amountStr floatValue]*Progress_Speed;
}

- (void)setAmountDesc:(NSString *)amountDesc{
    if (_amountDesc != amountDesc) {
        _amountDesc = amountDesc;
    }
    if (!kStringIsEmpty(_amountDesc)) {
        _lbTitleLb.text = _amountDesc;
        [_lbTitleLb sizeToFit];
        _lbTitleLb.center = CGPointMake(CGRectGetWidth(self.frame)/2., _scaleRadius/2.-5);


    }
}

@end

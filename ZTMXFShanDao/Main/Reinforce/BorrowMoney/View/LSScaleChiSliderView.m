//
//  LSScaleChiSliderView.h
//
//  Created by 朱吉达 on 17/9/27.
//  Copyright © 2017年 讯秒. All rights reserved.
//

#define kSliderW self.bounds.size.width
#define kSliderH self.bounds.size.height
#define kCornerRadius 0.0  //默认圆角为5
#define kBorderWidth 0.0 //默认边框为2
#define kAnimationSpeed 0.5 //默认动画移速
#define ScaleH  31
#define kForegroundColor [UIColor orangeColor] //默认滑过颜色
#define kBackgroundColor [UIColor clearColor] //默认未滑过颜色
#define kThumbColor [UIColor lightGrayColor] //默认Thumb颜色
#define kBorderColor [UIColor blackColor] //默认边框颜色
#define kThumbW 60 //默认的thumb的宽度

#import "NSString+Additions.h"
#import "LSScaleChiSliderView.h"
@interface LSScaleChiSliderView () {
    UIView *_thumbView;
    UIView * _viScaleView;
    UIView *_foregroundView;
    UILabel * _lbMinLb;
    UILabel * _lbMaxLb;
    NSMutableArray * _arrLineArr;
    
}


@end
@implementation LSScaleChiSliderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{

//    刻度尺容器
    _viScaleView = [[UIView alloc]init];
    _viScaleView.frame = CGRectMake(AdaptedWidth(12), 0, self.width-AdaptedWidth(12)*2, AdaptedWidth(ScaleH));
    [self addSubview:_viScaleView];
    
//   进度视图
    _foregroundView = [[UIView alloc] init];
    [_viScaleView addSubview:_foregroundView];
    _lbMinLb = [[UILabel alloc]init];
//    最小值
    [_lbMinLb setFrame:CGRectMake(_viScaleView.left, _viScaleView.bottom, 100, 21)];
    [_lbMinLb setFont:[UIFont systemFontOfSize:AdaptedWidth(12)]];
    _lbMinLb.textColor = [UIColor colorWithHexString:@"666666"];
    _lbMinLb.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_lbMinLb];
    //    最大值
    _lbMaxLb = [[UILabel alloc]init];
    [_lbMaxLb setFrame:CGRectMake(0, _viScaleView.bottom, 100, 21)];
    [_lbMaxLb setFont:[UIFont systemFontOfSize:AdaptedWidth(12)]];
    _lbMaxLb.textColor = [UIColor colorWithHexString:@"666666"];
    _lbMaxLb.textAlignment = NSTextAlignmentRight;
    _lbMaxLb.right = _viScaleView.right;
    [self addSubview:_lbMaxLb];
    
//    刻度尺底线
    UIView* lineScaleView = [[UIView alloc]init];
    [lineScaleView setFrame:CGRectMake(0, 0, _viScaleView.width, 1)];
    [lineScaleView setBackgroundColor:[UIColor colorWithHexString:@"e8434e"]];
    lineScaleView.bottom = _viScaleView.height;
    [_viScaleView addSubview:lineScaleView];
//    滑动手柄
    _thumbView = [[UIView alloc]init];
    [_thumbView setFrame:CGRectMake(0, 0,kThumbW, AdaptedWidth(23))];
    [_thumbView setBackgroundColor:[UIColor clearColor]];
    
    UIView * thumbLine = [[UIView alloc]init];
    [thumbLine setFrame:CGRectMake(0, 0, 1, AdaptedWidth(13))];
    [thumbLine setBackgroundColor:[UIColor colorWithHexString:@"e8434e"]];
    thumbLine.centerX = _thumbView.width/2.;
    [_thumbView addSubview:thumbLine];
    
    UIView * thumbRound = [[UIView alloc]init];
    [thumbRound setFrame:CGRectMake(0, 0, AdaptedWidth(12), AdaptedWidth(12))];
    [thumbRound setBackgroundColor:[UIColor whiteColor]];
    [thumbRound.layer setCornerRadius:AdaptedWidth(12)/2.];
    [thumbRound.layer setBorderWidth:AdaptedWidth(2)];
    [thumbRound.layer setBorderColor:[UIColor colorWithHexString:@"ffb6bc"].CGColor];
    thumbRound.centerX = _thumbView.width/2.;
    thumbRound.centerY = thumbLine.bottom;
    thumbRound.clipsToBounds = YES;
    [_thumbView addSubview:thumbRound];
    
    _thumbView.top = _viScaleView.bottom;
    _thumbView.centerX = _viScaleView.left;
    [self addSubview:_thumbView];
    _thumbView.clipsToBounds = YES;
    
    self.layer.cornerRadius = kCornerRadius;
    self.layer.masksToBounds = YES;
    self.layer.borderWidth = kBorderWidth;
    //    默认值
    self.minValue = 0;
    self.maxValue = 1;
    [self setSliderValue:0.0];
    //默认配置
    self.thumbBack = YES;
    self.backgroundColor = kBackgroundColor;
//    _foregroundView.backgroundColor = kForegroundColor;
//    [self.layer setBorderColor:kBorderColor.CGColor];
//    刻度尺
    CGFloat space =  (_viScaleView.width-1)/17./5.;
    _arrLineArr = [[NSMutableArray alloc]init];
    for (int i = 0; i <86; i++) {
        CGFloat h = i%5==0?14:7;
        UIView * line = [[UIView alloc]init];
        [line setFrame:CGRectMake(i*space, 0, 1, h)];
        [line setBackgroundColor:[UIColor colorWithHexString:@"e8434e"]];
        line.bottom = _viScaleView.height;
        [_viScaleView addSubview:line];
        [_arrLineArr addObject:line];
    }
    [_viScaleView bringSubviewToFront:lineScaleView];

}

#pragma mark - Public

- (void)setSliderValue:(CGFloat)value{
    [self setSliderValue:value animation:NO completion:nil];
}

- (void)setSliderValue:(CGFloat)value animation:(BOOL)animation completion:(void (^)(BOOL))completion{
    
    if (value > _maxValue) {
        value = _maxValue;
    }else if (value < _minValue) {
        value = _minValue;
    }else{
        
    }

    CGFloat differenceValue = _maxValue - _minValue;
    
    CGFloat proportion = (value -_minValue)/differenceValue;
    
    CGPoint point = CGPointMake(proportion * _viScaleView.width+_viScaleView.left, 0);
    typeof(self) weakSelf = self;
    if (animation) {
        [UIView animateWithDuration:kAnimationSpeed animations:^{
            [weakSelf fillForeGroundViewWithPoint:point];
        } completion:^(BOOL finished) {
            if (completion) {
                completion(finished);
            }
        }];
    } else {
        [self fillForeGroundViewWithPoint:point];
    }
}





- (void)removeRoundCorners:(BOOL)corners border:(BOOL)border{
    if (corners) {
        self.layer.cornerRadius = 0.0;
        self.layer.masksToBounds = NO;
        _thumbView.layer.cornerRadius = 0.0;
        _thumbView.layer.masksToBounds = NO;
    }
    if (border) {
        [self.layer setBorderWidth:0.0];
    }
}



-(void)setMinValue:(CGFloat)minValue{
    _minValue = minValue;
    _lbMinLb.text = [NSString moneyDeleteMoreZeroWithAmountStr:minValue];
}
-(void)setMaxValue:(CGFloat)maxValue{
    _maxValue = maxValue;
    _lbMaxLb.text = [NSString moneyDeleteMoreZeroWithAmountStr:maxValue];
}
#pragma mark - Private
- (void)fillForeGroundViewWithPoint:(CGPoint)point{
//    CGFloat thunmbW =  kThumbW;
    CGPoint p = point;
    //修正
    if (isnan(p.x)) {
        p.x = _viScaleView.left;
    }
    if (isnan(p.y)) {
        p.y = 0;
    }
//    p.x += thunmbW/2;
    if (p.x >= _viScaleView.right) {
        p.x = _viScaleView.right;
    }
    if (p.x <= _viScaleView.left) {
        p.x = _viScaleView.left;
    }

    CGFloat differenceValue =  _maxValue - _minValue;
    self.value = _minValue + (p.x-_viScaleView.left) / _viScaleView.width*differenceValue;
    if (p.x<=_viScaleView.left) {
        self.value = _minValue;
    }
    NSLog(@"-===========---- %f",p.x);
    CGFloat  foregroundW = (p.x-_viScaleView.left)<=0?0:p.x-_viScaleView.left;
    
    _foregroundView.frame = CGRectMake(0, 0, foregroundW, _viScaleView.height);
    
    if (_foregroundView.frame.size.width <= 0) {

        _thumbView.centerX = _viScaleView.left;
        
    }else if (_foregroundView.frame.size.width >= _viScaleView.width) {

        _thumbView.centerX = _viScaleView.right;
        _foregroundView.width = _viScaleView.width;

    }else{

        _thumbView.centerX = _foregroundView.right+_viScaleView.left;
    }

    for (int i = 0; i<_arrLineArr.count; i++) {
        UIView * line = _arrLineArr[i];
        if (line.right<=_foregroundView.right) {
            [line setBackgroundColor:[UIColor whiteColor]];
        }else{
            [line setBackgroundColor:[UIColor colorWithHexString:@"e8434e"]];
        }
    }
    CAGradientLayer *gradientLayer =  [CAGradientLayer layer];
    gradientLayer.frame = _foregroundView.bounds;
    [gradientLayer setColors:[NSArray arrayWithObjects:(id)[[UIColor colorWithHexString:@"f77c2f"] CGColor],(id)[[UIColor colorWithHexString:@"e8424e"] CGColor], nil]];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1,0);
    [_foregroundView.layer addSublayer:gradientLayer];
    _foregroundView.clipsToBounds = YES;

}

#pragma mark - Touch
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
//    if ( _touchView == _thumbView) {
//        return;
//    }
    CGPoint point = [touch locationInView:self];
    NSLog(@"%f",point.x);
    [self fillForeGroundViewWithPoint:point];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
//    if (touch.view != _touchView) {
//        return;
//    }
    CGPoint point = [touch locationInView:self];
    [self fillForeGroundViewWithPoint:point];
    if ([self.delegate respondsToSelector:@selector(sliderValueChanging:)] ) {
        [self.delegate sliderValueChanging:self];
    }
    
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
//    if (touch.view != _touchView) {
//        return;
//    }
    CGPoint __block point = [touch locationInView:self];
    if ([self.delegate respondsToSelector:@selector(sliderEndValueChanged:)]) {
        [self.delegate sliderEndValueChanged:self];
    }
    typeof(self) weakSelf = self;
    if (_thumbBack) {
        //回到原点
        [UIView animateWithDuration:0.5 animations:^{
            point.x = 0;
            [weakSelf fillForeGroundViewWithPoint:point];
            
        }];
    }
    
}

@end

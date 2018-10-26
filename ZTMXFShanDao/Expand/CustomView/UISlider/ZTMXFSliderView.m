//
//  LSSliderView.m
//  ReflectionTry
//
//  Created by 朱吉达 on 2017/10/27.
//  Copyright © 2017年 try. All rights reserved.


#define SliderH      CGRectGetHeight(self.frame)
#define kSliderW     CGRectGetWidth(self.frame)
#define kSliderH     (SliderH>=_thumbSize?_thumbSize/2.:SliderH)
#define kSliderMinX  0
#define kSliderMaxX  CGRectGetWidth(self.frame)


#import <SDWebImage/UIButton+WebCache.h>

#import "ZTMXFSliderView.h"
@interface ZTMXFSliderView()
@property (nonatomic,strong) UIView * viForegroundView;
@property (nonatomic,strong) UIView * viSliderView;
@property (nonatomic,strong) UIButton * thumbBtn;


@end
@implementation ZTMXFSliderView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _maxmumTrackTintColor = [UIColor blueColor];
        _minimumTrackTintColor = [UIColor blueColor];
        _thumbSize = 20.;
        self.minValue = 0.0;
        self.maxValue = 1.0;
        [self setBackgroundColor:[UIColor clearColor]];
        [self addSubview:self.viSliderView];
        [_viSliderView addSubview:self.viForegroundView];
        [self addSubview:self.thumbBtn];
    }
    return self;
}


-(void)setThumbSize:(CGFloat)thumbSize{
    if (thumbSize<10) {
        thumbSize = 10;
    }
    _thumbSize = thumbSize;
    [self layoutSubviews];
    
}
-(void)setThumbImageName:(NSString *)thumbImageName{
    _thumbImageName = thumbImageName;
    [self.thumbBtn setBackgroundColor:[UIColor clearColor]];
    [self.thumbBtn setBackgroundImage:[UIImage imageNamed:_thumbImageName] forState:UIControlStateNormal];
}
-(void)setThumbSrc:(NSString *)thumbSrc{
    _thumbSrc = thumbSrc;
    [self.thumbBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:thumbSrc] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"renewal_slider_thumb"]];

}
-(void)setMinValue:(CGFloat)minValue{
    _minValue = minValue;
}
-(void)setMaxValue:(CGFloat)maxValue{
    _maxValue = maxValue;
}

#pragma mark --
-(UIView *)viForegroundView{
    if (!_viForegroundView) {
        _viForegroundView = [[UIView alloc]init];
        _viForegroundView.clipsToBounds = YES;
        [_viForegroundView.layer setCornerRadius:kSliderH/2.];
        [_viForegroundView setBackgroundColor:[UIColor redColor]];

    }
    return _viForegroundView;
}
-(UIView *)viSliderView{
    if (!_viSliderView) {
        _viSliderView = [[UIView alloc]init];
        [_viSliderView setFrame:CGRectMake(0, 0, kSliderW, kSliderH)];
        [_viSliderView.layer setCornerRadius:kSliderH/2.];
        _viSliderView.center = CGPointMake(CGRectGetWidth(self.frame)/2., kSliderH/2.-7);
        [_viSliderView setBackgroundColor:[UIColor colorWithHexString:@"f2f2f2"]];
        _viSliderView.clipsToBounds = YES;
    }
    return _viSliderView;
}
-(void)setSliderBgColor:(UIColor *)sliderBgColor{
    _sliderBgColor = sliderBgColor;
    if (sliderBgColor) {
        [_viSliderView setBackgroundColor:sliderBgColor];
    }
}

#pragma mark - Touch
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    [self fillForeGroundViewWithPoint:point];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];

    CGPoint point = [touch locationInView:self];
    [self fillForeGroundViewWithPoint:point];
    if ([self.delegate respondsToSelector:@selector(sliderValueChanging:)] ) {
        [self.delegate sliderValueChanging:self];
    }
    
}
-(UIButton*)thumbBtn{
    if (!_thumbBtn) {
        _thumbBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_thumbBtn setFrame:CGRectMake(0, 0, self.thumbSize,self.thumbSize)];
        [_thumbBtn setBackgroundColor:[UIColor blueColor]];
        [_thumbBtn.layer setCornerRadius:self.thumbSize/2.];
        _thumbBtn.userInteractionEnabled = NO;
        
        _thumbBtn.center = CGPointMake(0, _viSliderView.center.y);
    }
    return _thumbBtn;
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if ([self.delegate respondsToSelector:@selector(sliderEndValueChanged:)]) {
        [self.delegate sliderEndValueChanged:self];
    }

    
}
#pragma mark - Private
- (void)fillForeGroundViewWithPoint:(CGPoint)point{
    //    CGFloat thunmbW =  kThumbW;
    CGPoint p = point;

    //修正
    if (isnan(p.x)) {
        p.x = kSliderMinX;
    }
    if (isnan(p.y)) {
        p.y = 0;
    }
    if (p.x >= kSliderMaxX) {
        p.x = kSliderMaxX;
    }
    if (p.x <= kSliderMinX) {
        p.x = kSliderMinX;
    }
    
    CGFloat differenceValue =  _maxValue - _minValue;
    self.value = _minValue + (p.x-kSliderMinX) / kSliderW*differenceValue;
    if (p.x<=kSliderMinX) {
        self.value = _minValue;
    }
    CGFloat  foregroundW = (p.x-kSliderMinX)<=0?0:p.x-kSliderMinX;
    
    _viForegroundView.frame = CGRectMake(0, 0, foregroundW, kSliderH);
    
    if (_viForegroundView.frame.size.width <= 0) {

        _thumbBtn.center = CGPointMake(kSliderMinX, _viSliderView.center.y);
        
    }else if (_viForegroundView.frame.size.width >= kSliderW) {
        
        _thumbBtn.center = CGPointMake(kSliderMaxX, _viSliderView.center.y);
        _viForegroundView.frame = CGRectMake(0, 0, kSliderW, kSliderH);
        
    }else{
        CGFloat centerX =  CGRectGetMaxX(_viForegroundView.frame)+kSliderMinX;
        _thumbBtn.center = CGPointMake(centerX, _viSliderView.center.y);
    }
    

    CAGradientLayer *gradientLayer =  [CAGradientLayer layer];
    gradientLayer.frame = _viForegroundView.bounds;
    [gradientLayer setColors:[NSArray arrayWithObjects:(id)[_minimumTrackTintColor CGColor],(id)[_maxmumTrackTintColor CGColor], nil]];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1,0);
    [_viForegroundView.layer addSublayer:gradientLayer];
    _viForegroundView.clipsToBounds = YES;
    
}
#pragma mark - Public



- (void)setSliderValue:(CGFloat)value animation:(BOOL)animation completion:(void (^)(BOOL))completion{
    
    if (value > _maxValue) {
        value = _maxValue;
    }else if (value < _minValue) {
        value = _minValue;
    }else{
        
    }
    
    CGFloat differenceValue = _maxValue - _minValue;
    
    CGFloat proportion = (value -_minValue)/differenceValue;
    
    CGPoint point = CGPointMake(proportion *kSliderW+kSliderMinX, 0);
    typeof(self) weakSelf = self;
    if (animation) {
        [UIView animateWithDuration:1 animations:^{
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
- (void)setSliderValue:(CGFloat)value{
    [self setSliderValue:value animation:NO completion:nil];
}
//检查点击事件点击范围是否能够交给self处理
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    // 当前控件上的点转换到chatView上
    CGPoint chatP = [self convertPoint:point toView:self];
    
    // 判断下点在不在chatView上
    if (chatP.x>=-_thumbSize&&chatP.x<(kSliderMaxX+_thumbSize)&&chatP.y>=-_thumbSize&&chatP.y<=(kSliderH+_thumbSize)) {
        return self;
    }else{
        return [super hitTest:point withEvent:event];
    }
}
//检查是点击事件的点是否在slider范围内
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    //调用父类判断
    BOOL result = [super pointInside:point withEvent:event];
    if (!result) {
        CGPoint chatP = [self convertPoint:point toView:self];
        if (chatP.x>=-_thumbSize&&chatP.x<(kSliderMaxX+_thumbSize)&&chatP.y>=-_thumbSize&&chatP.y<=(kSliderH+_thumbSize)) {
            return YES;
        }
    }
    
//    NSLog(@"UISlider.pointInside: (%f, %f)", point.x, point.y);
    //否则返回父类的结果
    return result;
}
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [super drawRect:rect];
    [self setBounds:CGRectMake(0, 0, self.bounds.size.width, kSliderH)];
    [_viSliderView setFrame:CGRectMake(0, 0, kSliderW, kSliderH)];
    [_viSliderView.layer setCornerRadius:kSliderH/2.];
    _viSliderView.center = CGPointMake(kSliderW/2., kSliderH/2.-7);
    [_viForegroundView.layer setCornerRadius:kSliderH/2.];
    
}
-(void)layoutSubviews{
    [super layoutSubviews];
    [self setBounds:CGRectMake(0, 0, self.bounds.size.width, kSliderH)];
   
    [_viSliderView setFrame:CGRectMake(0, 0, kSliderW, kSliderH)];
    [_viSliderView.layer setCornerRadius:kSliderH/2.];
    _viSliderView.center = CGPointMake(kSliderW/2., kSliderH/2.-7);
    [_viForegroundView.layer setCornerRadius:kSliderH/2.];
    [_thumbBtn setFrame:CGRectMake(0, 0, self.thumbSize,self.thumbSize)];
    [_thumbBtn.layer setCornerRadius:self.thumbSize/2.];
    _thumbBtn.centerY = _viSliderView.centerY;
    [self setSliderValue:_value];
    
}

@end

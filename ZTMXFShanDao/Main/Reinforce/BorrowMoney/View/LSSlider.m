//
//  LSSlider.m
//  ReflectionTry
//
//  Created by 朱吉达 on 2017/10/27.
//  Copyright © 2017年 try. All rights reserved.
//
#define kSliderH 10
#define kSuperBgH  60
#define kThumbSize  20
#define kSpacing   14
#define kSliderW (self.bounds.size.width-kSpacing*2)

#define kSliderMinX  CGRectGetMinX(_viSliderView.frame)
#define kSliderMaxX  CGRectGetMaxX(_viSliderView.frame)



#import "LSSlider.h"
@interface LSSlider()
@property (nonatomic,strong) UIView * viForegroundView;
@property (nonatomic,strong) UIView * viSliderView;
@property (nonatomic,strong) UILabel * lbMineLb;
@property (nonatomic,strong) UILabel * lbMaxLb;

@property (nonatomic,strong) UIButton * thumbBtn;
@end
@implementation LSSlider
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _maxmumTrackTintColor = [UIColor blueColor];
        _minimumTrackTintColor = [UIColor blueColor];
        self.minValue = 0.0;
        self.maxValue = 1.0;
        [self setBackgroundColor:[UIColor clearColor]];
        [self addSubview:self.viSliderView];
        [_viSliderView addSubview:self.viForegroundView];
        [self addSubview:self.thumbBtn];
        [self addSubview:self.lbMineLb];
        [self addSubview:self.lbMaxLb];
    }
    return self;
}

-(void)setMinValue:(CGFloat)minValue{
    _minValue = minValue;
    self.lbMineLb.text = [NSString stringWithFormat:@"%.f",minValue];
}
-(void)setMaxValue:(CGFloat)maxValue{
    _maxValue = maxValue;
    self.lbMaxLb.text = [NSString stringWithFormat:@"%.f",maxValue];
}
-(void)setThumbImageName:(NSString *)thumbImageName{
    _thumbImageName = thumbImageName;
    [self.thumbBtn setBackgroundColor:[UIColor clearColor]];
    [self.thumbBtn setBackgroundImage:[UIImage imageNamed:_thumbImageName] forState:UIControlStateNormal];
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
        _viSliderView.center = CGPointMake(self.width/2., kSuperBgH/2.-7);
        [_viSliderView setBackgroundColor:[UIColor colorWithHexString:@"f2f2f2"]];
        _viSliderView.clipsToBounds = YES;
    }
    return _viSliderView;
}
-(UIButton*)thumbBtn{
    if (!_thumbBtn) {
        _thumbBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_thumbBtn setFrame:CGRectMake(0, 0, kThumbSize,kThumbSize)];
        [_thumbBtn setBackgroundColor:[UIColor blueColor]];
        [_thumbBtn.layer setCornerRadius:kThumbSize/2.];
        _thumbBtn.userInteractionEnabled = NO;
        _thumbBtn.center = CGPointMake(kSpacing, _viSliderView.centerY);
    }
    return _thumbBtn;
}
-(UILabel*)lbMineLb{
    if (!_lbMineLb) {
        _lbMineLb = [[UILabel alloc]init];
        [_lbMineLb setFont:[UIFont systemFontOfSize:14]];
        [_lbMineLb setTextColor:K_B8B8B8];
        _lbMineLb.textAlignment = NSTextAlignmentLeft;
        [_lbMineLb setFrame:CGRectMake(kSliderMinX, _viSliderView.bottom+7,kSliderW/2. , 21)];

    }
    return _lbMineLb;
}
-(UILabel*)lbMaxLb{
    if (!_lbMaxLb) {
        _lbMaxLb = [[UILabel alloc]init];
        [_lbMaxLb setFont:[UIFont systemFontOfSize:14]];
        [_lbMaxLb setTextColor:K_B8B8B8];
        _lbMaxLb.textAlignment = NSTextAlignmentRight;
        [_lbMaxLb setFrame:CGRectMake(_viSliderView.right, _lbMineLb.top, kSliderW/2., 21)];

    }
    return _lbMaxLb;
}
#pragma mark - Touch
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    NSLog(@"%f",point.x);
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

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    UITouch *touch = [touches anyObject];
//        if (touch.view != _touchView) {
//            return;
//        }
//    CGPoint __block point = [touch locationInView:self];
    if ([self.delegate respondsToSelector:@selector(sliderEndValueChanged:)]) {
        [self.delegate sliderEndValueChanged:self];
    }
//    typeof(self) weakSelf = self;
//    if (_thumbBack) {
//        //回到原点
//        [UIView animateWithDuration:0.5 animations:^{
//            point.x = 0;
//            [weakSelf fillForeGroundViewWithPoint:point];
//
//        }];
//    }
    
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
    //    p.x += thunmbW/2;
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
    NSLog(@"-===========---- %f",p.x);
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
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [super drawRect:rect];
    [self setBounds:CGRectMake(0, 0, self.bounds.size.width, kSuperBgH)];
    _lbMineLb.left = kSliderMinX;
    _lbMineLb.top = _viSliderView.bottom + 7;
    _lbMaxLb.top = _lbMineLb.top;
    _lbMaxLb.right = _viSliderView.right;
    
}
-(void)layoutSubviews{
    [super layoutSubviews];
    [self setBounds:CGRectMake(0, 0, self.bounds.size.width, kSuperBgH)];
    [_viSliderView setFrame:CGRectMake(0, 0, kSliderW, kSliderH)];
    NSLog(@"-=====--    %f",kSliderW);
    [_viSliderView.layer setCornerRadius:kSliderH/2.];
    _viSliderView.center = CGPointMake(self.width/2., kSuperBgH/2.-7);
    [_viForegroundView.layer setCornerRadius:kSliderH/2.];
    [_lbMineLb setFrame:CGRectMake(kSliderMinX, _viSliderView.bottom+7,kSliderW/2. , 21)];
    [_lbMaxLb setFrame:CGRectMake(_viSliderView.right, _lbMineLb.top, kSliderW/2., 21)];
    
    _lbMineLb.left = kSliderMinX;
    _lbMineLb.top = _viSliderView.bottom + 7;
    _lbMaxLb.top = _lbMineLb.top;
    _lbMaxLb.right = _viSliderView.right;
    
    [self setSliderValue:_value];
    
}

@end

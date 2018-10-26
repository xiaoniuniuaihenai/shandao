//
//  LSIdCardView.m
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2017/11/9.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "LSIdCardView.h"

@interface LSIdCardView ()

@property (nonatomic ,strong) UIButton *coverView;
@property (nonatomic, strong) UIView *alertView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *subTitleLabel;
@property (nonatomic, strong) UIButton *cancelBtn;
@property (nonatomic, strong) UIButton *sureBtn;

@property (nonatomic, strong) NSArray *clicks;

@end

@implementation LSIdCardView

//- (instancetype)initWithFrame:(CGRect)frame{
//    if (self) {
//        self = [super initWithFrame:frame];
//    }
//    return self;
//}




- (UIView *)alertView{
    if (!_alertView) {
        _alertView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, AdaptedWidth(280), AdaptedWidth(180))];
        _alertView.backgroundColor = [UIColor whiteColor];
        _alertView.center = self.center;
        _alertView.layer.masksToBounds = YES;
        _alertView.layer.cornerRadius = 4.0;
        [self addSubview:_alertView];
        
        [_alertView addSubview:self.titleLabel];
        [_alertView addSubview:self.subTitleLabel];
        [_alertView addSubview:self.cancelBtn];
        [_alertView addSubview:self.sureBtn];
        
        _titleLabel.top = AdaptedWidth(23);
        _titleLabel.left = AdaptedWidth(20);
        _subTitleLabel.top = _titleLabel.bottom + AdaptedWidth(9);
        _subTitleLabel.left = _titleLabel.left;
        
        UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, _subTitleLabel.bottom + AdaptedWidth(21), _alertView.width, 1)];
        lineLabel.backgroundColor = [UIColor colorWithHexString:@"dedede"];
        [_alertView addSubview:lineLabel];
        
        UILabel *spotLine = [[UILabel alloc] initWithFrame:CGRectMake(0, lineLabel.bottom, 1, AdaptedWidth(44))];
        spotLine.centerX = _alertView.width/2.0;
        spotLine.backgroundColor = [UIColor colorWithHexString:@"dedede"];
        [_alertView addSubview:spotLine];
        
        _cancelBtn.top = lineLabel.bottom + 1;
        _cancelBtn.centerX = _alertView.width/4.0;
        _sureBtn.top = _cancelBtn.top;
        _sureBtn.centerX = _alertView.width*3.0/4.0;
    }
    return _alertView;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel labelWithTitleColorStr:@"3d3d3d" fontSize:14 alignment:NSTextAlignmentLeft];
        _titleLabel.numberOfLines = 0;
        [_titleLabel setFrame:CGRectMake(AdaptedWidth(18), AdaptedWidth(23), _alertView.width-15*2, AdaptedWidth(60))];
    }
    return _titleLabel;
}


- (UILabel *)subTitleLabel{
    if (!_subTitleLabel) {
        _subTitleLabel = [UILabel labelWithTitleColorStr:@"909090" fontSize:12 alignment:NSTextAlignmentLeft];
        _subTitleLabel.numberOfLines = 1;
        [_subTitleLabel setFrame:CGRectMake(AdaptedWidth(18), AdaptedWidth(9), _alertView.width-15*2, AdaptedWidth(17))];
    }
    return _subTitleLabel;
}

- (UIButton *)cancelBtn{
    if (!_cancelBtn) {
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelBtn setFrame:CGRectMake(0, _alertView.height- AdaptedWidth(42), (_alertView.width-1.0)/2.0, AdaptedWidth(42))];
        [_cancelBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [_cancelBtn setTitleColor:[UIColor colorWithHexString:@"939393"] forState:UIControlStateNormal];
        _cancelBtn.tag = 0;
        [_cancelBtn addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}

- (UIButton *)sureBtn{
    if (!_sureBtn) {
        _sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sureBtn setFrame:CGRectMake(0, _alertView.height- AdaptedWidth(42), (_alertView.width-1.0)/2.0, AdaptedWidth(42))];
        [_sureBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [_sureBtn setTitleColor:[UIColor colorWithHexString:@"619fe6"] forState:UIControlStateNormal];
        _sureBtn.tag = 1;
        [_sureBtn addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureBtn;
}

- (NSArray *)clicks{
    if (!_clicks) {
        _clicks = [NSArray array];
    }
    return _clicks;
}

#pragma mark - 展示弹窗
- (void)show{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
    
    CGFloat duration = 0.3;
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.0];
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
    } completion:^(BOOL finished) {

    }];
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    animation.values = @[@(0.8), @(1.05), @(1.1), @(1)];
    animation.keyTimes = @[@(0), @(0.3), @(0.5), @(1.0)];
    animation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
    animation.duration = duration;
    [self.alertView.layer addAnimation:animation forKey:@"bouce"];
}

+ (void)showAlertViewWithTitle:(NSString *)title SubTitle:(NSString *)subTitle CancelButton:(NSString *)cancelTitle Click:(clickHandle)clickCancel OtherButton:(NSString *)otherTitle Click:(clickHandleWithIndex)clickOthers{
    
    id newClick = clickCancel;
    if (!newClick) {
        newClick = [NSNull null];
    }
    id newClick1 = clickOthers;
    if (!newClick1) {
        newClick1 = [NSNull null];
    }
    
    LSIdCardView *cardAlertView = [[LSIdCardView alloc] initWithTitle:title SubTitle:subTitle cancelBtn:cancelTitle otherBtn:otherTitle];
    cardAlertView.clicks = @[newClick,newClick1];
    
    [cardAlertView show];
}

- (void)hideAlertWithCompletion:(void(^)(void))completion{
    
    [UIView animateWithDuration:0.3 animations:^{
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.0];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        if (completion) {
            completion();
        }
    }];
}

#pragma mark - delegete
- (void)clickButton:(UIButton *)sender{
    
    [self hideAlertWithCompletion:^{
        
        if (sender.tag == 1) {
            if ([self.cardAlertDelegete respondsToSelector:@selector(clickOtherBtn:)]) {
                [self.cardAlertDelegete clickOtherBtn:sender];
            }else{
                if (self.clicks.count > 0) {
                    clickHandle handle = self.clicks[sender.tag];
                    if (![handle isEqual:[NSNull null]]) {
                        handle();
                    }
                }
            }
        }
    }];
}
- (instancetype)initWithTitle:(NSString *)title SubTitle:(NSString *)subTitle cancelBtn:(NSString *)cancel otherBtn:(NSString *)otherButton{
    if (self != nil) {
        self = [[LSIdCardView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
        
        [self addSubview:self.alertView];
        _titleLabel.text = title;
        _subTitleLabel.text = subTitle;
        [_cancelBtn setTitle:cancel forState:UIControlStateNormal];
        [_sureBtn setTitle:otherButton forState:UIControlStateNormal];
    }
    return self;
}
@end

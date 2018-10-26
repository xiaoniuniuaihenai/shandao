//
//  LSSegmentView.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/12/15.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "LSSegmentView.h"

@interface LSSegmentView ()

@property (nonatomic, strong) UIButton *firstButton;
@property (nonatomic, strong) UIButton *secondButton;
@property (nonatomic, strong) UIView *bottomLineView;

@property (nonatomic, assign) NSInteger selectedIndex;

@end

@implementation LSSegmentView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}



- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat viewWidth = self.bounds.size.width;
    CGFloat viewHeight = self.bounds.size.height;
    self.firstButton.frame = CGRectMake(0.0, 0.0, viewWidth / 2.0, viewHeight);
    self.secondButton.frame = CGRectMake(CGRectGetMaxX(self.firstButton.frame), 0.0, viewWidth / 2.0, viewHeight);
    self.bottomLineView.frame = CGRectMake(0.0, viewHeight - AdaptedHeight(2.0), AdaptedWidth(80.0), AdaptedHeight(2.0));
    if (self.selectedIndex == 1) {
        self.bottomLineView.centerX = self.secondButton.centerX;
    } else {
        self.bottomLineView.centerX = self.firstButton.centerX;
    }
}

#pragma mark - 按钮点击事件
- (void)firstButtonAction{
    [self selectConsumeLoanAuth];
    if (self.delegate && [self.delegate respondsToSelector:@selector(segmentViewSelectIndex:)]) {
        [self.delegate segmentViewSelectIndex:0];
    }
}

- (void)secondButtonAction{
    [self selectWhiteLoanAuth];
    if (self.delegate && [self.delegate respondsToSelector:@selector(segmentViewSelectIndex:)]) {
        [self.delegate segmentViewSelectIndex:1];
    }
}

//  选中消费贷认证
- (void)selectConsumeLoanAuth{
    self.firstButton.selected = YES;
    self.secondButton.selected = NO;
    self.selectedIndex = 0;
    [UIView animateWithDuration:0.48 animations:^{
        self.bottomLineView.centerX = self.firstButton.centerX;
    }];
}

//  选中白领贷认证
- (void)selectWhiteLoanAuth{
    self.firstButton.selected = NO;
    self.secondButton.selected = YES;
    self.selectedIndex = 1;
    [UIView animateWithDuration:0.48 animations:^{
        self.bottomLineView.centerX = self.secondButton.centerX;
    }];
}

#pragma mark - setter getter
- (UIButton *)firstButton{
    if (_firstButton == nil) {
        _firstButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_firstButton addTarget:self action:@selector(firstButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [_firstButton setTitleColor:[UIColor colorWithHexString:COLOR_BLACK_STR] forState:UIControlStateNormal];
        [_firstButton setTitleColor:[UIColor colorWithHexString:COLOR_RED_STR] forState:UIControlStateSelected];
        _firstButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [_firstButton setTitle:@"基本认证" forState:UIControlStateNormal];
    }
    return _firstButton;
}

- (UIButton *)secondButton{
    if (_secondButton == nil) {
        _secondButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_secondButton addTarget:self action:@selector(secondButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [_secondButton setTitleColor:[UIColor colorWithHexString:COLOR_BLACK_STR] forState:UIControlStateNormal];
        [_secondButton setTitleColor:[UIColor colorWithHexString:COLOR_RED_STR] forState:UIControlStateSelected];
        _secondButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [_secondButton setTitle:@"白领认证" forState:UIControlStateNormal];
    }
    return _secondButton;
}

- (UIView *)bottomLineView{
    if (_bottomLineView == nil) {
        _bottomLineView = [[UIView alloc] init];
        _bottomLineView.backgroundColor = [UIColor colorWithHexString:COLOR_RED_STR];
    }
    return _bottomLineView;
}
- (void)setupViews{
    [self addSubview:self.firstButton];
    [self addSubview:self.secondButton];
    [self addSubview:self.bottomLineView];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

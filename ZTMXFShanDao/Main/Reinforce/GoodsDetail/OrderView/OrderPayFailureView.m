//
//  OrderPayFailureView.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2018/1/6.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "OrderPayFailureView.h"

@interface OrderPayFailureView ()

/** 失败icon */
@property (nonatomic, strong) UIImageView *failureIcon;

/** 首页按钮 */
@property (nonatomic, strong) UIButton *homePageButton;
/** 查看订单按钮 */
@property (nonatomic, strong) UIButton *checkOrderButton;

@end

@implementation OrderPayFailureView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews{
    /** 失败icon */
    [self addSubview:self.failureIcon];
    /** 失败title */
    [self addSubview:self.failureTitleLabel];
    /** 失败描述 */
    [self addSubview:self.failureDescrition];
    /** 首页按钮 */
    [self addSubview:self.homePageButton];
    /** 查看订单按钮 */
    [self addSubview:self.checkOrderButton];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat leftMargin = AdaptedWidth(20);
    
    /** 失败icon */
    CGFloat failureIconW = AdaptedWidth(80.0);
    CGFloat failureIconX = (Main_Screen_Width - failureIconW) / 2.0;
    CGFloat failureIconY = AdaptedHeight(30.0);
    self.failureIcon.frame = CGRectMake(failureIconX, failureIconY, failureIconW, failureIconW);
    /** 失败title */
    self.failureTitleLabel.frame = CGRectMake(0.0, CGRectGetMaxY(self.failureIcon.frame) + AdaptedHeight(38.0), Main_Screen_Width, AdaptedHeight(22.0));
    /** 失败描述 */
    CGFloat failureDescritionW = Main_Screen_Width - leftMargin * 2;
    CGFloat failureDescritionH = [self.failureDescrition.text sizeWithFont:self.failureDescrition.font maxW:failureDescritionW].height;
    self.failureDescrition.frame = CGRectMake(leftMargin, CGRectGetMaxY(self.failureTitleLabel.frame) + AdaptedHeight(9.0), failureDescritionW, failureDescritionH);
    CGFloat buttonWidth = AdaptedWidth(136.0);
    CGFloat buttonHeight = AdaptedHeight(36.0);
    CGFloat buttomMargin = AdaptedWidth(22.0);
    CGFloat homePageButtonX = (Main_Screen_Width - buttonWidth * 2 - buttomMargin) / 2.0;
    CGFloat homePageButtonY = CGRectGetMaxY(self.failureDescrition.frame) + AdaptedHeight(50.0);
    /** 首页按钮 */
    self.homePageButton.frame = CGRectMake(homePageButtonX, homePageButtonY, buttonWidth, buttonHeight);
    /** 查看订单按钮 */
    self.checkOrderButton.frame = CGRectMake(CGRectGetMaxX(self.homePageButton.frame) + buttomMargin, homePageButtonY, buttonWidth, buttonHeight);

}

/** 失败icon */
- (UIImageView *)failureIcon{
    if (_failureIcon == nil) {
        _failureIcon = [[UIImageView alloc] init];
        _failureIcon.contentMode = UIViewContentModeScaleAspectFit;
        _failureIcon.image = [UIImage imageNamed:@"XL_mallAuth_failure"];
    }
    return _failureIcon;

}
/** 失败title */
- (UILabel *)failureTitleLabel{
    if (_failureTitleLabel == nil) {
        _failureTitleLabel = [UILabel labelWithTitleColorStr:COLOR_BLACK_STR fontSize:18 alignment:NSTextAlignmentCenter];
        _failureTitleLabel.text = @"";
    }
    return _failureTitleLabel;

}
/** 失败描述 */
- (UILabel *)failureDescrition{
    if (_failureDescrition == nil) {
        _failureDescrition = [UILabel labelWithTitleColorStr:COLOR_LIGHT_GRAY_STR fontSize:14 alignment:NSTextAlignmentCenter];
        _failureDescrition.text = @"";
    }
    return _failureDescrition;

}
/** 首页按钮 */
- (UIButton *)homePageButton{
    if (_homePageButton == nil) {
        _homePageButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_homePageButton setTitleColor:[UIColor colorWithHexString:COLOR_LIGHT_GRAY_STR] forState:UIControlStateNormal];
        _homePageButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_homePageButton setTitle:@"首页" forState:UIControlStateNormal];
        _homePageButton.layer.cornerRadius = AdaptedHeight(36.0) / 2.0;
        _homePageButton.layer.borderColor = [UIColor colorWithHexString:COLOR_UNUSABLE_BUTTON].CGColor;
        _homePageButton.layer.borderWidth = 1.0;
        [_homePageButton addTarget:self action:@selector(homePageButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _homePageButton;
}
/** 查看订单按钮 */
- (UIButton *)checkOrderButton{
    if (_checkOrderButton == nil) {
        _checkOrderButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_checkOrderButton setTitleColor:[UIColor colorWithHexString:COLOR_LIGHT_GRAY_STR] forState:UIControlStateNormal];
        _checkOrderButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_checkOrderButton setTitle:@"查看订单" forState:UIControlStateNormal];
        _checkOrderButton.layer.cornerRadius = AdaptedHeight(36.0) / 2.0;
        _checkOrderButton.layer.borderColor = [UIColor colorWithHexString:COLOR_UNUSABLE_BUTTON].CGColor;
        _checkOrderButton.layer.borderWidth = 1.0;
        [_checkOrderButton addTarget:self action:@selector(checkOrderButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _checkOrderButton;
}

#pragma mark - 按钮点击事件
/** 返回首页 */
- (void)homePageButtonAction{
    if (self.delegate && [self.delegate respondsToSelector:@selector(orderPayFailureViewReturnHomePage)]) {
        [self.delegate orderPayFailureViewReturnHomePage];
    }
}

/** 查看订单 */
- (void)checkOrderButtonAction{
    if (self.delegate && [self.delegate respondsToSelector:@selector(orderPayFailureViewCheckOrderDetail)]) {
        [self.delegate orderPayFailureViewCheckOrderDetail];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

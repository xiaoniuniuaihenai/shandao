//
//  OrderPaySuccessView.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2018/1/6.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "OrderPaySuccessView.h"

@interface OrderPaySuccessView ()

/** 成功icon */
@property (nonatomic, strong) UIImageView *successIcon;

/** 首页按钮 */
@property (nonatomic, strong) UIButton *homePageButton;
/** 查看订单按钮 */
@property (nonatomic, strong) UIButton *checkOrderButton;


@end

@implementation OrderPaySuccessView

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
    [self addSubview:self.successIcon];
    /** 支付title */
    [self addSubview:self.successTitleLabel];
    /** 支付金额 */
    [self addSubview:self.orderPriceLabel];
    /** 首页按钮 */
    [self addSubview:self.homePageButton];
    /** 查看订单按钮 */
    [self addSubview:self.checkOrderButton];

}

- (void)layoutSubviews{
    [super layoutSubviews];
    /** 失败icon */
    CGFloat successIconW = AdaptedWidth(80.0);
    CGFloat successIconX = (Main_Screen_Width - successIconW) / 2.0;
    CGFloat successIconY = AdaptedHeight(30.0);
    self.successIcon.frame = CGRectMake(successIconX, successIconY, successIconW, successIconW);
    /** 支付title */
    self.successTitleLabel.frame = CGRectMake(0.0, CGRectGetMaxY(self.successIcon.frame) + AdaptedHeight(28.0), Main_Screen_Width, AdaptedHeight(22.0));
    /** 支付金额 */
    self.orderPriceLabel.frame = CGRectMake(0.0, CGRectGetMaxY(self.successTitleLabel.frame) + AdaptedHeight(6.0), Main_Screen_Width, AdaptedHeight(42.0));
    
    CGFloat buttonWidth = AdaptedWidth(160);
    CGFloat buttonHeight = AdaptedHeight(40);
    CGFloat buttomMargin = AdaptedWidth(22.0);
    CGFloat homePageButtonX = (Main_Screen_Width - buttonWidth * 2 - buttomMargin) / 2.0;
    CGFloat homePageButtonY = CGRectGetMaxY(self.orderPriceLabel.frame) + AdaptedHeight(30.0);
    /** 首页按钮 */
    self.homePageButton.frame = CGRectMake(homePageButtonX, homePageButtonY, buttonWidth, buttonHeight);
    _homePageButton.centerX = self.centerX;
    /** 查看订单按钮 */
    self.checkOrderButton.frame = CGRectMake(CGRectGetMaxX(self.homePageButton.frame) + buttomMargin, _homePageButton.bottom + 18, buttonWidth, buttonHeight);
    _checkOrderButton.centerX = _homePageButton.centerX;

}

#pragma mark - getter/setter
/** 失败icon */
- (UIImageView *)successIcon{
    if (_successIcon == nil) {
        _successIcon = [[UIImageView alloc] init];
        _successIcon.contentMode = UIViewContentModeScaleAspectFit;
        _successIcon.image = [UIImage imageNamed:@"XL_mallAuth_succeed"];
    }
    return _successIcon;
    
}

/** 支付title */
- (UILabel *)successTitleLabel{
    if (_successTitleLabel == nil) {
        _successTitleLabel = [UILabel labelWithTitleColorStr:COLOR_BLACK_STR fontSize:18 alignment:NSTextAlignmentCenter];
        _successTitleLabel.text = @"";
    }
    return _successTitleLabel;
}
/** 支付金额 */
- (UILabel *)orderPriceLabel{
    if (_orderPriceLabel == nil) {
        _orderPriceLabel = [UILabel labelWithTitleColorStr:COLOR_RED_STR fontSize:24 alignment:NSTextAlignmentCenter];
        _orderPriceLabel.text = @"";
    }
    return _orderPriceLabel;
}
/** 首页按钮 */
- (UIButton *)homePageButton{
    if (_homePageButton == nil) {
        _homePageButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        [_homePageButton setTitleColor:[UIColor colorWithHexString:COLOR_LIGHT_GRAY_STR] forState:UIControlStateNormal];
        _homePageButton.backgroundColor = K_MainColor;
        _homePageButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_homePageButton setTitle:@"首页" forState:UIControlStateNormal];
        _homePageButton.layer.cornerRadius = AdaptedHeight(40) / 2.0;
//        _homePageButton.layer.borderColor = [UIColor colorWithHexString:COLOR_UNUSABLE_BUTTON].CGColor;
//        _homePageButton.layer.borderWidth = 1.0;
        [_homePageButton addTarget:self action:@selector(homePageButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _homePageButton;
}
/** 查看订单按钮 */
- (UIButton *)checkOrderButton{
    if (_checkOrderButton == nil) {
        _checkOrderButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_checkOrderButton setTitleColor:K_MainColor forState:UIControlStateNormal];
        _checkOrderButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_checkOrderButton setTitle:@"查看订单" forState:UIControlStateNormal];
        _checkOrderButton.layer.cornerRadius = AdaptedHeight(40) / 2.0;
        _checkOrderButton.layer.borderColor = K_MainColor.CGColor;
        _checkOrderButton.layer.borderWidth = 1.0;
        [_checkOrderButton addTarget:self action:@selector(checkOrderButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _checkOrderButton;
}

#pragma mark - 按钮点击事件
/** 返回首页 */
- (void)homePageButtonAction{
    if (self.delegate && [self.delegate respondsToSelector:@selector(orderPaySuccessViewReturnHomePage)]) {
        [self.delegate orderPaySuccessViewReturnHomePage];
    }
}

/** 查看订单 */
- (void)checkOrderButtonAction{
    if (self.delegate && [self.delegate respondsToSelector:@selector(orderPaySuccessViewCheckOrderDetail)]) {
        [self.delegate orderPaySuccessViewCheckOrderDetail];
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

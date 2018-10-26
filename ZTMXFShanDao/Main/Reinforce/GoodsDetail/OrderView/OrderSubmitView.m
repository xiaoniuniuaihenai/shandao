//
//  OrderSubmitView.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2018/1/5.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "OrderSubmitView.h"

@interface OrderSubmitView ()

/** 订单总额 */
@property (nonatomic, strong) UILabel *orderPriceLabel;
/** 提交订单 */
@property (nonatomic, strong) UIButton *submitButton;

@end

@implementation OrderSubmitView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews{
    /** 订单总额 */
    [self addSubview:self.orderPriceLabel];
    /** 提交订单 */
    [self addSubview:self.submitButton];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat viewHeight = self.bounds.size.height;
    CGFloat leftMargin = AdaptedWidth(16.0);
    CGFloat submitButtonW = AdaptedWidth(140.0);
    CGFloat orderPriceLabelW = Main_Screen_Width - submitButtonW - leftMargin;
    /** 订单总额 */
    self.orderPriceLabel.frame = CGRectMake(leftMargin, 0.0, orderPriceLabelW, viewHeight);
    /** 提交订单 */
    self.submitButton.frame = CGRectMake(CGRectGetMaxX(self.orderPriceLabel.frame), 0.0, submitButtonW, viewHeight);
}

#pragma mark - getter/setter
/** 订单总额 */
- (UILabel *)orderPriceLabel{
    if (_orderPriceLabel == nil) {
        _orderPriceLabel = [UILabel labelWithTitleColorStr:COLOR_GRAY_STR fontSize:16 alignment:NSTextAlignmentLeft];
        _orderPriceLabel.text = @"订单总额 96800";
    }
    return _orderPriceLabel;
}

/** 提交订单 */
- (UIButton *)submitButton{
    if (_submitButton == nil) {
        _submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_submitButton setTitle:@"提交订单" forState:UIControlStateNormal];
        [_submitButton setTitleColor:K_BtnTitleColor forState:UIControlStateNormal];
        _submitButton.titleLabel.font = [UIFont systemFontOfSize:18];
        _submitButton.backgroundColor = K_MainColor;
        [_submitButton addTarget:self action:@selector(submitButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitButton;
}

#pragma mark - 按钮点击事件
/** 点击提交订单 */
- (void)submitButtonAction{
    if (self.delegate && [self.delegate respondsToSelector:@selector(orderSubmitViewClickSubmitOrder)]) {
        [self.delegate orderSubmitViewClickSubmitOrder];
    }
}

/** 配置订单总额 */
- (void)configOrderTotalPrice:(NSString *)totalPrice{
    if (!kStringIsEmpty(totalPrice)) {
        self.orderPriceLabel.text = [NSString stringWithFormat:@"订单总额 ￥%@", totalPrice];
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

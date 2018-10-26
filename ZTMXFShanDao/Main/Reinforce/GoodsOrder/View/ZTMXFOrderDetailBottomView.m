//
//  OrderDetailBottomView.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2018/1/9.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "ZTMXFOrderDetailBottomView.h"

@interface ZTMXFOrderDetailBottomView ()
/** 右侧第一个按钮 */
@property (nonatomic, strong) UIButton *rightFirstButton;
/** 右侧第二个按钮 */
@property (nonatomic, strong) UIButton *rightSecondButton;

@end

@implementation ZTMXFOrderDetailBottomView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews{
    /** 右侧第一个按钮 */
    [self addSubview:self.rightFirstButton];
    /** 右侧第二个按钮 */
    [self addSubview:self.rightSecondButton];
    self.rightFirstButton.hidden = YES;
    self.rightSecondButton.hidden = YES;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat viewWidth = self.bounds.size.width;
    CGFloat viewHeight = self.bounds.size.height;
    CGFloat rightMargin = AdaptedWidth(8.0);
    
    /** 右侧第一个按钮 */
    CGFloat buttonWidth = AdaptedWidth(90);
    CGFloat buttonHeight = AdaptedHeight(32.0);
    CGFloat buttonMargin = AdaptedWidth(10.0);
    CGFloat rightFirstButtonX = viewWidth - buttonWidth - rightMargin;
    CGFloat buttonOriginalY = (viewHeight - buttonHeight) / 2.0;
    self.rightFirstButton.frame = CGRectMake(rightFirstButtonX, buttonOriginalY, buttonWidth, buttonHeight);
    self.rightFirstButton.layer.cornerRadius = self.rightFirstButton.height/2;
    self.rightFirstButton.layer.masksToBounds = YES;
    /** 右侧第二个按钮 */
    CGFloat rightSecondButtonX = viewWidth - buttonWidth * 2 - buttonMargin - rightMargin;
    self.rightSecondButton.frame = CGRectMake(rightSecondButtonX, buttonOriginalY, buttonWidth, buttonHeight);
    self.rightSecondButton.layer.cornerRadius = self.rightSecondButton.height/2;
    self.rightSecondButton.layer.masksToBounds = YES;
}

/** 右侧第一个按钮 */
- (UIButton *)rightFirstButton{
    if (_rightFirstButton == nil) {
        _rightFirstButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightFirstButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_rightFirstButton addTarget:self action:@selector(rightFirstButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightFirstButton;
}
/** 右侧第二个按钮 */
- (UIButton *)rightSecondButton{
    if (_rightSecondButton == nil) {
        _rightSecondButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightSecondButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_rightSecondButton addTarget:self action:@selector(rightSecondButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightSecondButton;
}



//  设置背景图片样式
- (void)setupButtonBackgroundImageStyle:(UIButton *)button{
    [button setTitleColor:K_BtnTitleColor forState:UIControlStateNormal];
    button.backgroundColor = K_MainColor;
    button.layer.cornerRadius = button.height / 2;
    button.layer.masksToBounds = YES;
    button.layer.borderWidth = 0.0;
}
//  设置边框样式按钮
- (void)setupButtonBorderStyle:(UIButton *)button{
    [button setBackgroundImage:nil forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithHexString:COLOR_LIGHT_GRAY_STR] forState:UIControlStateNormal];
    button.layer.cornerRadius = button.height / 2;
    button.layer.borderColor = [UIColor colorWithHexString:COLOR_UNUSABLE_BUTTON].CGColor;
    button.layer.borderWidth = 1.0;
}
/** 设置显示按钮 */
- (void)setTitleArray:(NSArray *)titleArray{
    if (_titleArray != titleArray) {
        _titleArray = titleArray;
    }
    
    if (_titleArray.count > 0) {
        self.backgroundColor = [UIColor whiteColor];
    } else {
        self.backgroundColor = [UIColor clearColor];
    }
    
    if (_titleArray.count == 0) {
        //  按钮都隐藏
        self.rightFirstButton.hidden = YES;
        self.rightSecondButton.hidden = YES;
    } else if (_titleArray.count == 1) {
        //  右侧第一个按钮显示, 第二个按钮隐藏
        self.rightFirstButton.hidden = NO;
        self.rightSecondButton.hidden = YES;
        
        [self.rightFirstButton setTitle:_titleArray[0] forState:UIControlStateNormal];
        
    } else if (_titleArray.count == 2) {
        //  右侧两个按钮都显示
        self.rightFirstButton.hidden = NO;
        self.rightSecondButton.hidden = NO;
        
        [self.rightFirstButton setTitle:_titleArray[0] forState:UIControlStateNormal];
        [self.rightSecondButton setTitle:_titleArray[1] forState:UIControlStateNormal];
    }
    
    //  如果是 - 去付款或者确认收货 显示背景图片样式, 其他显示边框样式
    if (!self.rightFirstButton.isHidden) {
        NSString *rightFirstTitle = self.rightFirstButton.currentTitle;
        if ([rightFirstTitle isEqualToString:kOrderButtonPay] || [rightFirstTitle isEqualToString:kOrderButtonConfirmReceive]) {
            [self setupButtonBackgroundImageStyle:self.rightFirstButton];
        } else {
            [self setupButtonBorderStyle:self.rightFirstButton];
        }
    }
    
    if (!self.rightSecondButton.isHidden) {
        NSString *rightSecondTitle = self.rightSecondButton.currentTitle;
        if ([rightSecondTitle isEqualToString:kOrderButtonPay] || [rightSecondTitle isEqualToString:kOrderButtonConfirmReceive]) {
            [self setupButtonBackgroundImageStyle:self.rightSecondButton];
        } else {
            [self setupButtonBorderStyle:self.rightSecondButton];
        }
    }
}

#pragma mark - 按钮点击事件
- (void)rightFirstButtonAction:(UIButton *)sender{
    [self orderButtonActionWithTitle:sender.currentTitle];
}

- (void)rightSecondButtonAction:(UIButton *)sender{
    [self orderButtonActionWithTitle:sender.currentTitle];
}

//  根据title请求相应事件
- (void)orderButtonActionWithTitle:(NSString *)buttonTitle{
    if ([buttonTitle isEqualToString:kOrderButtonPay]) {
        //  去付款
        if (self.delegate && [self.delegate respondsToSelector:@selector(orderDetailBottomViewClickPay)]) {
            [self.delegate orderDetailBottomViewClickPay];
        }
    } else if ([buttonTitle isEqualToString:kOrderButtonCancelOrder]) {
        //  取消订单
        if (self.delegate && [self.delegate respondsToSelector:@selector(orderDetailBottomViewClickCancelOrder)]) {
            [self.delegate orderDetailBottomViewClickCancelOrder];
        }
    } else if ([buttonTitle isEqualToString:kOrderButtonApplyRefund]) {
        //  申请退款
        if (self.delegate && [self.delegate respondsToSelector:@selector(orderDetailBottomViewClickApplyRefund)]) {
            [self.delegate orderDetailBottomViewClickApplyRefund];
        }
    } else if ([buttonTitle isEqualToString:kOrderButtonConfirmReceive]) {
        //  确认收货
        if (self.delegate && [self.delegate respondsToSelector:@selector(orderDetailBottomViewClickConfirmReceive)]) {
            [self.delegate orderDetailBottomViewClickConfirmReceive];
        }
    } else if ([buttonTitle isEqualToString:kOrderButtonViewLogistics]) {
        //  查看物流
        if (self.delegate && [self.delegate respondsToSelector:@selector(orderDetailBottomViewClickViewLogistics)]) {
            [self.delegate orderDetailBottomViewClickViewLogistics];
        }
    } else if ([buttonTitle isEqualToString:kOrderButtonRepayOrder]) {
        //  重新购买
        if (self.delegate && [self.delegate respondsToSelector:@selector(orderDetailBottomViewClickViewRepay)]) {
            [self.delegate orderDetailBottomViewClickViewRepay];
        }
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

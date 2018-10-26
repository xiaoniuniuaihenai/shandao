//
//  OrderStatusView.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2018/1/9.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "OrderStatusView.h"
#import "OrderDetailInfoModel.h"
#import "ZTMXFRefundDetailInfoModel.h"
#import "MyOrderModel.h"

@interface OrderStatusView ()

/** 背景图片 */
@property (nonatomic, strong) UIImageView *bgImageView;
/** title label */
@property (nonatomic, strong) UILabel *titleLabel;
/** describe label */
@property (nonatomic, strong) UILabel *describeLabel;
/** right Button */
@property (nonatomic, strong) UIButton *rightButton;

@end

@implementation OrderStatusView

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
    CGFloat rightMargin = AdaptedWidth(12.0);
    
    /** 背景图片 */
    self.bgImageView.frame = CGRectMake(0.0, 0.0, viewWidth, viewHeight);
    /** title label */
    CGFloat titleLeftMargin = AdaptedWidth(26.0);
    CGFloat titleWidth = viewWidth - titleLeftMargin * 2;
    CGFloat describeLabelH = [self.describeLabel.text sizeWithFont:self.describeLabel.font maxW:titleWidth].height;
    CGFloat titleLabelH = AdaptedHeight(22.0);
    if (describeLabelH < 5) {
        titleLabelH = viewHeight - AdaptedHeight(30.0);
    }
    self.titleLabel.frame = CGRectMake(titleLeftMargin, AdaptedHeight(15.0), titleWidth, titleLabelH);
    /** describe label */
    self.describeLabel.frame = CGRectMake(titleLeftMargin, CGRectGetMaxY(self.titleLabel.frame) + AdaptedHeight(10.0), viewWidth - titleLeftMargin * 2, describeLabelH);
    /** right Button */
    CGFloat buttonWidth = AdaptedWidth(90);
    CGFloat buttonHeight = AdaptedHeight(32.0);
    self.rightButton.frame = CGRectMake(viewWidth - buttonWidth - rightMargin, (viewHeight - buttonHeight) / 2.0, buttonWidth, buttonHeight);
}
- (void)setupViews{
    /** 背景图片 */
    [self addSubview:self.bgImageView];
    /** title label */
    [self addSubview:self.titleLabel];
    /** describe label */
    [self addSubview:self.describeLabel];
    /** right Button */
    [self addSubview:self.rightButton];
    self.rightButton.hidden = YES;
}



/** 背景图片 */
- (UIImageView *)bgImageView{
    if (_bgImageView == nil) {
        _bgImageView = [[UIImageView alloc] init];
        _bgImageView.userInteractionEnabled = YES;
//        _bgImageView.contentMode = UIViewContentModeScaleToFill;
        _bgImageView.backgroundColor = K_MainColor;
    }
    return _bgImageView;
}
/** title label */
- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [UILabel labelWithTitleColorStr:COLOR_WHITE_STR fontSize:16 alignment:NSTextAlignmentCenter];
        _titleLabel.font = [UIFont boldSystemFontOfSize:16];
        _titleLabel.text = @"";
    }
    return _titleLabel;
}
/** describe label */
- (UILabel *)describeLabel{
    if (_describeLabel == nil) {
        _describeLabel = [UILabel labelWithTitleColorStr:COLOR_WHITE_STR fontSize:14 alignment:NSTextAlignmentCenter];
        _describeLabel.font = [UIFont boldSystemFontOfSize:16];
        _describeLabel.text = @"";
    }
    return _describeLabel;
}
/** right Button */
- (UIButton *)rightButton{
    if (_rightButton == nil) {
        _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _rightButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_rightButton setTitle:@"查看详情" forState:UIControlStateNormal];
        _rightButton.layer.cornerRadius = AdaptedHeight(32.0) / 2.0;
        _rightButton.layer.borderColor = [UIColor whiteColor].CGColor;
        _rightButton.layer.borderWidth = 1.0;
        [_rightButton addTarget:self action:@selector(rightButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightButton;
}

#pragma mark - 按钮点击事件
- (void)rightButtonAction{
    if (self.delegate && [self.delegate respondsToSelector:@selector(orderStatusViewRefundDetail)]) {
        [self.delegate orderStatusViewRefundDetail];
    }
}

#pragma mark - 设置页面数据
//  设置商城订单详情状态Model
- (void)setOrderDetailInfoModel:(OrderDetailInfoModel *)orderDetailInfoModel{
    if (_orderDetailInfoModel != orderDetailInfoModel) {
        _orderDetailInfoModel = orderDetailInfoModel;
    }
    
    self.titleLabel.text = _orderDetailInfoModel.statusDesc;
    self.describeLabel.text = _orderDetailInfoModel.statusPrompt;
    /** 退款状态：1:退款成功 2: 退款失败 3:退款中 */
    NSInteger refundStatus = _orderDetailInfoModel.afterSaleStatus;
    if (refundStatus == 1 || refundStatus == 2 || refundStatus == 3) {
        self.rightButton.hidden = NO;
        self.titleLabel.textAlignment = NSTextAlignmentLeft;
        self.describeLabel.textAlignment = NSTextAlignmentLeft;
        self.describeLabel.font = [UIFont systemFontOfSize:12];
        
    } else {
        self.rightButton.hidden = YES;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.describeLabel.textAlignment = NSTextAlignmentCenter;
        self.describeLabel.font = [UIFont systemFontOfSize:14];
    }
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

//  设置退款详情状态Model
- (void)setRefundDetailInfoModel:(ZTMXFRefundDetailInfoModel *)refundDetailInfoModel{
    if (_refundDetailInfoModel != refundDetailInfoModel) {
        _refundDetailInfoModel = refundDetailInfoModel;
    }
    /** 售后状态：0:申请退款 1:退款成功 2.退款中 3:同意退款 -1:拒绝退货退款 */
    NSInteger refundStatus = _refundDetailInfoModel.status;
    if (refundStatus == 0) {
        self.titleLabel.text = [NSString stringWithFormat:@"申请已提交, 请等待处理"];
        self.describeLabel.text = _refundDetailInfoModel.label;
    } else if (refundStatus == 1) {
        self.titleLabel.text = [NSString stringWithFormat:@"退款成功"];
        self.describeLabel.text = @"";
    } else if (refundStatus == 2) {
        self.titleLabel.text = [NSString stringWithFormat:@"退款中..."];
        self.describeLabel.text = _refundDetailInfoModel.label;
    } else if (refundStatus == 3) {
        self.titleLabel.text = [NSString stringWithFormat:@"退款中..."];
        self.describeLabel.text = _refundDetailInfoModel.label;
    } else if (refundStatus == -1) {
        self.titleLabel.text = [NSString stringWithFormat:@"很遗憾, 您的退款申请被驳回"];
        self.describeLabel.text = [NSString stringWithFormat:@"原因: %@",_refundDetailInfoModel.checkReason];
    }

    [self setNeedsLayout];
    [self layoutIfNeeded];
}

/** 消费贷订单详情Model */
- (void)setLoanOrderDetailModel:(MyOrderDetailModel *)loanOrderDetailModel{
    _loanOrderDetailModel = loanOrderDetailModel;
    
    self.titleLabel.text = _loanOrderDetailModel.orderStatusStr;
    self.describeLabel.text = _loanOrderDetailModel.orderStatusPrompt;
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

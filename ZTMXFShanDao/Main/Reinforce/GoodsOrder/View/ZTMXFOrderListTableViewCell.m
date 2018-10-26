//
//  OrderListTableViewCell.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2018/1/6.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "ZTMXFOrderListTableViewCell.h"
#import "OrderListModel.h"
#import "ZTMXFOrderListFrame.h"
#import "ZTMXFOrderDetailInfoManager.h"
#import "OrderGoodsInfoModel.h"

@interface ZTMXFOrderListTableViewCell ()
/** 订单时间 */
@property (nonatomic, strong) UILabel *orderDateLabel;
/** 订单状态 */
@property (nonatomic, strong) UILabel *orderStateLabel;
/** 细线1 */
@property (nonatomic, strong) UIView *lineOne;

/** 商品图片 */
@property (nonatomic, strong) UIImageView *goodsImageView;
/** 商品名 */
@property (nonatomic, strong) UILabel *goodsNameLabel;
/** 商品规格 */
@property (nonatomic, strong) UILabel *goodsPropertyLabel;
/** 商品价格 */
@property (nonatomic, strong) UILabel *goodsPriceLabel;
/** 商品原价 */
@property (nonatomic, strong) UILabel *goodsOriginalPriceLabel;
/** 商品原价上面细线 */
@property (nonatomic, strong) UIView *originalPriceLine;
/** 商品个数 */
@property (nonatomic, strong) UILabel *goodsCountLabel;
/** 底部细线 */
@property (nonatomic, strong) UIView *bottomLineView;


/** 总计商品个数 */
@property (nonatomic, strong) UILabel *totalCountLabel;
/** 总价 */
@property (nonatomic, strong) UILabel *totalPriceLabel;
/** 细线2 */
@property (nonatomic, strong) UIView *lineSecond;

/** 按钮背景View */
@property (nonatomic, strong) UIView *buttonBgView;
/** 右侧第一个按钮 */
@property (nonatomic, strong) UIButton *rightFirstButton;
/** 右侧第二个按钮 */
@property (nonatomic, strong) UIButton *rightSecondButton;

/** 间隔view */
@property (nonatomic, strong) UIView *gapView;

@end

@implementation ZTMXFOrderListTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"OrderListTableViewCell";
    ZTMXFOrderListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[ZTMXFOrderListTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

/**
 *  cell的初始化方法，一个cell只会调用一次
 *  一般在这里添加所有可能显示的子控件，以及子控件的一次性设置
 */
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        // 点击cell的时候不要变色
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self setupViews];
        
    }
    return self;
}

//  添加子控件
- (void)setupViews{
    /** 订单时间 */
    [self.contentView addSubview:self.orderDateLabel];
    /** 订单状态 */
    [self.contentView addSubview:self.orderStateLabel];
    /** 细线1 */
    [self.contentView addSubview:self.lineOne];
    
    /** 商品图片 */
    [self.contentView addSubview:self.goodsImageView];
    /** 商品名 */
    [self.contentView addSubview:self.goodsNameLabel];
    /** 商品规格 */
    [self.contentView addSubview:self.goodsPropertyLabel];
    /** 商品价格 */
    [self.contentView addSubview:self.goodsPriceLabel];
    /** 商品原价 */
    [self.contentView addSubview:self.goodsOriginalPriceLabel];
    /** 商品原价上面细线 */
    [self.contentView addSubview:self.originalPriceLine];

    /** 商品个数 */
    [self.contentView addSubview:self.goodsCountLabel];
    /** 底部细线 */
    [self.contentView addSubview:self.bottomLineView];
    
    /** 总计商品个数 */
    [self.contentView addSubview:self.totalCountLabel];
    /** 总价 */
    [self.contentView addSubview:self.totalPriceLabel];
    /** 细线2 */
    [self.contentView addSubview:self.lineSecond];
    
    /** 按钮背景View */
    [self.contentView addSubview:self.buttonBgView];
    /** 右侧第一个按钮 */
    [self.buttonBgView addSubview:self.rightFirstButton];
    self.rightFirstButton.hidden = YES;
    /** 右侧第二个按钮 */
    [self.buttonBgView addSubview:self.rightSecondButton];
    self.rightSecondButton.hidden = YES;
    /** 间隔view */
    [self.contentView addSubview:self.gapView];

}


- (void)layoutSubviews
{
    [super layoutSubviews];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


/** 订单状态 */
- (UILabel *)orderStateLabel{
    if (_orderStateLabel == nil) {
        _orderStateLabel = [UILabel labelWithTitleColorStr:COLOR_RED_STR fontSize:14 alignment:NSTextAlignmentRight];
        _orderStateLabel.text = @"";
    }
    return _orderStateLabel;
}
/** 细线1 */
- (UIView *)lineOne{
    if (_lineOne == nil) {
        _lineOne = [[UIView alloc] init];
        _lineOne.backgroundColor = [UIColor colorWithHexString:COLOR_BORDER_STR];
    }
    return _lineOne;
}
/** 订单时间 */
- (UILabel *)orderDateLabel{
    if (_orderDateLabel == nil) {
        _orderDateLabel = [UILabel labelWithTitleColorStr:COLOR_BLACK_STR fontSize:15 alignment:NSTextAlignmentLeft];
        _orderDateLabel.text = @"";
    }
    return _orderDateLabel;
}
/** 商品图片 */
- (UIImageView *)goodsImageView{
    if (_goodsImageView == nil) {
        _goodsImageView = [[UIImageView alloc] init];
        _goodsImageView.userInteractionEnabled = YES;
        _goodsImageView.clipsToBounds = YES;
        _goodsImageView.contentMode = UIViewContentModeScaleAspectFill;
        _goodsImageView.image = [UIImage imageNamed:@""];
        _goodsImageView.layer.borderColor = [UIColor colorWithHexString:@"E5E5E5"].CGColor;
        _goodsImageView.layer.borderWidth = 1.0;
    }
    return _goodsImageView;
}
/** 商品名 */
- (UILabel *)goodsNameLabel{
    if (_goodsNameLabel == nil) {
        _goodsNameLabel = [UILabel labelWithTitleColorStr:COLOR_BLACK_STR fontSize:16 alignment:NSTextAlignmentLeft];
//        _goodsNameLabel.font = [UIFont boldSystemFontOfSize:16];
        _goodsNameLabel.text = @"";
    }
    return _goodsNameLabel;
}
/** 商品规格 */
- (UILabel *)goodsPropertyLabel{
    if (_goodsPropertyLabel == nil) {
        _goodsPropertyLabel = [UILabel labelWithTitleColorStr:COLOR_GRAY_STR fontSize:14 alignment:NSTextAlignmentLeft];
        _goodsPropertyLabel.text = @"";
    }
    return _goodsPropertyLabel;
}
/** 商品价格 */
- (UILabel *)goodsPriceLabel{
    if (_goodsPriceLabel == nil) {
        _goodsPriceLabel = [UILabel labelWithTitleColorStr:COLOR_BLACK_STR fontSize:14 alignment:NSTextAlignmentRight];
        _goodsPriceLabel.text = @"";
    }
    return _goodsPriceLabel;
}
/** 商品原价 */
- (UILabel *)goodsOriginalPriceLabel{
    if (_goodsOriginalPriceLabel == nil) {
        _goodsOriginalPriceLabel = [UILabel labelWithTitleColorStr:COLOR_LIGHT_GRAY_STR fontSize:14 alignment:NSTextAlignmentRight];
        _goodsOriginalPriceLabel.text = @"";
    }
    return _goodsOriginalPriceLabel;
}
/** 商品原价上面细线 */
- (UIView *)originalPriceLine{
    if (_originalPriceLine == nil) {
        _originalPriceLine = [[UIView alloc] init];
        _originalPriceLine.backgroundColor = [UIColor colorWithHexString:COLOR_LIGHT_GRAY_STR];
    }
    return _originalPriceLine;
}
/** 商品个数 */
- (UILabel *)goodsCountLabel{
    if (_goodsCountLabel == nil) {
        _goodsCountLabel = [UILabel labelWithTitleColorStr:COLOR_GRAY_STR fontSize:14 alignment:NSTextAlignmentRight];
        _goodsCountLabel.text = @"";
    }
    return _goodsCountLabel;
}

/** 细线 */
- (UIView *)bottomLineView{
    if (_bottomLineView == nil) {
        _bottomLineView = [[UIView alloc] init];
        _bottomLineView.backgroundColor = [UIColor colorWithHexString:COLOR_BORDER_STR];
    }
    return _bottomLineView;
}


/** 总计商品个数 */
- (UILabel *)totalCountLabel{
    if (_totalCountLabel == nil) {
        _totalCountLabel = [UILabel labelWithTitleColorStr:COLOR_GRAY_STR fontSize:14 alignment:NSTextAlignmentLeft];
        _totalCountLabel.text = @"";
    }
    return _totalCountLabel;
}
/** 总价 */
- (UILabel *)totalPriceLabel{
    if (_totalPriceLabel == nil) {
        _totalPriceLabel = [UILabel labelWithTitleColorStr:COLOR_BLACK_STR fontSize:14 alignment:NSTextAlignmentRight];
        _totalPriceLabel.text = @"";
    }
    return _totalPriceLabel;
}
/** 细线2 */
- (UIView *)lineSecond{
    if (_lineSecond == nil) {
        _lineSecond = [[UIView alloc] init];
        _lineSecond.backgroundColor = [UIColor colorWithHexString:COLOR_BORDER_STR];
    }
    return _lineSecond;
}

/** 按钮背景View */
- (UIView *)buttonBgView{
    if (_buttonBgView == nil) {
        _buttonBgView = [[UIView alloc] init];
        _buttonBgView.backgroundColor = [UIColor whiteColor];
    }
    return _buttonBgView;
}

/** 右侧第一个按钮 */
- (UIButton *)rightFirstButton{
    if (_rightFirstButton == nil) {
        _rightFirstButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rightFirstButton setTitleColor:[UIColor colorWithHexString:COLOR_LIGHT_GRAY_STR] forState:UIControlStateNormal];
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

/** 间隔view */
- (UIView *)gapView{
    if (_gapView == nil) {
        _gapView = [[UIView alloc] init];
        _gapView.backgroundColor = [UIColor colorWithHexString:COLOR_LIGHTBG_STR];
    }
    return _gapView;
}

#pragma mark - 按钮点击事件
/** 右侧第一个按钮点击 */
- (void)rightFirstButtonAction:(UIButton *)sender{
    [self orderButtonActionWithTitle:sender.currentTitle];
}

/** 右侧第二个按钮点击 */
- (void)rightSecondButtonAction:(UIButton *)sender{
    [self orderButtonActionWithTitle:sender.currentTitle];
}
//  根据title请求相应事件
- (void)orderButtonActionWithTitle:(NSString *)buttonTitle{
    if ([buttonTitle isEqualToString:kOrderButtonPay]) {
        //  去付款
        if (self.delegate && [self.delegate respondsToSelector:@selector(orderListViewClickPay:)]) {
            [self.delegate orderListViewClickPay:self.orderListModel];
        }
    } else if ([buttonTitle isEqualToString:kOrderButtonCancelOrder]) {
        //  取消订单
        if (self.delegate && [self.delegate respondsToSelector:@selector(orderListViewClickCancelOrder:)]) {
            [self.delegate orderListViewClickCancelOrder:self.orderListModel];
        }
    } else if ([buttonTitle isEqualToString:kOrderButtonApplyRefund]) {
        //  申请退款
        if (self.delegate && [self.delegate respondsToSelector:@selector(orderListViewClickApplyRefund:)]) {
            [self.delegate orderListViewClickApplyRefund:self.orderListModel];
        }
    } else if ([buttonTitle isEqualToString:kOrderButtonCheckRefundDetail]) {
        //  查看退款详情
        if (self.delegate && [self.delegate respondsToSelector:@selector(orderListViewClickViewRefundDetail:)]) {
            [self.delegate orderListViewClickViewRefundDetail:self.orderListModel];
        }
    } else if ([buttonTitle isEqualToString:kOrderButtonConfirmReceive]) {
        //  确认收货
        if (self.delegate && [self.delegate respondsToSelector:@selector(orderListViewClickConfirmReceive:)]) {
            [self.delegate orderListViewClickConfirmReceive:self.orderListModel];
        }
    } else if ([buttonTitle isEqualToString:kOrderButtonViewLogistics]) {
        //  查看物流
        if (self.delegate && [self.delegate respondsToSelector:@selector(orderListViewClickViewLogistics:)]) {
            [self.delegate orderListViewClickViewLogistics:self.orderListModel];
        }
    } else if ([buttonTitle isEqualToString:kOrderButtonWriteAddress]) {
        //  填写地址
        if (self.delegate && [self.delegate respondsToSelector:@selector(orderListViewClickWriteAddress:)]) {
            [self.delegate orderListViewClickWriteAddress:self.orderListModel];
        }
    } else if ([buttonTitle isEqualToString:kOrderButtonRepayOrder]) {
        //  重新购买
        if (self.delegate && [self.delegate respondsToSelector:@selector(orderListViewClickViewRepayMobile:)]) {
            [self.delegate orderListViewClickViewRepayMobile:self.orderListModel];
        }
    }
}

#pragma mark - 设置订单数据
- (void)setOrderListFrame:(ZTMXFOrderListFrame *)orderListFrame{
    _orderListFrame = orderListFrame;
    _orderListModel = _orderListFrame.orderListModel;
    
    /** 订单时间 */
    NSString *orderDate = [NSDate dateStringFromLongDate:_orderListModel.gmtCreate];
    self.orderDateLabel.text = [NSString stringWithFormat:@"购买时间 %@", orderDate];
    /** 订单状态 */
    self.orderStateLabel.text = _orderListModel.statusDesc;;
    
    /** 商品图片 */
    [self.goodsImageView sd_setImageWithURL:[NSURL URLWithString:_orderListModel.goodsInfo.goodsIcon]];
    /** 商品名 */
    self.goodsNameLabel.text = _orderListModel.goodsInfo.title;
    /** 商品规格 */
    self.goodsPropertyLabel.text = _orderListModel.goodsInfo.propertyValueNames;
    /** 商品价格 */
    self.goodsPriceLabel.text = [NSString stringWithFormat:@"￥%.2f", _orderListModel.goodsInfo.actualAmount];
    /** 商品原价 */
    /** 订单类型 1 消费贷 2 分期商城 3 手机充值*/
    if (_orderListModel.orderType == 2) {
        self.goodsOriginalPriceLabel.hidden = YES;
        self.originalPriceLine.hidden = YES;
    } else {
        self.goodsOriginalPriceLabel.hidden = NO;
        self.originalPriceLine.hidden = NO;
        self.goodsOriginalPriceLabel.text =  [NSString stringWithFormat:@"￥%.2f", _orderListModel.goodsInfo.priceAmount];
    }
    /** 商品个数 */
    self.goodsCountLabel.text = [NSString stringWithFormat:@"x%ld", _orderListModel.goodsInfo.count];
    
    
    /** 总计商品个数 */
    self.totalCountLabel.text =  [NSString stringWithFormat:@"共计%ld件商品", _orderListModel.totalCount];
    /** 总价 */
    self.totalPriceLabel.text = [NSString stringWithFormat:@"合计: ￥%.2f", _orderListModel.totalAmount];
    
    //  布局frame
    [self setupFrames];
}

//  布局frame
- (void)setupFrames{
    CGFloat viewWidth = Main_Screen_Width;
    CGFloat leftMargin = AdaptedWidth(12);
    
    /** 订单时间 */
    self.orderDateLabel.frame = CGRectMake(leftMargin, 0.0, viewWidth - AdaptedWidth(70.0), AdaptedHeight(40.0));
    /** 订单状态 */
    CGFloat orderStateLabelW = AdaptedWidth(120.0);
    self.orderStateLabel.frame = CGRectMake(viewWidth - leftMargin - orderStateLabelW, 0.0, orderStateLabelW, AdaptedHeight(40.0));
    /** 细线1 */
    self.lineOne.frame = CGRectMake(0.0, CGRectGetMaxY(self.orderStateLabel.frame), Main_Screen_Width, 0.5);
    
    /** 商品图片 */
    CGFloat goodsImageViweW = AdaptedWidth(70.0);
    self.goodsImageView.frame = CGRectMake(leftMargin, CGRectGetMaxY(self.lineOne.frame) + AdaptedHeight(9.0), goodsImageViweW, goodsImageViweW);
    /** 商品名 */
    CGFloat goodsNameLabelW = AdaptedWidth(170.0);
    NSString *demoName = @"";
    CGFloat maxGoodsNameLabelH = [demoName sizeWithFont:self.goodsNameLabel.font maxW:goodsNameLabelW].height;
    CGFloat goodsNameLabelH = [self.goodsNameLabel.text sizeWithFont:self.goodsNameLabel.font maxW:goodsNameLabelW].height;
    if (goodsNameLabelH > maxGoodsNameLabelH) {
        goodsNameLabelH = maxGoodsNameLabelH;
    }
    self.goodsNameLabel.frame = CGRectMake(CGRectGetMaxX(self.goodsImageView.frame) + AdaptedWidth(14.0), CGRectGetMinY(self.goodsImageView.frame), goodsNameLabelW, goodsNameLabelH);
    /** 商品规格 */
    self.goodsPropertyLabel.frame = CGRectMake(CGRectGetMinX(self.goodsNameLabel.frame), CGRectGetMaxY(self.goodsImageView.frame) - AdaptedHeight(20.0), viewWidth - 180.0, AdaptedHeight(20.0));
    /** 商品价格 */
    CGFloat goodsPriceLabelW = AdaptedWidth(100.0);
    self.goodsPriceLabel.frame = CGRectMake(viewWidth - goodsPriceLabelW - leftMargin, CGRectGetMaxY(self.lineOne.frame) + AdaptedHeight(9.0), goodsPriceLabelW, AdaptedHeight(20.0));
    /** 商品原价 */
    CGFloat goodsOriginalPriceLabelW = [self.goodsOriginalPriceLabel.text sizeWithFont:self.goodsOriginalPriceLabel.font maxW:MAXFLOAT].width;
    CGFloat goodsOriginalPriceLabelX = viewWidth - goodsOriginalPriceLabelW - leftMargin;
    self.goodsOriginalPriceLabel.frame = CGRectMake(goodsOriginalPriceLabelX, CGRectGetMaxY(self.goodsPriceLabel.frame), goodsOriginalPriceLabelW, AdaptedHeight(20.0));
    /** 商品原价上面细线 */
    CGFloat originalPriceLineW = goodsOriginalPriceLabelW + 5.0;
    CGFloat originalPriceLineX = viewWidth - originalPriceLineW - leftMargin;
    self.originalPriceLine.frame = CGRectMake(originalPriceLineX, CGRectGetMinY(self.goodsOriginalPriceLabel.frame) + AdaptedHeight(10.0), originalPriceLineW, 1.0);
    /** 商品个数 */
    CGFloat goodsCountLabelW = AdaptedWidth(120.0);
    self.goodsCountLabel.frame = CGRectMake(viewWidth - goodsCountLabelW - leftMargin, CGRectGetMinY(self.goodsPropertyLabel.frame), goodsCountLabelW, CGRectGetHeight(self.goodsPropertyLabel.frame));
    /** 底部细线 */
    self.bottomLineView.frame = CGRectMake(0.0, CGRectGetMaxY(self.goodsImageView.frame) + AdaptedHeight(10.0), Main_Screen_Width, 0.5);
    
    
    /** 总计商品个数 */
    self.totalCountLabel.frame = CGRectMake(leftMargin, CGRectGetMaxY(self.bottomLineView.frame), AdaptedWidth(200.0), AdaptedHeight(45.0));
    /** 总价 */
    CGFloat totalPriceLabelW = AdaptedWidth(220.0);
    self.totalPriceLabel.frame = CGRectMake(viewWidth - totalPriceLabelW - leftMargin, CGRectGetMinY(self.totalCountLabel.frame), totalPriceLabelW, CGRectGetHeight(self.totalCountLabel.frame));
    /** 细线2 */
    self.lineSecond.frame = CGRectMake(0.0, CGRectGetMaxY(self.totalCountLabel.frame), Main_Screen_Width, 0.5);
    
    /** 按钮背景view */
    if (_orderListFrame.buttonBgViewHeight > 0) {
        self.buttonBgView.frame = CGRectMake(0.0, CGRectGetMaxY(self.lineSecond.frame), viewWidth, AdaptedHeight(50.0));
        
        //  显示什么按钮
        self.rightFirstButton.hidden = NO;
        self.rightSecondButton.hidden = NO;
        /** 订单类型 1 消费贷 2 分期商城 3 手机充值 */
        if (_orderListModel.orderType == 2) {
            //  分期商城订单
            NSArray *titleArray = [ZTMXFOrderDetailInfoManager buttonTitleArrayFromeStatus:_orderListModel.status refundStatus:_orderListModel.afterSaleStatus orderType:MallOrderType];
            if (titleArray.count == 1) {
                self.rightFirstButton.hidden = NO;
                [self.rightFirstButton setTitle:titleArray[0] forState:UIControlStateNormal];

                self.rightSecondButton.hidden = YES;
            } else if (titleArray.count == 2) {
                self.rightFirstButton.hidden = NO;
                self.rightSecondButton.hidden = NO;
                [self.rightFirstButton setTitle:titleArray[0] forState:UIControlStateNormal];
                [self.rightSecondButton setTitle:titleArray[1] forState:UIControlStateNormal];
            } else {
                self.rightFirstButton.hidden = YES;
                self.rightSecondButton.hidden = YES;
            }
        } else if(_orderListModel.orderType == 1) {
            //  消费贷订单
            /** 消费贷：【1:交易成功；2:待发货；3:已发货；4订单关闭；-1：填写收货地址】 */
            NSArray *titleArray = [ZTMXFOrderDetailInfoManager buttonTitleArrayFromeStatus:_orderListModel.status refundStatus:_orderListModel.afterSaleStatus orderType:ConsumeLoanOrderType];
            if (_orderListModel.status == -1) {
                self.rightFirstButton.hidden = NO;
                [self.rightFirstButton setTitle:titleArray[0] forState:UIControlStateNormal];
                self.rightSecondButton.hidden = YES;
            } else {
                self.rightFirstButton.hidden = YES;
                self.rightSecondButton.hidden = YES;
            }
        } else if (_orderListModel.orderType == 3) {
            //  手机充值订单
            NSArray *titleArray = [ZTMXFOrderDetailInfoManager buttonTitleArrayFromeStatus:_orderListModel.status refundStatus:_orderListModel.afterSaleStatus orderType:MobileOrderType];
            if (titleArray.count == 1) {
                self.rightFirstButton.hidden = NO;
                [self.rightFirstButton setTitle:titleArray[0] forState:UIControlStateNormal];
                self.rightSecondButton.hidden = YES;
            } else if (titleArray.count == 2) {
                self.rightFirstButton.hidden = NO;
                self.rightSecondButton.hidden = NO;
                [self.rightFirstButton setTitle:titleArray[0] forState:UIControlStateNormal];
                [self.rightSecondButton setTitle:titleArray[1] forState:UIControlStateNormal];
            } else {
                self.rightFirstButton.hidden = YES;
                self.rightSecondButton.hidden = YES;
            }
        }
        //  如果是 - 去付款或者确认收货 显示背景图片样式, 其他显示边框样式
        if (!self.rightFirstButton.isHidden) {
            NSString *rightFirstTitle = self.rightFirstButton.currentTitle;
            if ([rightFirstTitle isEqualToString:kOrderButtonPay] || [rightFirstTitle isEqualToString:kOrderButtonConfirmReceive]   || [rightFirstTitle isEqualToString:kOrderButtonCheckRefundDetail]) {
                [self setupButtonBackgroundImageStyle:self.rightFirstButton];
            } else {
                [self setupButtonBorderStyle:self.rightFirstButton];
            }
        }
        
        if (!self.rightSecondButton.isHidden) {
            NSString *rightSecondTitle = self.rightSecondButton.currentTitle;
            if ([rightSecondTitle isEqualToString:kOrderButtonPay] || [rightSecondTitle isEqualToString:kOrderButtonConfirmReceive]  ) {
                [self setupButtonBackgroundImageStyle:self.rightSecondButton];
            } else {
                [self setupButtonBorderStyle:self.rightSecondButton];
            }
        }
        
//        if ([self.rightSecondButton.currentTitle isEqualToString:kOrderButtonCheckRefundDetail]) {
//            [self setupButtonBackgroundImageStyle:self.rightSecondButton];
//        }
        /** 右侧第一个按钮 */
        CGFloat buttonWidth = AdaptedWidth(90);
        CGFloat buttonHeight = AdaptedHeight(32.0);
        CGFloat buttonMargin = AdaptedWidth(10.0);
        CGFloat rightFirstButtonX = viewWidth - buttonWidth - leftMargin;
        CGFloat buttonOriginalY = (CGRectGetHeight(self.buttonBgView.frame) - buttonHeight) / 2.0;
        self.rightFirstButton.frame = CGRectMake(rightFirstButtonX, buttonOriginalY, buttonWidth, buttonHeight);
        self.rightFirstButton.layer.cornerRadius = self.rightFirstButton.height/2;
        self.rightFirstButton.layer.masksToBounds = YES;
        /** 右侧第二个按钮 */
        CGFloat rightSecondButtonX = viewWidth - buttonWidth * 2 - buttonMargin - leftMargin;
        self.rightSecondButton.frame = CGRectMake(rightSecondButtonX, buttonOriginalY, buttonWidth, buttonHeight);
        self.rightSecondButton.layer.cornerRadius = self.rightSecondButton.height/2;
        self.rightSecondButton.layer.masksToBounds = YES;
    } else {
        self.buttonBgView.frame = CGRectMake(0.0, CGRectGetMaxY(self.lineSecond.frame), viewWidth, 0.0);
        self.rightFirstButton.hidden = YES;
        self.rightSecondButton.hidden = YES;
    }
    
    /** 间隔view */
    self.gapView.frame = CGRectMake(0.0, CGRectGetMaxY(self.buttonBgView.frame), Main_Screen_Width, AdaptedHeight(10.0));
}

//  设置边框样式按钮
- (void)setupButtonBorderStyle:(UIButton *)button{
    [button setBackgroundImage:nil forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithHexString:COLOR_LIGHT_GRAY_STR] forState:UIControlStateNormal];
    button.layer.cornerRadius = 3;
    button.backgroundColor = [UIColor whiteColor];
    button.layer.borderColor = [UIColor colorWithHexString:COLOR_UNUSABLE_BUTTON].CGColor;
    button.layer.borderWidth = 1.0;
}

//  设置背景图片样式
- (void)setupButtonBackgroundImageStyle:(UIButton *)button{
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.backgroundColor = K_MainColor;
    button.layer.cornerRadius = 3.0;
    button.layer.masksToBounds = YES;
    button.layer.borderWidth = 0.0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

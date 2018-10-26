//
//  PaymentOrderView.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2018/1/5.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "PaymentOrderView.h"
#import "ALATitleValueCellView.h"
#import "InstallmentInfoView.h"
#import "OrderPayDetailModel.h"
#import "GoodsNperInfoModel.h"
#import "BankCardModel.h"
#import "ZTMXFMallAuthManager.h"
#import "InstallmentCellView.h"
#import "GetUserInfoApi.h"
#import "ZTMXFSetPasswordAlertView.h"
#import "RealNameManager.h"
#import "UIViewController+Visible.h"
@interface PaymentOrderView ()<InstallmentInfoViewDelegate>

@property (nonatomic, strong) UIScrollView *mainScrollView;

/** 订单金额 */
@property (nonatomic, strong) ALATitleValueCellView *orderPriceView;
/** 选择支付方式 */
@property (nonatomic, strong) UILabel *paymentTitleLabel;

/** 选择分期支付按钮 */
@property (nonatomic, strong) UIButton *installmentButton;
/** 选择银行卡支付按钮 */
@property (nonatomic, strong) UIButton *bankCardPayButton;
/** 讯秒支付 */
@property (nonatomic, strong) InstallmentCellView *platformPayView;

/** 银行卡 */
@property (nonatomic, strong) ALATitleValueCellView *bankCardView;

/** 分期信息view */
@property (nonatomic, strong) InstallmentInfoView *installmentView;
/** 协议按钮 */
@property (nonatomic, strong) UIButton *protocolButton;
/** 协议view */
@property (nonatomic, strong) UIView *protocolView;

/** 支付按钮 */
@property (nonatomic, strong) UIButton *payButton;

/** 当前分期Model */
@property (nonatomic, strong) GoodsNperInfoModel *currentNperInfoModel;

@end

@implementation PaymentOrderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
        self.backgroundColor = [UIColor colorWithHexString:COLOR_LIGHTBG_STR];
    }
    return self;
}

- (void)setupViews{
    /** scrollView */
    [self addSubview:self.mainScrollView];
    
    /** 订单金额 */
    [self.mainScrollView addSubview:self.orderPriceView];
    /** 选择支付方式 */
    [self.mainScrollView addSubview:self.paymentTitleLabel];
    
    
    /** 讯秒 */
    [self.mainScrollView addSubview:self.platformPayView];
    
    /** 选择分期支付按钮 */
    [self.mainScrollView addSubview:self.installmentButton];
    
    
    /** 银行卡view */
    [self.mainScrollView addSubview:self.bankCardView];
    /** 选择银行卡支付按钮 */
    [self.mainScrollView addSubview:self.bankCardPayButton];
    
    /** 分期信息view */
    [self.mainScrollView addSubview:self.installmentView];
    /** 协议按钮 */
    [self addSubview:self.protocolView];
    
    
    if ([LoginManager appReviewState]) {
        self.platformPayView.hidden = YES;
        self.installmentButton.hidden = YES;
        self.protocolView.hidden = YES;
        self.installmentView.hidden = YES;

    }else{
        self.platformPayView.hidden = NO;
        self.installmentButton.hidden = NO;
        self.protocolView.hidden = NO;
        self.installmentView.hidden = NO;
    }
    
    /** 支付按钮 */
    [self addSubview:self.payButton];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat leftMargin = AdaptedWidth(12.0);
    CGFloat viewHeight = self.bounds.size.height;
    CGFloat viewWidth = self.bounds.size.width;
    
    /** scrollView */
    self.mainScrollView.frame = CGRectMake(0.0, 0.0, viewWidth, viewHeight-AdaptedHeight(60.0)-40.0);
    
    /** 订单金额 */
    self.orderPriceView.frame = CGRectMake(0.0, 0.0, viewWidth, AdaptedHeight(49.0));
    /** 选择支付方式 */
    self.paymentTitleLabel.frame = CGRectMake(leftMargin, CGRectGetMaxY(self.orderPriceView.frame) + AdaptedHeight(14.0), viewWidth, AdaptedHeight(16.0));
    
    /** 选择分期支付按钮 */
    self.installmentButton.frame = CGRectMake(0.0, CGRectGetMaxY(self.paymentTitleLabel.frame) + AdaptedHeight(10.0), 30.0, AdaptedHeight(60.0));
    /** 讯秒 */
    self.platformPayView.frame = CGRectMake(CGRectGetMaxX(self.installmentButton.frame), CGRectGetMinY(self.installmentButton.frame), viewWidth - CGRectGetWidth(self.installmentButton.frame), CGRectGetHeight(self.installmentButton.frame));
    if ([LoginManager appReviewState]) {
        /** 选择银行卡支付按钮 */
        self.bankCardPayButton.frame = CGRectMake(0.0, CGRectGetMaxY(self.installmentButton.frame) - AdaptedHeight(60.0), CGRectGetWidth(self.installmentButton.frame), AdaptedHeight(60.0));
    }else{
        /** 选择银行卡支付按钮 */
        self.bankCardPayButton.frame = CGRectMake(0.0, CGRectGetMaxY(self.installmentButton.frame), CGRectGetWidth(self.installmentButton.frame), AdaptedHeight(60.0));
    }
    /** 银行卡 */
    self.bankCardView.frame = CGRectMake(CGRectGetMaxX(self.bankCardPayButton.frame) - leftMargin, CGRectGetMinY(self.bankCardPayButton.frame), viewWidth - CGRectGetWidth(self.bankCardPayButton.frame) + leftMargin, CGRectGetHeight(self.bankCardPayButton.frame));
    
    /** 分期信息view */
    self.installmentView.frame = CGRectMake(0.0, CGRectGetMaxY(self.bankCardPayButton.frame) + AdaptedHeight(10.0), viewWidth, AdaptedHeight(260.0));
    
    if (self.bankCardPayButton.selected) {
        self.mainScrollView.frame = CGRectMake(0.0, 0.0, viewWidth, self.bankCardView.bottom);
        self.mainScrollView.contentSize = CGSizeMake(0.0, 0.0);
    } else {
        self.mainScrollView.frame = CGRectMake(0.0, 0.0, viewWidth, viewHeight-AdaptedHeight(60.0)-40.0);
    }
    
    /** 协议view */
    self.protocolView.frame = CGRectMake(0.0, CGRectGetMaxY(self.mainScrollView.frame)+10, viewWidth, 40.0);
    /** 支付按钮 */
    self.payButton.frame = CGRectMake(0.0, viewHeight - AdaptedHeight(50.0), viewWidth, AdaptedHeight(50.0));

}

#pragma mark - getter/setter
/** scrollView */
- (UIScrollView *)mainScrollView{
    if (_mainScrollView == nil) {
        _mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0, 0.0, Main_Screen_Width, self.height - AdaptedHeight(50) - 40.0)];
        _mainScrollView.backgroundColor = [UIColor colorWithHexString:COLOR_LIGHTBG_STR];
        _mainScrollView.showsHorizontalScrollIndicator = NO;
        _mainScrollView.showsVerticalScrollIndicator = NO;
    }
    return _mainScrollView;
}

/** 订单金额 */
- (ALATitleValueCellView *)orderPriceView{
    if (_orderPriceView == nil) {
        _orderPriceView = [[ALATitleValueCellView alloc] initWithTitle:@"订单总额" value:@"" target:nil action:nil];
        _orderPriceView.backgroundColor = [UIColor whiteColor];
        _orderPriceView.titleColorStr = COLOR_BLACK_STR;
        _orderPriceView.valueColorStr = COLOR_RED_STR;
        _orderPriceView.titleFont = [UIFont systemFontOfSize:14];
        _orderPriceView.valueFont = [UIFont systemFontOfSize:14];
        _orderPriceView.showRowImageView = NO;
        _orderPriceView.showBottomLineView = NO;
    }
    return _orderPriceView;
}
/** 选择支付方式 */
- (UILabel *)paymentTitleLabel{
    if (_paymentTitleLabel == nil) {
        _paymentTitleLabel = [UILabel labelWithTitleColorStr:COLOR_LIGHT_GRAY_STR fontSize:14 alignment:NSTextAlignmentLeft];
        _paymentTitleLabel.text = @"请选择支付方式";
    }
    return _paymentTitleLabel;
}

/** 选择分期支付按钮 */
- (UIButton *)installmentButton{
    if (_installmentButton == nil) {
        _installmentButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_installmentButton setImage:[UIImage imageNamed:@"XL_bill_selected"] forState:UIControlStateSelected];
        [_installmentButton setImage:[UIImage imageNamed:@"XL_bill_normal"] forState:UIControlStateNormal];
        [_installmentButton setContentMode:UIViewContentModeScaleAspectFit];
        _installmentButton.backgroundColor = [UIColor whiteColor];
        _installmentButton.selected = YES;
        [_installmentButton addTarget:self action:@selector(installmentButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _installmentButton;
}
/** 选择银行卡支付按钮 */
- (UIButton *)bankCardPayButton{
    if (_bankCardPayButton == nil) {
        _bankCardPayButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_bankCardPayButton setImage:[UIImage imageNamed:@"XL_bill_selected"] forState:UIControlStateSelected];
        [_bankCardPayButton setImage:[UIImage imageNamed:@"XL_bill_normal"] forState:UIControlStateNormal];
        [_bankCardPayButton setContentMode:UIViewContentModeScaleAspectFit];
        _bankCardPayButton.backgroundColor = [UIColor whiteColor];
        [_bankCardPayButton addTarget:self action:@selector(bankCardPayButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bankCardPayButton;
}

/** 讯秒view */
- (InstallmentCellView *)platformPayView{
    if (_platformPayView == nil) {
        _platformPayView = [[InstallmentCellView alloc] initWithTitle:@"闪到" value:@"" target:self action:@selector(platformPayViewAction)];
        _platformPayView.titleImageStr = @"installment_icon";
    }
    return _platformPayView;
}

/** 银行卡信息view */
- (ALATitleValueCellView *)bankCardView{
    if (_bankCardView == nil) {
        _bankCardView = [[ALATitleValueCellView alloc] initWithTitle:@"银行卡支付" value:@"" target:self action:@selector(bankCardViewAction)];
        _bankCardView.backgroundColor = [UIColor whiteColor];
        _bankCardView.titleColorStr = COLOR_BLACK_STR;
        _bankCardView.valueColorStr = COLOR_BLACK_STR;
        _bankCardView.titleImageStr = @"bankCard_pay_icon";
        _bankCardView.titleImageMargin = AdaptedWidth(10.0);
        _bankCardView.titleFont = [UIFont systemFontOfSize:14];
        _bankCardView.valueFont = [UIFont systemFontOfSize:14];
        _bankCardView.showRowImageView = YES;
        _bankCardView.showBottomLineView = NO;
    }
    return _bankCardView;
}

/** 分期信息view */
- (InstallmentInfoView *)installmentView{
    if (_installmentView == nil) {
        _installmentView = [[InstallmentInfoView alloc] init];
        _installmentView.backgroundColor = [UIColor whiteColor];
        _installmentView.delegate = self;
        _installmentView.hidden = YES;
    }
    return _installmentView;
}
/** 协议按钮 */
- (UIButton *)protocolButton{
    if (_protocolButton == nil) {
        _protocolButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_protocolButton setTitle:@" 我已阅读并同意" forState:UIControlStateNormal];
        [_protocolButton setTitleColor:[UIColor colorWithHexString:COLOR_LIGHT_STR1] forState:UIControlStateNormal];
        _protocolButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [_protocolButton setBackgroundColor:[UIColor colorWithHexString:COLOR_LIGHTBG_STR]];
        [_protocolButton setImage:[UIImage imageNamed:@"protocol_normal"] forState:UIControlStateNormal];
        [_protocolButton setImage:[UIImage imageNamed:@"protocol_selected"] forState:UIControlStateSelected];
        _protocolButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_protocolButton addTarget:self action:@selector(clickProtocolButton:) forControlEvents:UIControlEventTouchUpInside];
        _protocolButton.selected = YES;
    }
    return _protocolButton;
}

- (UIView *)protocolView{
    if (_protocolView == nil) {
        _protocolView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, Main_Screen_Width, 40.0)];
        _protocolView.backgroundColor = [UIColor colorWithHexString:COLOR_LIGHTBG_STR];
        
        CGSize protocolBtnSize = [@"我已阅读并同意" sizeWithFont:[UIFont systemFontOfSize:12] maxW:Main_Screen_Width];
        self.protocolButton.frame = CGRectMake(9.0, 0.0, protocolBtnSize.width+18.0, protocolBtnSize.height);
        
        NSString *protocolStr = @"《消费分期借款协议》";
        CGSize buttonSize = [protocolStr sizeWithFont:[UIFont systemFontOfSize:12] maxW:Main_Screen_Width];
        UIButton *firstProtocolBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [firstProtocolBtn setTitle:protocolStr forState:UIControlStateNormal];
        [firstProtocolBtn setTitleColor:[UIColor colorWithHexString:COLOR_BLUE_STR] forState:UIControlStateNormal];
        firstProtocolBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [firstProtocolBtn setBackgroundColor:[UIColor colorWithHexString:COLOR_LIGHTBG_STR]];
        [firstProtocolBtn setFrame:CGRectMake(CGRectGetMaxX(self.protocolButton.frame), CGRectGetMinY(self.protocolButton.frame), buttonSize.width, buttonSize.height)];
        [firstProtocolBtn addTarget:self action:@selector(clickLoanProtocol) forControlEvents:UIControlEventTouchUpInside];
        
        NSString *allStr = @"我已阅读并同意《消费分期借款协议》·《委托融资协议》";
        CGSize labelSize = [allStr sizeWithFont:[UIFont systemFontOfSize:12] maxW:Main_Screen_Width-50];
        UILabel *protocolLabel = [UILabel labelWithTitleColor:[UIColor colorWithHexString:COLOR_BLUE_STR] fontSize:12 alignment:NSTextAlignmentLeft];
        [protocolLabel setBackgroundColor:[UIColor colorWithHexString:COLOR_LIGHTBG_STR]];
        [protocolLabel setFrame:CGRectMake(30.0, CGRectGetMinY(self.protocolButton.frame), Main_Screen_Width-50, labelSize.height)];
        protocolLabel.numberOfLines = 0;
        protocolLabel.text = allStr;
        protocolLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickCooperateProtocol)];
        tap.numberOfTapsRequired = 1;
        tap.numberOfTouchesRequired = 1;
        [protocolLabel addGestureRecognizer:tap];
        
        [_protocolView addSubview:protocolLabel];
        [_protocolView addSubview:self.protocolButton];
        [_protocolView addSubview:firstProtocolBtn];
        _protocolView.hidden = YES;
    }
    return _protocolView;
}

/** 支付按钮 */
- (UIButton *)payButton{
    if (_payButton == nil) {
        _payButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_payButton setTitle:@"去付款" forState:UIControlStateNormal];
        [_payButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _payButton.backgroundColor = K_MainColor;
        [_payButton setTitleColor:K_BtnTitleColor forState:UIControlStateNormal];
        _payButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [_payButton addTarget:self action:@selector(payButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _payButton;
}


#pragma mark - 按钮点击事件
//  点击消费分期
- (void)platformPayViewAction{
    
    if (self.orderPayDetailModel.mallStatus == 0) {
        //  未认证
        if (![ZTMXFMallAuthManager jumpToMallAuthVCWithOrderDetail:self.orderPayDetailModel]) {
            // 未认证跳转到相应的认证页面
            return;
        }
    }
}

//  点击银行卡
- (void)bankCardViewAction{
    NSLog(@"点击银行卡");
    if (self.delegate && [self.delegate respondsToSelector:@selector(paymentOrderViewClickAddBankCard)]) {
        [self.delegate paymentOrderViewClickAddBankCard];
    }
}

//  去支付
- (void)payButtonAction{
    
    
    GetUserInfoApi * userInfoApi = [[GetUserInfoApi alloc] init];
    [SVProgressHUD showLoading];
    [userInfoApi requestWithSuccess:^(NSDictionary *responseDict) {
        [SVProgressHUD dismiss];

        NSString * codeStr = [responseDict[@"code"]description];
        if ([codeStr isEqualToString:@"1000"]) {
            BOOL isSetPayPassword = [responseDict[@"data"][@"isSetPayPassword"] boolValue];
            int bankStatus = [responseDict[@"data"][@"bankStatus"] intValue];
            if (!isSetPayPassword && bankStatus == 1) {
                [ZTMXFSetPasswordAlertView showMessage:@"" ButtonTitle:@"" Click:^{
                    //   未设置支付密码
                    [RealNameManager realNameWithCurrentVc:[UIViewController currentViewController] andRealNameProgress:RealNameProgressSetPayPaw isSaveBackVcName:YES];
                }];
            }else{
                [self goPay];
            }
        }else{
            NSString * msg = [responseDict[@"msg"] description];
            [kKeyWindow makeCenterToast:msg];
            
        }
    } failure:^(__kindof YTKBaseRequest *request) {
        [SVProgressHUD dismiss];
    }];
 
}

- (void)goPay
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(paymentOrderViewClickPayWithNper:orderPayType:)]) {
        if (self.installmentButton.isSelected) {
            if (![ZTMXFMallAuthManager jumpToMallAuthVCWithOrderDetail:self.orderPayDetailModel]) {
                // 未认证跳转到相应的认证页面
                return;
            }
            NSString *effectiveAmountStr = [NSDecimalNumber stringWithFloatValue:self.orderPayDetailModel.effectiveAmount];
            NSComparisonResult compareResult = [NSDecimalNumber compareStringWithleftString:effectiveAmountStr rightString:self.orderPayDetailModel.totalAmount];
            if (compareResult == NSOrderedAscending) {
                [self makeCenterToast:@"当前额度不足，请选择其他方式支付！"];
                return;
            }
            if (!self.protocolButton.selected) {
                [self makeCenterToast:@"请同意借款协议！"];
                return;
            }
            //  选择平台分期支付
            [self.delegate paymentOrderViewClickPayWithNper:self.currentNperInfoModel.nper orderPayType:MallOrderInstallmentPayType];
        } else {
            //  选择银行卡支付
            if (self.orderPayDetailModel.bankInfo.rid.length == 0) {
                // 没有银行卡
                [self makeCenterToast:@"请添加银行卡！"];
                return;
            }
            [self.delegate paymentOrderViewClickPayWithNper:0 orderPayType:MallOrderBankCardPayType];
        }
    }
}

//  点击选择分期支付
- (void)installmentButtonAction:(UIButton *)sender{
    
    if (self.orderPayDetailModel.weakRiskStatus == -1) {
        // 弱风控被拒绝
        [self makeCenterToast:@"很抱歉，您的该笔订单没有通过自动审核，请使用银行卡完成支付"];
        return;
    }
    if (self.orderPayDetailModel.mallStatus == -1) {
        // 消费分期认证失败
        [self makeCenterToast:@"很抱歉，你未通过分期认证，请隔断时间继续认证或通过银行卡支付"];
        return;
    } else if (self.orderPayDetailModel.mallStatus == 2) {
        // 认证中
        [self makeCenterToast:@"认证审核中，请在认证通过后选择分期方式支付或通过银行卡支付"];
        return;
    } else if (self.orderPayDetailModel.mallStatus == 0) {
        // 未认证
        [self.payButton setTitle:@"去认证" forState:UIControlStateNormal];
    } else {
        // 已认证
        NSString *effectiveAmountStr = [NSDecimalNumber stringWithFloatValue:self.orderPayDetailModel.effectiveAmount];
        NSComparisonResult compareResult = [NSDecimalNumber compareStringWithleftString:effectiveAmountStr rightString:self.orderPayDetailModel.totalAmount];
        if (compareResult == NSOrderedDescending) {
            [self.payButton setTitle:@"去付款" forState:UIControlStateNormal];
        } else {
            [self.payButton setTitle:@"额度不足" forState:UIControlStateNormal];
        }
    }

    self.installmentButton.selected = YES;
    self.bankCardPayButton.selected = NO;
    
    //  显示选择分期view
    self.installmentView.hidden = NO;
    //  显示协议
    self.protocolView.hidden = NO;
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
    
    self.mainScrollView.contentSize = CGSizeMake(0.0, self.installmentView.bottom);
}

//  点击选择银行卡支付
- (void)bankCardPayButtonAction:(UIButton *)sender{
    self.installmentButton.selected = NO;
    self.bankCardPayButton.selected = YES;
    
    //  隐藏选择分期view
    self.installmentView.hidden = YES;
    //  隐藏协议
    self.protocolView.hidden = YES;
    [self.payButton setTitle:@"去付款" forState:UIControlStateNormal];
    self.currentNper = @"0";
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

//  点击协议按钮
- (void)clickProtocolButton:(UIButton *)sender
{
    sender.selected = !sender.selected;
}

#pragma mark - 点击合作协议
- (void)clickCooperateProtocol{
    NSLog(@"点击合作协议");
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickMallCooperateProtocol)]) {
        [self.delegate clickMallCooperateProtocol];
    }
}

#pragma mark - 点击借钱协议
- (void)clickLoanProtocol{
    NSLog(@"点击借钱协议");
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickMallPayProtocol)]) {
        [self.delegate clickMallPayProtocol];
    }
}

#pragma mark - 设置页面数据
- (void)setOrderPayDetailModel:(OrderPayDetailModel *)orderPayDetailModel{
    if (orderPayDetailModel) {
        _orderPayDetailModel = orderPayDetailModel;
        // 更新页面
        [self updateViewData];
    }
}

//  更新页面数据
- (void)updateViewData{
    /** 订单金额 */
    self.orderPriceView.valueStr = [NSString stringWithFormat:@"￥%@",self.orderPayDetailModel.totalAmount];
    
    /** 讯秒支付 */
    NSString *platformValue = [NSString stringWithFormat:@"月供￥%.2f起", self.orderPayDetailModel.minNperInfo.monthAmount];
    NSString *subTitleStr = [NSString stringWithFormat:@"当前额度:%.2f",self.orderPayDetailModel.effectiveAmount];
    if (self.orderPayDetailModel.mallStatus == 0) {
        //  未认证
        subTitleStr = @"认证即可分期，去认证";
    }
    self.platformPayView.titleStr = @"闪到";
    self.platformPayView.subTitleStr = subTitleStr;
    self.platformPayView.valueStr = platformValue;
    
    //   设置分期数据
    if (self.orderPayDetailModel.nperList.count > 0) {
        self.installmentView.installmentArray = self.orderPayDetailModel.nperList;
    }
    
    /** 银行卡 */
    if (self.orderPayDetailModel.bankInfo) {
        self.bankCardView.titleStr = @"银行卡支付";
        NSString *tailNumber = [NSString bankCardLastFourNumber:self.orderPayDetailModel.bankInfo.cardNumber];
        NSString *bankCardValue = [NSString stringWithFormat:@"%@ (%@)", self.orderPayDetailModel.bankInfo.bankName, tailNumber];
        self.bankCardView.valueStr = bankCardValue;
    } else {
        self.bankCardView.titleStr = @"银行卡支付";
        NSString *bankCardValue = [NSString stringWithFormat:@"+  添加银行卡"];
        self.bankCardView.valueStr = bankCardValue;
    }
    
    /** 1.消费分期未认证-勾选银行卡支付 2.已认证-勾选信用分期支付 */
    if (self.orderPayDetailModel.mallStatus == 1 && self.orderPayDetailModel.weakRiskStatus != -1) {
        // 已认证：1.额度足够-去付款；2.额度不足
        if ([LoginManager appReviewState]) {
            // 未认证通过：默认勾选银行卡
            [self bankCardPayButtonAction:nil];
            [self.payButton setTitle:@"去付款" forState:UIControlStateNormal];
        }else{
            [self installmentButtonAction:nil];
        }

    } else {
        // 未认证通过：默认勾选银行卡
        [self bankCardPayButtonAction:nil];
        [self.payButton setTitle:@"去付款" forState:UIControlStateNormal];
    }
}

- (void)setBankCardModel:(BankCardModel *)bankCardModel{
    
    _bankCardModel = bankCardModel;
    
    /** 银行卡 */
    if (bankCardModel) {
        self.bankCardView.titleStr = @"银行卡支付";
        NSString *tailNumber = [NSString bankCardLastFourNumber:_bankCardModel.cardNumber];
        NSString *bankCardValue = [NSString stringWithFormat:@"%@ (%@)", _bankCardModel.bankName, tailNumber];
        self.bankCardView.valueStr = bankCardValue;
    } else {
        self.bankCardView.titleStr = @"银行卡支付";
        NSString *bankCardValue = [NSString stringWithFormat:@"+  添加银行卡"];
        self.bankCardView.valueStr = bankCardValue;
    }
}

#pragma mark - 分期view代理方法
/** 点击选择分期 */
- (void)installmentInfoViewSelectNperInfoModel:(GoodsNperInfoModel *)nperInfoModel{
    if (nperInfoModel) {
        self.currentNperInfoModel = nperInfoModel;
        NSString *platformValue = [NSString stringWithFormat:@"月供￥%.2f起", nperInfoModel.monthAmount];
        self.platformPayView.valueStr = platformValue;
        
        if (self.installmentButton.selected) {
            self.currentNper = [NSString stringWithFormat:@"%ld",nperInfoModel.nper];
        } else if (self.bankCardPayButton.selected) {
            self.currentNper = @"0";
        }
    }
}

@end

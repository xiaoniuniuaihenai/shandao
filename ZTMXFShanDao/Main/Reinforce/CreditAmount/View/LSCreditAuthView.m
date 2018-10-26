//
//  LSCreditAuthView.m
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2017/12/28.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "LSCreditAuthView.h"
#import "LSCreditRowCellView.h"
#import "LSPromoteCreditInfoModel.h"
#import "LSAuthSupplyCertifyModel.h"
#import "LSMallCreditInfoModel.h"
#import "UILabel+Attribute.h"
@interface LSCreditAuthView ()

/** 基础认证top */
@property (nonatomic, strong) UIView *baseTopView;

/** 实名认证 */
@property (nonatomic, strong) LSCreditRowCellView *realNameAuthView;
/** 绑定银行卡 */
@property (nonatomic, strong) LSCreditRowCellView *bindCardAuthView;
/** 芝麻信用 */
@property (nonatomic, strong) LSCreditRowCellView *zhiMaCreditView;
/** 手机运营商 */
@property (nonatomic, strong) LSCreditRowCellView *phoneOperationView;
/** 公司认证 */
@property (nonatomic, strong) LSCreditRowCellView *companyAuthView;

/** 社保认证top */
@property (nonatomic, strong) UIView *securityTopView;
/** 社保认证 */
@property (nonatomic, strong) LSCreditRowCellView *securityAuthView;
/** 公积金认证 */
@property (nonatomic, strong) LSCreditRowCellView *fundAuthView;
/** 京东认证 */
@property (nonatomic, strong) LSCreditRowCellView *jingDongAuthView;
/** 淘宝认证 */
@property (nonatomic, strong) LSCreditRowCellView *taoBaoAuthView;

@end

@implementation LSCreditAuthView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

#pragma mark - 点击事件


//  绑定银行卡认证
- (void)bindCardCreditViewAction{
    if (self.delegete && [self.delegete respondsToSelector:@selector(clickAuthType:)]) {
        [self.delegete clickAuthType:LSBindCardAuthType];
    }
}

//  芝麻信用认证
- (void)zhiMaCreditViewAction{
    if (self.delegete && [self.delegete respondsToSelector:@selector(clickAuthType:)]) {
        [self.delegete clickAuthType:LSZhiMaAuthType];
    }
}

//  运营商认证
- (void)phoneOperationAction{
    if (self.delegete && [self.delegete respondsToSelector:@selector(clickAuthType:)]) {
        [self.delegete clickAuthType:LSOperatorAuthType];
    }
}

//  公司认证
- (void)companyAuthAction{
    if (self.delegete && [self.delegete respondsToSelector:@selector(clickAuthType:)]) {
        [self.delegete clickAuthType:LSCompanyAuthType];
    }
}

// 社保认证
- (void)securityAuthAction{
    if (self.delegete && [self.delegete respondsToSelector:@selector(clickAuthType:)]) {
        [self.delegete clickAuthType:LSSecurityAuthType];
    }
}

// 公积金认证
- (void)fundAuthAction{
    if (self.delegete && [self.delegete respondsToSelector:@selector(clickAuthType:)]) {
        [self.delegete clickAuthType:LSFundAuthType];
    }
}

// 京东认证
- (void)jongdongAuthAction{
    if (self.delegete && [self.delegete respondsToSelector:@selector(clickAuthType:)]) {
        [self.delegete clickAuthType:LSJingDongAuthType];
    }
}

// 淘宝认证
- (void)taobaoAuthAction{
    if (self.delegete && [self.delegete respondsToSelector:@selector(clickAuthType:)]) {
        [self.delegete clickAuthType:LSTaoBaoAuthType];
    }
}
//  实名认证
- (void)realNameCreditViewAction{
    if (self.delegete && [self.delegete respondsToSelector:@selector(clickAuthType:)]) {
        [self.delegete clickAuthType:LSRealNameAuthType];
    }
}


#pragma mark - setter
- (void)setConsumeLoanInfoModel:(LSPromoteCreditInfoModel *)consumeLoanInfoModel{
    if (_consumeLoanInfoModel != consumeLoanInfoModel) {
        _consumeLoanInfoModel = consumeLoanInfoModel;
    }
    
    if (_consumeLoanInfoModel == nil) {
        self.realNameAuthView.valueStr = @"未认证";
        self.bindCardAuthView.valueStr = @"未绑定";
        self.zhiMaCreditView.valueStr = @"未授权";
        self.phoneOperationView.valueStr = @"未认证";
        self.zhiMaCreditView.titleImageStr = @"XL_RZ_ZhiMa";
        self.phoneOperationView.titleImageStr = @"yunYingShangIcon";
        self.zhiMaCreditView.valueColor = COLOR_BLUE_STR;
        self.phoneOperationView.valueColor = COLOR_BLUE_STR;
    } else {
        // 实名认证
        NSString *realNameStatusStr = [NSString string];
        if (_consumeLoanInfoModel.faceStatus == 1) {
            realNameStatusStr = @"已认证";
            self.realNameAuthView.valueColor = COLOR_GRAY_STR;
        } else if (_consumeLoanInfoModel.faceStatus == 0) {
            realNameStatusStr = @"未认证";
            self.realNameAuthView.valueColor = COLOR_BLUE_STR;
        }else if (_consumeLoanInfoModel.faceStatus == -1){
            realNameStatusStr = @"认证失败";
            self.realNameAuthView.valueColor = COLOR_BLUE_STR;
        }
        self.realNameAuthView.valueStr = realNameStatusStr;
        
        // 绑定银行卡
        NSString *bindCardStatusStr = [NSString string];
        if (_consumeLoanInfoModel.bindCardStatus == 1) {
            bindCardStatusStr = @"已绑定";
            self.bindCardAuthView.valueColor = COLOR_GRAY_STR;
        } else if (_consumeLoanInfoModel.bindCardStatus == 0) {
            bindCardStatusStr = @"未绑定";
            self.bindCardAuthView.valueColor = COLOR_BLUE_STR;
        }else if (_consumeLoanInfoModel.bindCardStatus == -1){
            bindCardStatusStr = @"绑定失败";
            self.bindCardAuthView.valueColor = COLOR_BLUE_STR;
        }
        self.bindCardAuthView.valueStr = bindCardStatusStr;
        
        //  芝麻信用
        NSString *zhimaCreditStr = @"";
        if (_consumeLoanInfoModel.zmModel.zmStatus == 1) {
            zhimaCreditStr = @"已授权";
            self.zhiMaCreditView.titleImageStr = @"XL_RZ_ZhiMa";
            self.zhiMaCreditView.valueColor = COLOR_GRAY_STR;
        } else {
            zhimaCreditStr = @"未授权";
            self.zhiMaCreditView.titleImageStr = @"XL_RZ_ZhiMa";
            self.zhiMaCreditView.valueColor = COLOR_BLUE_STR;
        }
        self.zhiMaCreditView.valueStr = zhimaCreditStr;
        
        // 运营商认证
        NSString *mobileStatusStr = [NSString string];
        if (_consumeLoanInfoModel.mobileStatus == 1) {
            mobileStatusStr = @"已认证";
            self.phoneOperationView.valueColor = COLOR_GRAY_STR;
        } else if (_consumeLoanInfoModel.mobileStatus == 0) {
            mobileStatusStr = @"去认证";
            self.phoneOperationView.valueColor = COLOR_BLUE_STR;
        }else if (_consumeLoanInfoModel.mobileStatus == -1){
            mobileStatusStr = @"认证失败";
            self.phoneOperationView.valueColor = COLOR_BLUE_STR;
        } else  if (_consumeLoanInfoModel.mobileStatus == 2) {
            mobileStatusStr = @"认证中...";
            self.phoneOperationView.valueColor = COLOR_BLUE_STR;
        }
        self.phoneOperationView.valueStr = mobileStatusStr;
    }
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

#pragma mark - 白领贷
- (void)setWhiteLoanInfoModel:(LSAuthSupplyCertifyModel *)whiteLoanInfoModel{
    if (_whiteLoanInfoModel != whiteLoanInfoModel) {
        _whiteLoanInfoModel = whiteLoanInfoModel;
    }
    self.baseTopView.hidden = NO;
    self.securityTopView.hidden = NO;
    self.companyAuthView.hidden = NO;
    self.securityAuthView.hidden = NO;
    self.fundAuthView.hidden = NO;
    self.jingDongAuthView.hidden = YES;
    self.taoBaoAuthView.hidden = YES;
    
    // 公司认证
    NSString *companyStatusStr = [NSString string];
    if (_whiteLoanInfoModel.companyStatus == 1) {
        companyStatusStr = @"已填写";
        self.companyAuthView.titleImageStr = @"companyAuth_selected";
        self.companyAuthView.valueColor = COLOR_GRAY_STR;
    } else if (_whiteLoanInfoModel.companyStatus == 0 || _whiteLoanInfoModel.companyStatus == -1) {
        companyStatusStr = @"去填写";
        self.companyAuthView.titleImageStr = @"companyAuth_normal";
        self.companyAuthView.valueColor = COLOR_BLUE_STR;
    }
    self.companyAuthView.valueStr = companyStatusStr;
    
    // 社保认证
    NSString *securityStatusStr = [NSString string];
    if (_whiteLoanInfoModel.socialSecurityStatus == 1) {
        securityStatusStr = @"已授权";
        self.securityAuthView.titleImageStr = @"security_selected";
        self.securityAuthView.valueColor = COLOR_GRAY_STR;
    } else if (_whiteLoanInfoModel.socialSecurityStatus == 2) {
        securityStatusStr = @"认证中...";
        self.securityAuthView.titleImageStr = @"security_normal";
        self.securityAuthView.valueColor = COLOR_BLUE_STR;
    } else if (_whiteLoanInfoModel.socialSecurityStatus == -1){
        securityStatusStr = @"认证失败";
        self.securityAuthView.titleImageStr = @"securityStatusStr";
        self.securityAuthView.valueColor = COLOR_BLUE_STR;
    } else {
        securityStatusStr = @"去授权";
        self.securityAuthView.titleImageStr = @"security_normal";
        self.securityAuthView.valueColor = COLOR_BLUE_STR;
    }
    self.securityAuthView.valueStr = securityStatusStr;
    
    // 公积金认证
    NSString *fundStatusStr = [NSString string];
    if (_whiteLoanInfoModel.fundStatus == 1) {
        fundStatusStr = @"已授权";
        self.fundAuthView.titleImageStr = @"fundAuth_selected";
        self.fundAuthView.valueColor = COLOR_GRAY_STR;
    } else if (_whiteLoanInfoModel.fundStatus == 2) {
        fundStatusStr = @"认证中...";
        self.fundAuthView.titleImageStr = @"fundAuth_normal";
        self.fundAuthView.valueColor = COLOR_BLUE_STR;
    } else if (_whiteLoanInfoModel.fundStatus == -1) {
        fundStatusStr = @"认证失败";
        self.fundAuthView.titleImageStr = @"fundAuth_normal";
        self.fundAuthView.valueColor = COLOR_BLUE_STR;
    } else {
        fundStatusStr = @"去授权";
        self.fundAuthView.titleImageStr = @"fundAuth_normal";
        self.fundAuthView.valueColor = COLOR_BLUE_STR;
    }
    self.fundAuthView.valueStr = fundStatusStr;
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

#pragma mark - 消费分期
- (void)setMallLoanInfoModel:(LSMallCreditInfoModel *)mallLoanInfoModel
{
    if (_mallLoanInfoModel != mallLoanInfoModel) {
        _mallLoanInfoModel = mallLoanInfoModel;
    }
    self.baseTopView.hidden = NO;
    self.securityTopView.hidden = NO;
    self.companyAuthView.hidden = YES;
    self.securityAuthView.hidden = YES;
    self.fundAuthView.hidden = YES;
    self.jingDongAuthView.hidden = NO;
    self.taoBaoAuthView.hidden = NO;
    
    if (_mallLoanInfoModel == nil) {
        self.realNameAuthView.valueStr = @"未认证";
        self.bindCardAuthView.valueStr = @"未绑定";
        self.zhiMaCreditView.valueStr = @"未授权";
        self.phoneOperationView.valueStr = @"未认证";
        self.jingDongAuthView.valueStr = @"未认证";
        self.taoBaoAuthView.valueStr = @"未认证";
        self.zhiMaCreditView.titleImageStr = @"XL_RZ_ZhiMa";
        self.phoneOperationView.titleImageStr = @"operationAuth_normal";
        self.zhiMaCreditView.valueColor = COLOR_BLUE_STR;
        self.phoneOperationView.valueColor = COLOR_BLUE_STR;
    } else {
        // 实名认证
        NSString *realNameStatusStr = [NSString string];
        if (_mallLoanInfoModel.realnameStatus == 1) {
            realNameStatusStr = @"已认证";
            self.realNameAuthView.valueColor = COLOR_GRAY_STR;
        } else if (_mallLoanInfoModel.realnameStatus == 0) {
            realNameStatusStr = @"未认证";
            self.realNameAuthView.valueColor = COLOR_BLUE_STR;
        }else if (_mallLoanInfoModel.realnameStatus == -1){
            realNameStatusStr = @"认证失败";
            self.realNameAuthView.valueColor = COLOR_BLUE_STR;
        }
        self.realNameAuthView.valueStr = realNameStatusStr;
        
        // 绑定银行卡
        NSString *bindCardStatusStr = [NSString string];
        if (_mallLoanInfoModel.bindCard == 1) {
            bindCardStatusStr = @"已绑定";
            self.bindCardAuthView.valueColor = COLOR_GRAY_STR;
        } else if (_mallLoanInfoModel.bindCard == 0) {
            bindCardStatusStr = @"未绑定";
            self.bindCardAuthView.valueColor = COLOR_BLUE_STR;
        }else if (_mallLoanInfoModel.bindCard == -1){
            bindCardStatusStr = @"绑定失败";
            self.bindCardAuthView.valueColor = COLOR_BLUE_STR;
        }
        self.bindCardAuthView.valueStr = bindCardStatusStr;
        
        //  芝麻信用
        NSString *zhimaCreditStr = @"";
        if (_mallLoanInfoModel.zmStatus == 1) {
            zhimaCreditStr = @"已授权";
            self.zhiMaCreditView.titleImageStr = @"XL_RZ_ZhiMa";
            self.zhiMaCreditView.valueColor = COLOR_GRAY_STR;
        } else {
            zhimaCreditStr = @"未授权";
            self.zhiMaCreditView.titleImageStr = @"XL_RZ_ZhiMa";
            self.zhiMaCreditView.valueColor = COLOR_BLUE_STR;
        }
        self.zhiMaCreditView.valueStr = zhimaCreditStr;
        
        // 运营商认证
        NSString *mobileStatusStr = [NSString string];
        if (_mallLoanInfoModel.mobileStatus == 1) {
            mobileStatusStr = @"已认证";
            self.phoneOperationView.valueColor = COLOR_GRAY_STR;
        } else if (_mallLoanInfoModel.mobileStatus == 0) {
            mobileStatusStr = @"去认证";
            self.phoneOperationView.valueColor = COLOR_BLUE_STR;
        } else if (_mallLoanInfoModel.mobileStatus == -1){
            mobileStatusStr = @"认证失败";
            self.phoneOperationView.valueColor = COLOR_BLUE_STR;
        } else  if (_mallLoanInfoModel.mobileStatus == 2) {
            mobileStatusStr = @"认证中...";
            self.phoneOperationView.valueColor = COLOR_BLUE_STR;
        }
        self.phoneOperationView.valueStr = mobileStatusStr;
        
        // 京东认证
        NSString *jingdongStatusStr = [NSString string];
        if (_mallLoanInfoModel.jingdongStatus == 1) {
            jingdongStatusStr = @"已授权";
            self.jingDongAuthView.titleImageStr = @"XL_RZ_JD";
            self.jingDongAuthView.valueColor = COLOR_GRAY_STR;
        } else if (_mallLoanInfoModel.jingdongStatus == 2) {
            jingdongStatusStr = @"认证中...";
            self.jingDongAuthView.titleImageStr = @"XL_RZ_JD";
            self.jingDongAuthView.valueColor = COLOR_BLUE_STR;
        } else if (_mallLoanInfoModel.jingdongStatus == -1){
            jingdongStatusStr = @"认证失败";
            self.jingDongAuthView.titleImageStr = @"XL_RZ_JD";
            self.jingDongAuthView.valueColor = COLOR_BLUE_STR;
        } else {
            jingdongStatusStr = @"去授权";
            self.jingDongAuthView.titleImageStr = @"XL_RZ_JD";
            self.jingDongAuthView.valueColor = COLOR_BLUE_STR;
        }
        self.jingDongAuthView.valueStr = jingdongStatusStr;
        
        // 淘宝认证
        NSString *taobaoStatusStr = [NSString string];
        if (_mallLoanInfoModel.taobaoStatus == 1) {
            taobaoStatusStr = @"已授权";
//            self.taoBaoAuthView.titleImageStr = @"XL_RZ_TaoBao";
            self.taoBaoAuthView.valueColor = COLOR_GRAY_STR;
        } else if (_mallLoanInfoModel.taobaoStatus == 2) {
            taobaoStatusStr = @"认证中...";
//            self.taoBaoAuthView.titleImageStr = @"XL_RZ_TaoBao";
            self.taoBaoAuthView.valueColor = COLOR_BLUE_STR;
        } else if (_mallLoanInfoModel.taobaoStatus == -1){
            taobaoStatusStr = @"认证失败";
//            self.taoBaoAuthView.titleImageStr = @"XL_RZ_TaoBao";
            self.taoBaoAuthView.valueColor = COLOR_BLUE_STR;
        } else {
            taobaoStatusStr = @"去授权";
//            self.taoBaoAuthView.titleImageStr = @"XL_RZ_TaoBao";
            self.taoBaoAuthView.valueColor = COLOR_BLUE_STR;
        }
        self.taoBaoAuthView.valueStr = taobaoStatusStr;
    }
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
}



- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat viewHeight = AdaptedHeight(60.0);
    if (self.whiteLoanInfoModel) {
        self.realNameAuthView.frame = CGRectMake(0.0, CGRectGetMaxY(self.baseTopView.frame), Main_Screen_Width, viewHeight);
        self.bindCardAuthView.frame = CGRectMake(0.0, CGRectGetMaxY(self.realNameAuthView.frame), Main_Screen_Width, viewHeight);
        self.zhiMaCreditView.frame = CGRectMake(0.0, CGRectGetMaxY(self.bindCardAuthView.frame), Main_Screen_Width, viewHeight);
        self.phoneOperationView.frame = CGRectMake(0.0, CGRectGetMaxY(self.zhiMaCreditView.frame) , Main_Screen_Width, viewHeight);
        
        self.height = self.fundAuthView.bottom;
    } else if (self.mallLoanInfoModel) {
        self.baseTopView.frame = CGRectMake(0.0, 0.0, Main_Screen_Width, 44.0);
        self.realNameAuthView.frame = CGRectMake(0.0, CGRectGetMaxY(self.baseTopView.frame), Main_Screen_Width, viewHeight);
        self.bindCardAuthView.frame = CGRectMake(0.0, CGRectGetMaxY(self.realNameAuthView.frame), Main_Screen_Width, viewHeight);
        self.zhiMaCreditView.frame = CGRectMake(0.0, CGRectGetMaxY(self.bindCardAuthView.frame), Main_Screen_Width, viewHeight);
        self.phoneOperationView.frame = CGRectMake(0.0, CGRectGetMaxY(self.zhiMaCreditView.frame) , Main_Screen_Width, viewHeight);
        self.securityTopView.frame = CGRectMake(0.0, CGRectGetMaxY(self.phoneOperationView.frame)-1, Main_Screen_Width, 44.0);
        self.jingDongAuthView.frame = CGRectMake(0.0, CGRectGetMaxY(self.securityTopView.frame) , Main_Screen_Width, viewHeight);
        self.taoBaoAuthView.frame = CGRectMake(0.0, CGRectGetMaxY(self.jingDongAuthView.frame) , Main_Screen_Width, viewHeight);
        
        self.height = self.taoBaoAuthView.bottom;
    } else{
        self.realNameAuthView.frame = CGRectMake(0.0, 0.0, Main_Screen_Width, viewHeight);
        self.bindCardAuthView.frame = CGRectMake(0.0, CGRectGetMaxY(self.realNameAuthView.frame), Main_Screen_Width, viewHeight);
        self.zhiMaCreditView.frame = CGRectMake(0.0, CGRectGetMaxY(self.bindCardAuthView.frame), Main_Screen_Width, viewHeight);
        self.phoneOperationView.frame = CGRectMake(0.0, CGRectGetMaxY(self.zhiMaCreditView.frame), Main_Screen_Width, viewHeight);
        
        self.height = self.phoneOperationView.bottom;
    }
}

- (void)setupViews{
    // cell frame
    CGFloat viewHeight = AdaptedHeight(60.0);
    NSString * titleColor = COLOR_BLACK_STR;
    NSString * valueColor = COLOR_GRAY_STR;
    CGFloat titleFont = AdaptedWidth(16);
    CGFloat valueFont = AdaptedWidth(15);
    
    /** 基础认证 */
    self.baseTopView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, Main_Screen_Width, 44)];
    //    self.baseTopView.backgroundColor = [UIColor colorWithHexString:@"E9F8FF"];
    [self addSubview:self.baseTopView];
    UILabel *titleLabel = [UILabel labelWithTitleColor:[UIColor colorWithHexString:COLOR_BLACK_STR] fontSize:AdaptedWidth(15.0) alignment:NSTextAlignmentLeft];
    [titleLabel setFrame:CGRectMake(18.0, 0.0, self.baseTopView.width-18.0, self.baseTopView.height)];
    titleLabel.text = @"基础认证(必填)";
    [UILabel attributeWithLabel:titleLabel text:titleLabel.text textColor:COLOR_BLACK_STR attributes:@[@"必填"] attributeColors:@[K_EC5346Color]];
    [self.baseTopView addSubview:titleLabel];
    self.baseTopView.hidden = YES;
    
    
    UIView * line1 = [[UIView alloc] initWithFrame:CGRectMake(0, self.baseTopView.height - 1, KW, 1)];
    line1.backgroundColor = K_LineColor;
    [self.baseTopView addSubview:line1];
    
    /** 实名认证 */
    self.realNameAuthView = [[LSCreditRowCellView alloc]initWithTitle:@"实名认证" value:@"未认证" target:self action:@selector(realNameCreditViewAction)];
    self.realNameAuthView.frame = CGRectMake(0.0, CGRectGetMaxY(self.baseTopView.frame), Main_Screen_Width, viewHeight);
    self.realNameAuthView.titleImageStr = @"XL_Mine_RenZheng";
    self.realNameAuthView.imgLeftSize = AdaptedWidth(30);
    self.realNameAuthView.contentMargin = AdaptedWidth(18);
    self.realNameAuthView.titleMarginImgLeft = AdaptedWidth(20);
    self.realNameAuthView.lineEdgeInsets = UIEdgeInsetsMake(0, AdaptedWidth(72), 0, AdaptedWidth(5));
    self.realNameAuthView.titleColor =  titleColor;
    self.realNameAuthView.valueColor = valueColor;
    self.realNameAuthView.titleFontSize = titleFont;
    self.realNameAuthView.valueFontSize = valueFont;
    self.realNameAuthView.isHideRightImg = YES;
    self.realNameAuthView.separatorStyle = LSCreditSeparatorStyleDefault;
    [self addSubview:self.realNameAuthView];
    
    /** 绑定银行卡 */
    self.bindCardAuthView = [[LSCreditRowCellView alloc]initWithTitle:@"绑定银行卡" value:@"未认证" target:self action:@selector(bindCardCreditViewAction)];
    self.bindCardAuthView.frame = CGRectMake(0.0, CGRectGetMaxY(self.realNameAuthView.frame), Main_Screen_Width, viewHeight);
    self.bindCardAuthView.titleImageStr = @"XL_Mine_YinHangKa";
    self.bindCardAuthView.imgLeftSize = AdaptedWidth(30);
    self.bindCardAuthView.contentMargin = AdaptedWidth(18);
    self.bindCardAuthView.titleMarginImgLeft = AdaptedWidth(20);
    self.bindCardAuthView.lineEdgeInsets = UIEdgeInsetsMake(0, AdaptedWidth(72), 0, AdaptedWidth(5));
    self.bindCardAuthView.titleColor =  titleColor;
    self.bindCardAuthView.valueColor = valueColor;
    self.bindCardAuthView.titleFontSize = titleFont;
    self.bindCardAuthView.valueFontSize = valueFont;
    self.bindCardAuthView.isHideRightImg = YES;
    self.bindCardAuthView.separatorStyle = LSCreditSeparatorStyleDefault;
    [self addSubview:self.bindCardAuthView];
    
    
    /** 芝麻信用 */
    self.zhiMaCreditView = [[LSCreditRowCellView alloc]initWithTitle:@"芝麻信用" value:@"未认证" target:self action:@selector(zhiMaCreditViewAction)];
    self.zhiMaCreditView.frame = CGRectMake(0.0, CGRectGetMaxY(self.bindCardAuthView.frame), Main_Screen_Width, viewHeight);
    self.zhiMaCreditView.titleImageStr = @"XL_RZ_ZhiMa";
    self.zhiMaCreditView.imgLeftSize = AdaptedWidth(30);
    self.zhiMaCreditView.contentMargin = AdaptedWidth(18);
    self.zhiMaCreditView.titleMarginImgLeft = AdaptedWidth(20);
    self.zhiMaCreditView.lineEdgeInsets = UIEdgeInsetsMake(0, AdaptedWidth(72), 0, AdaptedWidth(5));
    self.zhiMaCreditView.titleColor =  titleColor;
    self.zhiMaCreditView.valueColor = valueColor;
    self.zhiMaCreditView.titleFontSize = titleFont;
    self.zhiMaCreditView.valueFontSize = valueFont;
    self.zhiMaCreditView.isHideRightImg = YES;
    self.zhiMaCreditView.separatorStyle = LSCreditSeparatorStyleDefault;
    [self addSubview:self.zhiMaCreditView];
    
    /** 运营商认证 */
    self.phoneOperationView = [[LSCreditRowCellView alloc] initWithTitle:@"运营商认证" value:@"未认证" target:self action:@selector(phoneOperationAction)];
    self.phoneOperationView.frame = CGRectMake(0.0, CGRectGetMaxY(self.zhiMaCreditView.frame) , Main_Screen_Width, viewHeight);
    self.phoneOperationView.titleImageStr = @"XL_RZ_YunYingShang";
    self.phoneOperationView.imgLeftSize = AdaptedWidth(30);
    self.phoneOperationView.contentMargin = AdaptedWidth(18);
    self.phoneOperationView.titleMarginImgLeft = AdaptedWidth(20);
    self.phoneOperationView.lineEdgeInsets = UIEdgeInsetsMake(0, AdaptedWidth(72), 0.0, AdaptedWidth(5));
    self.phoneOperationView.titleColor =  titleColor;
    self.phoneOperationView.valueColor = valueColor;
    self.phoneOperationView.titleFontSize = titleFont;
    self.phoneOperationView.valueFontSize = valueFont;
    self.phoneOperationView.isHideRightImg = YES;
    self.phoneOperationView.separatorStyle = LSCreditSeparatorStyleDefault;
    [self addSubview:self.phoneOperationView];
    
    /** 公司认证 */
    self.companyAuthView = [[LSCreditRowCellView alloc] initWithTitle:@"公司/职业信息" value:@"未认证" target:self action:@selector(companyAuthAction)];
    self.companyAuthView.frame = CGRectMake(0.0, CGRectGetMaxY(self.phoneOperationView.frame) , Main_Screen_Width, viewHeight);
    self.companyAuthView.titleImageStr = @"companyAuth_normal";
    self.companyAuthView.imgLeftSize = AdaptedWidth(30);
    self.companyAuthView.contentMargin = AdaptedWidth(18);
    self.companyAuthView.titleMarginImgLeft = AdaptedWidth(20);
    self.companyAuthView.lineEdgeInsets = UIEdgeInsetsMake(0, AdaptedWidth(72), 0.0, AdaptedWidth(5));
    self.companyAuthView.titleColor =  titleColor;
    self.companyAuthView.valueColor = valueColor;
    self.companyAuthView.titleFontSize = titleFont;
    self.companyAuthView.valueFontSize = valueFont;
    self.companyAuthView.isHideRightImg = YES;
    self.companyAuthView.separatorStyle = LSCreditSeparatorStyleDefault;
    [self addSubview:self.companyAuthView];
    self.companyAuthView.hidden = YES;
    
    /** 社保、公积金top */
    self.securityTopView = [[UIView alloc] initWithFrame:CGRectMake(0.0, CGRectGetMaxY(self.companyAuthView.frame), Main_Screen_Width, 44.0)];
    //    self.securityTopView.backgroundColor = [UIColor colorWithHexString:@"E9F8FF"];
    [self addSubview:self.securityTopView];
    UILabel *chooseTitleLabel = [UILabel labelWithTitleColor:[UIColor colorWithHexString:COLOR_BLACK_STR] fontSize:AdaptedWidth(15.0) alignment:NSTextAlignmentLeft];
    [chooseTitleLabel setFrame:CGRectMake(18.0, 0.0, self.baseTopView.width-18.0, self.baseTopView.height)];
    chooseTitleLabel.text = @"高级认证(二选一)";
    [UILabel attributeWithLabel:chooseTitleLabel text:chooseTitleLabel.text textColor:COLOR_BLACK_STR attributes:@[@"二选一"] attributeColors:@[K_EC5346Color]];
    
    [self.securityTopView addSubview:chooseTitleLabel];
    self.securityTopView.hidden = YES;
    
    UIView * line2 = [[UIView alloc] initWithFrame:CGRectMake(0, self.securityTopView.height - 1, KW, 1)];
    line2.backgroundColor = K_LineColor;
    [self.securityTopView addSubview:line2];
    
    /** 社保认证 */
    self.securityAuthView = [[LSCreditRowCellView alloc] initWithTitle:@"社保认证" value:@"未认证" target:self action:@selector(securityAuthAction)];
    self.securityAuthView.frame = CGRectMake(0.0, CGRectGetMaxY(self.securityTopView.frame) , Main_Screen_Width, viewHeight);
    self.securityAuthView.titleImageStr = @"security_normal";
    self.securityAuthView.imgLeftSize = AdaptedWidth(30);
    self.securityAuthView.contentMargin = AdaptedWidth(18);
    self.securityAuthView.titleMarginImgLeft = AdaptedWidth(20);
    self.securityAuthView.lineEdgeInsets = UIEdgeInsetsMake(0, AdaptedWidth(72), 0.0, AdaptedWidth(5));
    self.securityAuthView.titleColor =  titleColor;
    self.securityAuthView.valueColor = valueColor;
    self.securityAuthView.titleFontSize = titleFont;
    self.securityAuthView.valueFontSize = valueFont;
    self.securityAuthView.isHideRightImg = YES;
    self.securityAuthView.separatorStyle = LSCreditSeparatorStyleDefault;
    [self addSubview:self.securityAuthView];
    self.securityAuthView.hidden = YES;
    
    /** 公积金认证 */
    self.fundAuthView = [[LSCreditRowCellView alloc] initWithTitle:@"公积金认证" value:@"未认证" target:self action:@selector(fundAuthAction)];
    self.fundAuthView.frame = CGRectMake(0.0, CGRectGetMaxY(self.securityAuthView.frame) , Main_Screen_Width, viewHeight);
    self.fundAuthView.titleImageStr = @"fundAuth_normal";
    self.fundAuthView.imgLeftSize = AdaptedWidth(30);
    self.fundAuthView.contentMargin = AdaptedWidth(18);
    self.fundAuthView.titleMarginImgLeft = AdaptedWidth(20);
    self.fundAuthView.lineEdgeInsets = UIEdgeInsetsMake(0, AdaptedWidth(72), 0.0, AdaptedWidth(5));
    self.fundAuthView.titleColor =  titleColor;
    self.fundAuthView.valueColor = valueColor;
    self.fundAuthView.titleFontSize = titleFont;
    self.fundAuthView.valueFontSize = valueFont;
    self.fundAuthView.isHideRightImg = YES;
    self.fundAuthView.separatorStyle = LSCreditSeparatorStyleDefault;
    [self addSubview:self.fundAuthView];
    self.fundAuthView.hidden = YES;
    
    /** 京东认证 */
    self.jingDongAuthView = [[LSCreditRowCellView alloc] initWithTitle:@"京东认证" value:@"未授权" target:self action:@selector(jongdongAuthAction)];
    self.jingDongAuthView.frame = CGRectMake(0.0, CGRectGetMaxY(self.securityTopView.frame) , Main_Screen_Width, viewHeight);
    self.jingDongAuthView.titleImageStr = @"XL_RZ_JD";
    self.jingDongAuthView.imgLeftSize = AdaptedWidth(30);
    self.jingDongAuthView.contentMargin = AdaptedWidth(18);
    self.jingDongAuthView.titleMarginImgLeft = AdaptedWidth(20);
    self.jingDongAuthView.lineEdgeInsets = UIEdgeInsetsMake(0, AdaptedWidth(72), 0.0, AdaptedWidth(5));
    self.jingDongAuthView.titleColor =  titleColor;
    self.jingDongAuthView.valueColor = valueColor;
    self.jingDongAuthView.titleFontSize = titleFont;
    self.jingDongAuthView.valueFontSize = valueFont;
    self.jingDongAuthView.isHideRightImg = YES;
    self.jingDongAuthView.separatorStyle = LSCreditSeparatorStyleDefault;
    [self addSubview:self.jingDongAuthView];
    self.jingDongAuthView.hidden = YES;
    
    /** 淘宝认证 */
    self.taoBaoAuthView = [[LSCreditRowCellView alloc] initWithTitle:@"淘宝认证" value:@"未授权" target:self action:@selector(taobaoAuthAction)];
    self.taoBaoAuthView.frame = CGRectMake(0.0, CGRectGetMaxY(self.jingDongAuthView.frame) , Main_Screen_Width, viewHeight);
    self.taoBaoAuthView.titleImageStr = @"XL_RZ_TaoBao";
    self.taoBaoAuthView.imgLeftSize = AdaptedWidth(30);
    self.taoBaoAuthView.contentMargin = AdaptedWidth(18);
    self.taoBaoAuthView.titleMarginImgLeft = AdaptedWidth(20);
    self.taoBaoAuthView.lineEdgeInsets = UIEdgeInsetsMake(0, AdaptedWidth(72), 0.0, AdaptedWidth(5));
    self.taoBaoAuthView.titleColor =  titleColor;
    self.taoBaoAuthView.valueColor = valueColor;
    self.taoBaoAuthView.titleFontSize = titleFont;
    self.taoBaoAuthView.valueFontSize = valueFont;
    self.taoBaoAuthView.isHideRightImg = YES;
    self.taoBaoAuthView.separatorStyle = LSCreditSeparatorStyleDefault;
    [self addSubview:self.taoBaoAuthView];
    self.taoBaoAuthView.hidden = YES;
    
}


@end

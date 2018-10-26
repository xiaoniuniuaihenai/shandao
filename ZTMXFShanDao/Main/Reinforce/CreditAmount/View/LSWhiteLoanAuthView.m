//
//  LSWhiteLoanAuthView.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/12/8.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "LSWhiteLoanAuthView.h"
#import "LSCreditRowCellView.h"
#import "LSAuthSupplyCertifyModel.h"

@interface LSWhiteLoanAuthView ()

/**公积金*/
@property (nonatomic,strong) LSCreditRowCellView * companyPhoneView;
/** 白领贷title */
@property (nonatomic, strong) UILabel *whiteLoanTitleLabel;
/**公积金*/
@property (nonatomic,strong) LSCreditRowCellView * providentFundView;
/**社保*/
@property (nonatomic,strong) LSCreditRowCellView * socialSecurityView;

@end

@implementation LSWhiteLoanAuthView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}



- (void)setupViews{
    
    CGFloat viewHeight = AdaptedHeight(60.0);
    NSString * titleColor = @"5c5c5c";
    NSString * valueColor = @"f6a623";
    CGFloat titleFont = 17;
    CGFloat valueFont = 15;

    //  单位电话认证
    self.companyPhoneView = [[LSCreditRowCellView alloc] initWithTitle:@"公司认证" value:@"未填写" target:self action:@selector(companyPhoneViewAction)];
    [self.companyPhoneView setFrame:CGRectMake(0.0, 0.0, Main_Screen_Width, viewHeight)];
    self.companyPhoneView.titleImageStr = @"companyAuth_red";
    self.companyPhoneView.imgLeftSize = AdaptedWidth(30);
    self.companyPhoneView.contentMargin = AdaptedWidth(18);
    self.companyPhoneView.titleMarginImgLeft = AdaptedWidth(20);
    self.companyPhoneView.lineEdgeInsets = UIEdgeInsetsMake(0, AdaptedWidth(72), 0, AdaptedWidth(5));
    self.companyPhoneView.titleColor =  titleColor;
    self.companyPhoneView.valueColor = valueColor;
    self.companyPhoneView.titleFontSize = titleFont;
    self.companyPhoneView.valueFontSize = valueFont;
    self.companyPhoneView.isHideLine = YES;
    [self addSubview:self.companyPhoneView];

    [self addSubview:self.whiteLoanTitleLabel];
    
    //  社保
    self.socialSecurityView = [[LSCreditRowCellView alloc] initWithTitle:@"社保认证" value:@"未认证" target:self action:@selector(socialSecurityStatusAction)];
    [self.socialSecurityView setFrame:CGRectMake(0.0, CGRectGetMaxY(self.whiteLoanTitleLabel.frame), Main_Screen_Width, viewHeight)];
    self.socialSecurityView.titleImageStr = @"sheBaoIcon";
    self.socialSecurityView.imgLeftSize = AdaptedWidth(30);
    self.socialSecurityView.contentMargin = AdaptedWidth(18);
    self.socialSecurityView.titleMarginImgLeft = AdaptedWidth(20);
    self.socialSecurityView.lineEdgeInsets = UIEdgeInsetsMake(0, AdaptedWidth(72), 0, AdaptedWidth(5));
    self.socialSecurityView.titleColor =  titleColor;
    self.socialSecurityView.valueColor = valueColor;
    self.socialSecurityView.titleFontSize = titleFont;
    self.socialSecurityView.valueFontSize = valueFont;
    self.socialSecurityView.separatorStyle = LSCreditSeparatorStyleDefault;
    [self addSubview:self.socialSecurityView];

    //  公积金
    self.providentFundView = [[LSCreditRowCellView alloc] initWithTitle:@"公积金认证" value:@"未认证" target:self action:@selector(fundStatusAction)];
    [self.providentFundView setFrame:CGRectMake(0.0, CGRectGetMaxY(self.socialSecurityView.frame), Main_Screen_Width, viewHeight)];
    self.providentFundView.titleImageStr = @"gongJiJinIcon";
    self.providentFundView.imgLeftSize = AdaptedWidth(30);
    self.providentFundView.contentMargin = AdaptedWidth(18);
    self.providentFundView.titleMarginImgLeft = AdaptedWidth(20);
    self.providentFundView.lineEdgeInsets = UIEdgeInsetsMake(0, AdaptedWidth(72), 0, AdaptedWidth(5));
    self.providentFundView.titleColor =  titleColor;
    self.providentFundView.valueColor = valueColor;
    self.providentFundView.titleFontSize = titleFont;
    self.providentFundView.valueFontSize = valueFont;
    self.providentFundView.isHideLine = YES;
    [self addSubview:self.providentFundView];
}

/** 白领贷title */
- (UILabel *)whiteLoanTitleLabel{
    if (_whiteLoanTitleLabel == nil) {
        _whiteLoanTitleLabel = [UILabel labelWithTitleColorStr:COLOR_LIGHT_STR fontSize:14 alignment:NSTextAlignmentLeft];
        _whiteLoanTitleLabel.text = @"   认证社保/公积金 (可二选一)";
        _whiteLoanTitleLabel.frame = CGRectMake(0.0, CGRectGetMaxY(_companyPhoneView.frame), Main_Screen_Width, AdaptedHeight(40.0));
        _whiteLoanTitleLabel.backgroundColor = [UIColor colorWithHexString:COLOR_LIGHTBG_STR];
    }
    return _whiteLoanTitleLabel;
}


#pragma mark - 点击事件


//  公积金认证
- (void)fundStatusAction{
    if (self.delegate && [self.delegate respondsToSelector:@selector(whiteLoanAuthViewClickProvidentFund)]) {
        [self.delegate whiteLoanAuthViewClickProvidentFund];
    }
}

//  公司认证
- (void)companyPhoneViewAction{
    /** 白领贷认证状态 0:未审核，-1:未通过审核，2: 审核中，1:已通过审核 */
    NSInteger whiteRisk = self.whiteLoanInfoModel.whiteRisk;
    if (whiteRisk == 0 || whiteRisk == -1) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(whiteLoanAuthViewClickCompanyPhone)]) {
            [self.delegate whiteLoanAuthViewClickCompanyPhone];
        }
    }
}
//  社保认证
- (void)socialSecurityStatusAction{
    if (self.delegate && [self.delegate respondsToSelector:@selector(whiteLoanAuthViewClickSocialSecurity)]) {
        [self.delegate whiteLoanAuthViewClickSocialSecurity];
    }
}



- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat viewHeight = AdaptedHeight(60.0);
    
    [self.companyPhoneView setFrame:CGRectMake(0.0, 0.0, Main_Screen_Width, viewHeight)];
    self.whiteLoanTitleLabel.frame = CGRectMake(0.0, CGRectGetMaxY(self.companyPhoneView.frame), Main_Screen_Width, AdaptedHeight(40.0));
    [self.socialSecurityView setFrame:CGRectMake(0.0, CGRectGetMaxY(self.whiteLoanTitleLabel.frame), Main_Screen_Width, viewHeight)];
    [self.providentFundView setFrame:CGRectMake(0.0, CGRectGetMaxY(self.socialSecurityView.frame), Main_Screen_Width, viewHeight)];
}

- (void)setWhiteLoanInfoModel:(LSAuthSupplyCertifyModel *)whiteLoanInfoModel{
    if (_whiteLoanInfoModel != whiteLoanInfoModel) {
        _whiteLoanInfoModel = whiteLoanInfoModel;
    }
    
    if (_whiteLoanInfoModel == nil) {
        self.providentFundView.valueStr = @"未认证";
        self.socialSecurityView.valueStr = @"未认证";
        self.companyPhoneView.valueStr = @"未填写";
       
        self.providentFundView.titleImageStr = @"gongJiJinIcon";
        self.socialSecurityView.titleImageStr = @"sheBaoIcon";
        self.companyPhoneView.titleImageStr = @"company_phone";

        self.companyPhoneView.valueColor = COLOR_BLUE_STR;
        self.socialSecurityView.valueColor = COLOR_BLUE_STR;
        self.providentFundView.valueColor = COLOR_BLUE_STR;
    } else {
        //  公积金
        NSInteger fundStatus = _whiteLoanInfoModel.fundStatus;
        NSString *fundStateString = [NSString string];
        if (fundStatus == 1) {
            // 已认证
            fundStateString = @"已认证";
            self.providentFundView.titleImageStr = @"gongJiJinIconSelect";
            self.providentFundView.valueColor = COLOR_ORANGE_STR;
        } else if (fundStatus == 2) {
            fundStateString = @"认证中";
            self.providentFundView.titleImageStr = @"gongJiJinIcon";
            self.providentFundView.valueColor = COLOR_BLUE_STR;
        } else if (fundStatus == 0) {
            fundStateString = @"未认证";
            self.providentFundView.titleImageStr = @"gongJiJinIcon";
            self.providentFundView.valueColor = COLOR_BLUE_STR;
        } else if (fundStatus == -1) {
            fundStateString = @"认证失败";
            self.providentFundView.titleImageStr = @"gongJiJinIcon";
            self.providentFundView.valueColor = COLOR_BLUE_STR;
        }
        self.providentFundView.valueStr = fundStateString;
        
        //  社保
        NSInteger socialSecurityStatus = _whiteLoanInfoModel.socialSecurityStatus;
        NSString *socialSecurityStatusString = [NSString string];
        if (socialSecurityStatus == 1) {
            // 已认证
            socialSecurityStatusString = @"已认证";
            self.socialSecurityView.titleImageStr = @"sheBaoIconSelect";
            self.socialSecurityView.valueColor = COLOR_ORANGE_STR;
        } else if (socialSecurityStatus == 2) {
            socialSecurityStatusString = @"认证中";
            self.socialSecurityView.titleImageStr = @"sheBaoIcon";
            self.socialSecurityView.valueColor = COLOR_BLUE_STR;
        } else if (socialSecurityStatus == 0) {
            self.socialSecurityView.titleImageStr = @"sheBaoIcon";
            self.socialSecurityView.valueColor = COLOR_BLUE_STR;
            socialSecurityStatusString = @"未认证";
            self.socialSecurityView.titleImageStr = @"sheBaoIcon";
            self.socialSecurityView.valueColor = COLOR_BLUE_STR;
        } else if (socialSecurityStatus == -1) {
            socialSecurityStatusString = @"认证失败";
            self.socialSecurityView.titleImageStr = @"sheBaoIcon";
            self.socialSecurityView.valueColor = COLOR_BLUE_STR;
        }
        self.socialSecurityView.valueStr = socialSecurityStatusString;
        
        // 公司认证
        NSString *companyStatusStr = [NSString string];
        if (_whiteLoanInfoModel.companyStatus == 1) {
            companyStatusStr = @"已填写";
            self.companyPhoneView.titleImageStr = @"companyAuth_red";
            self.companyPhoneView.valueColor = COLOR_ORANGE_STR;
        } else if (_whiteLoanInfoModel.companyStatus == 0 || _whiteLoanInfoModel.companyStatus == -1) {
            companyStatusStr = @"去填写";
            self.companyPhoneView.titleImageStr = @"companyAuth_normal";
            self.companyPhoneView.valueColor = COLOR_BLUE_STR;
        }
        self.companyPhoneView.valueStr = companyStatusStr;
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

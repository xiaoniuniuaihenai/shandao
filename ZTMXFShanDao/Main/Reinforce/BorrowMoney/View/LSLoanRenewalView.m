//
//  LSLoanRenewalView.m
//  YWLTMeiQiiOS
//
//  Created by yangpenghua on 2017/11/16.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "LSLoanRenewalView.h"
#import "LSTopBottomLabelView.h"
#import "ALATitleValueCellView.h"
#import "ASValueTrackingSlider.h"
#import "LSBrwRenewalaInfoModel.h"
#import "BankCardModel.h"
#import "NSDate+Extension.h"
#import "ChoiseBankCardPopupView.h"
#import "DisplayInfoView.h"
#import "ZTMXFDoubleLineLabel.h"
#import "UIButton+Attribute.h"
#import "UIViewController+Visible.h"
#import "UILabel+Attribute.h"
#define kSliderAddAmount  10

@interface LSLoanRenewalView ()<ASValueTrackingSliderDataSource>
//中间灯泡右边的label  版本1.2新增
@property (nonatomic, strong) UILabel *centerPromptLabel;

@property (nonatomic, strong) UIView  *topBackgroundView;

/** 还款金额 */
@property (nonatomic, strong) UILabel               *repaymentAmountLabel;

/** 还款金额 数字 */
@property (nonatomic, strong) UILabel               *delayAmountAmountLabel;

/** 滑竿 */
@property (nonatomic, strong) ASValueTrackingSlider *amountSlider;

/** 延期还款按钮 */
@property (nonatomic, strong) XLButton              *renewalButton;

/** 最低还款本金 */
@property (nonatomic, copy) NSString               *minRepaymentCapitalAmount;
/** 最高还款本金 */
@property (nonatomic, copy) NSString               *maxRepaymentCapitalAmount;


/**天数*/
@property (nonatomic, strong) UILabel               *daysLabel;
/**费用*///延期手续费
@property (nonatomic, strong) UILabel               *costLabel;
/**下次日期*///本次逾期费
@property (nonatomic, strong) UILabel               *nextDateLabel;
/**下次日期*///新的下次还款日期
@property (nonatomic, strong) UILabel               *aNewNextDateLabel;


@end

@implementation LSLoanRenewalView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.showsVerticalScrollIndicator = NO;
        _minRepaymentCapitalAmount = @"0";
        _maxRepaymentCapitalAmount = @"0";
        [self setupViews];
    }
    return self;
}

//  添加子控件
- (void)setupViews
{
    self.topBackgroundView = [UIView setupViewWithSuperView:self withBGColor:COLOR_WHITE_STR];
    _topBackgroundView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_topBackgroundView];

    /** 我要延期还款按钮 */
    self.renewalButton = [XLButton buttonWithType:UIButtonTypeCustom];
    [self.renewalButton setTitle:@"实际支付" forState:UIControlStateNormal];
    //    self.renewalButton.titleLabel.font = [UIFont systemFontOfSize:15];
    self.renewalButton.layer.cornerRadius = 3.0;
    self.renewalButton.clipsToBounds = YES;
    _renewalButton.backgroundColor = K_MainColor;
    [self.renewalButton addTarget:self action:@selector(renewalButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.renewalButton];
    
    UIButton *loanSupermarketButton = [UIButton buttonWithType:UIButtonTypeCustom];
    loanSupermarketButton.titleLabel.font = FONT_Regular(12);
    loanSupermarketButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [loanSupermarketButton addTarget:self action:@selector(loanSupermarketButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:loanSupermarketButton];
    [UIButton attributeWithBUtton:loanSupermarketButton title:@"周转不过来，去借贷超市" titleColor:@"#888888" forState:UIControlStateNormal attributes:@[@"去借贷超市"] attributeColors:@[K_2B91F0]];
    
    CGFloat feeButtonHeight = AdaptedHeight(45);
    
    NSArray * titles = @[@"下次还款日期",@"",@"延期天数",@"延期手续费",@"本次逾期费"];
    float LableY = 0;
    for (int i = 0; i < titles.count; i++) {
        UILabel * label = [[UILabel alloc] init];
        label.frame =  CGRectMake(15 * PX, LableY, KW/2 - 15 * PX, feeButtonHeight - 1);
        if (i == 1) {
            label.height = IS_IPHONEX?250 * PX:213 * PX;
        }
        LableY = label.bottom;
        label.textColor = COLOR_SRT(@"#333333");
        label.font = FONT_Regular(16 * PX);
        label.text = titles[i];
        [_topBackgroundView addSubview:label];
        UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, label.bottom, KW, 1)];
        lineView.backgroundColor = K_LineColor;
        [_topBackgroundView addSubview:lineView];
        
        UILabel * labelR = [[UILabel alloc] init];
        labelR.frame = CGRectMake(KW / 2 , label.top, KW / 2 - 15 * PX, label.height);
        labelR.textColor = COLOR_SRT(@"#333333");
        labelR.textAlignment = NSTextAlignmentRight;
        labelR.font = FONT_Regular(16 * PX);
        [_topBackgroundView addSubview:labelR];
        if (i == 0) {
            lineView.left = 15 * PX;
            lineView.width = KW - 30 * PX;
            _aNewNextDateLabel = labelR;
        }
        if (i == 2) {
            _daysLabel = labelR;
        }
        if (i == 3) {
            _costLabel = labelR;
        }
        if (i == 4) {
            _nextDateLabel = labelR;
            _topBackgroundView.frame = CGRectMake(0, 0, KW, label.bottom);
        }
    };
    
    
    //  滑竿
    self.amountSlider = [[ASValueTrackingSlider alloc] init];
    self.amountSlider.font = [UIFont systemFontOfSize:13];
    
    [_amountSlider hidePopUpView];
    _amountSlider.minimumTrackTintColor = K_MainColor;
    _amountSlider.maximumTrackTintColor = COLOR_SRT(@"#F2F2F2");
    [_amountSlider setThumbImage:[UIImage imageNamed:@"renewal_slider_thumb"] forState:UIControlStateNormal];
    
    self.amountSlider.popUpViewColor = [UIColor clearColor];

    self.amountSlider.textColor = [UIColor colorWithHexString:COLOR_GRAY_STR];
    self.amountSlider.minimumValue = [_minRepaymentCapitalAmount doubleValue];
    self.amountSlider.maximumValue = [_maxRepaymentCapitalAmount doubleValue];
    self.amountSlider.dataSource = self;
    [_amountSlider addTarget:self action:@selector(amountSliderTouchDown:) forControlEvents:UIControlEventTouchDown];
    [self.topBackgroundView addSubview:self.amountSlider];
    _amountSlider.frame = CGRectMake(15 * PX, _aNewNextDateLabel.bottom + AdaptedHeight(66), KW - (30 * PX), AdaptedHeight(30));
    
    {
        self.repaymentAmountLabel = [UILabel labelWithTitleColorStr:COLOR_BLACK_STR fontSize:16 alignment:NSTextAlignmentLeft];
        self.repaymentAmountLabel.text = @"";
        self.repaymentAmountLabel.textColor = COLOR_SRT(@"FD4014");
        [self.topBackgroundView addSubview:self.repaymentAmountLabel];
        
        _repaymentAmountLabel.frame = CGRectMake(_amountSlider.left, _amountSlider.top - 34 * PX, KW, 22 * PX);
    }
    {
        
        self.delayAmountAmountLabel = [UILabel labelWithTitleColorStr:COLOR_BLACK_STR fontSize:16 alignment:NSTextAlignmentLeft];
        [self.topBackgroundView addSubview:self.delayAmountAmountLabel];
        
        _delayAmountAmountLabel.frame = CGRectMake(_amountSlider.left, _repaymentAmountLabel.bottom + 34 * PX, KW, 22 * PX);
    }
    

    {//slider下部的label
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = K_LineColor;
        [self.topBackgroundView addSubview:view];
        view.frame = CGRectMake(15 * PX, _aNewNextDateLabel.bottom + AdaptedHeight(133), KW - (30 * PX), 1);

        
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.image = [UIImage imageNamed:@"XL_JX_TiShi"];
        [_topBackgroundView addSubview:imageView];
        imageView.frame = CGRectMake(view.left, view.bottom + 18 * PX, 9 * PX, 12 * PX);
        
        self.centerPromptLabel = [UILabel new];
        self.centerPromptLabel.font = FONT_Regular(12 * PX);
        self.centerPromptLabel.textColor = COLOR_SRT(@"999999");
        self.centerPromptLabel.numberOfLines = 0;
        self.centerPromptLabel.text = @"办理延期还款需支付一部分本金+逾期费用+延期手续费;延期还款不支持线下支付宝办理;";
        [_topBackgroundView addSubview:self.centerPromptLabel];
        
        _centerPromptLabel.frame = CGRectMake(imageView.right + 10, imageView.top, KW - (imageView.right + 10 + 15 * PX), 40);
        [_centerPromptLabel sizeToFit];
        UIView * bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, _daysLabel.top - 10 * PX, KW, 10 * PX)];
        [_topBackgroundView addSubview:bottomLine];
        bottomLine.backgroundColor = K_LineColor;

    }
    
    

    _renewalButton.frame = CGRectMake(20, _nextDateLabel.bottom + AdaptedHeight(96), KW - 40, 44 * PX);
    loanSupermarketButton.sd_layout
    .bottomSpaceToView(_renewalButton, 10)
    .centerXEqualToView(_renewalButton)
    .heightIs(20)
    .widthIs(KW - 100);
    self.contentSize  = CGSizeMake(KW, _renewalButton.bottom + 20 +TabBar_Addition_Height);
    
}

- (void)amountSliderTouchDown:(UISlider *)slider{
    //后台打点
    [XLServerBuriedPointHelper xl_BuriedPointWithPointCode:@"hq" PointSubCode:@"click.hq_yqhk_hkje" OtherDict:nil];
}

#pragma mark 跳转到贷超
- (void)loanSupermarketButtonClick
{
    LSWebViewController *webVC = [[LSWebViewController alloc] init];
    webVC.webUrlStr = DefineUrlString(borrowGoods);
    [[UIViewController currentViewController].navigationController pushViewController:webVC animated:YES];
}

//  点击延期还款
- (void)renewalButtonAction
{
    [ZTMXFUMengHelper mqEvent:k_Extendloan_pay_xf parameter:@{@"arrears":self.totalRepaymentCapitalAmount?self.totalRepaymentCapitalAmount:@""}];
    
    if (_loanRenewalViewDelegate && [_loanRenewalViewDelegate respondsToSelector:@selector(renewalPoundageRate:)]) {
        [_loanRenewalViewDelegate renewalPoundageRate:self.currentPoundageRate];
    }
}



#pragma mark - 滑竿代理方法
- (NSString *)slider:(ASValueTrackingSlider *)slider stringForValue:(float)value{
    NSString *valueString = [NSDecimalNumber stringWithFloatValue:value];
    //  当前还款本金
    NSString *addAmountString = [NSDecimalNumber calculateReturnStringWithOpration:@"-" leftString:valueString rightString:_minRepaymentCapitalAmount];
    double addAmountDouble = [addAmountString doubleValue];
    NSInteger addIntegerAmount = floor(addAmountDouble / kSliderAddAmount) * kSliderAddAmount;
    NSString *addIntegerAmountString = [NSString stringWithFormat:@"%ld", addIntegerAmount];
    NSString *currentRepaymentCapitalAmount = [NSDecimalNumber calculateReturnStringWithOpration:@"+" leftString:_minRepaymentCapitalAmount rightString:addIntegerAmountString];
    
    //  当前还款本金描述
    NSString *valueDescribeString = [NSString stringWithFormat:@"归还本金%@元", currentRepaymentCapitalAmount];
    valueDescribeString = @"";
    //  设置还款本本金
    self.renewalCapitalAmount = currentRepaymentCapitalAmount;
    //  设置延期金额
    self.renewalAmount = [NSDecimalNumber calculateReturnStringWithOpration:@"-" leftString:self.totalRepaymentCapitalAmount rightString:currentRepaymentCapitalAmount];
    
    self.delayAmountAmountLabel.text = [NSString stringWithFormat:@"剩余待还 %@ 元",self.renewalAmount];
    [UILabel attributeWithLabel:_delayAmountAmountLabel text:_delayAmountAmountLabel.text textColor:@"666666" attributesOriginalColorStrs:@[_renewalAmount] attributeNewColors:@[K_MainColor] textFont:16 * PX attributesOriginalFontStrs:@[_renewalAmount] attributeNewFonts:@[FONT_Medium(16 * PX)]];


    //  延期手续费
    self.currentPoundageRate = [self gainCurrentPoundageRate];
    NSString *delayInterestAmount = [[NSDecimalNumber calculateReturnDecimalNumberWithOpration:@"*" leftString:self.renewalAmount rightString:self.currentPoundageRate] calculateReturnStringWithOpration:@"*" oprationString:self.renewalInfoModel.renewalDay];
    self.costLabel.text = [NSString stringWithFormat:@"%@元", [NSDecimalNumber stringWithScale:2 roundModel:NSRoundDown originalString:delayInterestAmount]];
    //  还款金额(逾期费+ 延期手续费+上期利息 + 还款本金)
    NSString *overdueAmount = [NSDecimalNumber stringWithFloatValue:self.renewalInfoModel.overdueAmount];
    NSString *rateAmount = [NSDecimalNumber stringWithFloatValue:self.renewalInfoModel.rateAmount];
    //  (逾期费+延期手续费)
    NSString *overdueAndDelayInterest = [NSDecimalNumber calculateReturnStringWithOpration:@"+" leftString:overdueAmount rightString:delayInterestAmount];
    //  (上期利息 + 本次归还本金)
    NSString *rateAndCapital = [NSDecimalNumber calculateReturnStringWithOpration:@"+" leftString:rateAmount rightString:self.renewalCapitalAmount];
    //  总费用
    NSString *totalPayAmount = [NSDecimalNumber calculateReturnStringWithOpration:@"+" leftString:overdueAndDelayInterest rightString:rateAndCapital];
    NSString *totalPayScaleTwo = [NSDecimalNumber stringWithScale:2 roundModel:NSRoundDown originalString:totalPayAmount];
    _payAmount = totalPayScaleTwo;
    
    self.repaymentAmountLabel.text = [NSString stringWithFormat:@"还款金额 %@ 元",  self.renewalCapitalAmount];
    
    [UILabel attributeWithLabel:_repaymentAmountLabel text:_repaymentAmountLabel.text textColor:@"666666" attributesOriginalColorStrs:@[_renewalCapitalAmount] attributeNewColors:@[K_MainColor] textFont:16 * PX attributesOriginalFontStrs:@[_renewalCapitalAmount] attributeNewFonts:@[FONT_Medium(16 * PX)]];


    //  实际支付按钮
    [self.renewalButton setTitle:[NSString stringWithFormat:@"实际支付¥%@元,申请延期",totalPayScaleTwo] forState:UIControlStateNormal];
    [self.amountSlider hidePopUpView];

    return valueDescribeString;
}

#pragma mark - setter
- (void)setRenewalInfoModel:(LSBrwRenewalaInfoModel *)renewalInfoModel{
    if (_renewalInfoModel != renewalInfoModel) {
        _renewalInfoModel = renewalInfoModel;
    }
    [self updateViewDataNew];
    
    self.amountSlider.value = (self.renewalInfoModel.highestRenewalAmount +  self.renewalInfoModel.lowestRenewalAmount) / 2;
}

///  更新页面数据
- (void)updateViewData
{
    //  设置还款本本金
    self.renewalCapitalAmount = [NSDecimalNumber stringWithFloatValue:self.renewalInfoModel.lowestRenewalAmount];
    //  设置延期金额
    self.renewalAmount = [NSDecimalNumber calculateReturnStringWithOpration:@"-" leftString:self.totalRepaymentCapitalAmount rightString:self.renewalCapitalAmount];
    
    self.delayAmountAmountLabel.text = [NSString stringWithFormat:@"剩余待还 %@ 元",self.renewalAmount];
    [UILabel attributeWithLabel:_delayAmountAmountLabel text:_delayAmountAmountLabel.text textColor:@"666666" attributesOriginalColorStrs:@[_renewalAmount] attributeNewColors:@[K_MainColor] textFont:16 * PX attributesOriginalFontStrs:@[_renewalAmount] attributeNewFonts:@[FONT_Medium(16 * PX)]];

    //  延期天数
    
    self.daysLabel.text = [NSString stringWithFormat:@"%@天",self.renewalInfoModel.renewalDay];
    
    //  下次还款日期
//    self.repaymentDateView.bottomStr = [NSDate dateYMDacrossStringFromLongDate:self.renewalInfoModel.nextGmtPlanRepayment];
    self.nextDateLabel.text = [NSDate dateYMDacrossStringFromLongDate:self.renewalInfoModel.nextGmtPlanRepayment];
    
    //  最小/最大还款本金
    self.minRepaymentCapitalAmount = [NSDecimalNumber stringWithFloatValue:self.renewalInfoModel.lowestRenewalAmount];
    self.maxRepaymentCapitalAmount = [NSDecimalNumber stringWithFloatValue:self.renewalInfoModel.highestRenewalAmount];
    self.amountSlider.minimumValue = self.renewalInfoModel.lowestRenewalAmount;
    self.amountSlider.maximumValue = self.renewalInfoModel.highestRenewalAmount;
    
    //  还款金额(逾期费+ 延期手续费+上期利息 + 还款本金)
    self.currentPoundageRate = [self gainCurrentPoundageRate];
    NSString *delayInterestAmount = [[NSDecimalNumber calculateReturnDecimalNumberWithOpration:@"*" leftString:self.renewalAmount rightString:self.currentPoundageRate] calculateReturnStringWithOpration:@"*" oprationString:self.renewalInfoModel.renewalDay];
    //  还款金额(逾期费+ 延期手续费+上期利息 + 还款本金)
    NSString *overdueAmount = [NSDecimalNumber stringWithFloatValue:self.renewalInfoModel.overdueAmount];
    NSString *rateAmount = [NSDecimalNumber stringWithFloatValue:self.renewalInfoModel.rateAmount];
    //  (逾期费+延期手续费)
    NSString *overdueAndDelayInterest = [NSDecimalNumber calculateReturnStringWithOpration:@"+" leftString:overdueAmount rightString:delayInterestAmount];
    //  (上期利息 + 本次归还本金)
    NSString *rateAndCapital = [NSDecimalNumber calculateReturnStringWithOpration:@"+" leftString:rateAmount rightString:self.renewalCapitalAmount];
    //  总费用
    NSString *totalPayAmount = [NSDecimalNumber calculateReturnStringWithOpration:@"+" leftString:overdueAndDelayInterest rightString:rateAndCapital];
    self.repaymentAmountLabel.text = [NSString stringWithFormat:@"还款金额 %@ 元", totalPayAmount];
    
    [UILabel attributeWithLabel:_repaymentAmountLabel text:_repaymentAmountLabel.text textColor:@"666666" attributesOriginalColorStrs:@[totalPayAmount] attributeNewColors:@[K_MainColor] textFont:16 * PX attributesOriginalFontStrs:@[totalPayAmount] attributeNewFonts:@[FONT_Medium(16 * PX)]];

    //  实际支付按钮文案
    NSString *totalPayScaleTwo = [NSDecimalNumber stringWithScale:2 roundModel:NSRoundDown originalString:totalPayAmount];
    _payAmount = totalPayScaleTwo;
    
    [self.renewalButton setTitle:[NSString stringWithFormat:@"实际支付%@元,申请延期",totalPayScaleTwo] forState:UIControlStateNormal];
    //  延期手续费
    self.costLabel.text = [NSDecimalNumber stringWithScale:2 roundModel:NSRoundDown originalString:delayInterestAmount];
    //  显示slider 弹框
}
///  更新页面数据
- (void)updateViewDataNew
{
    //  设置还款本本金
    self.renewalCapitalAmount = [NSDecimalNumber stringWithFloatValue:self.renewalInfoModel.lowestRenewalAmount];
    //  设置延期金额
    self.renewalAmount = [NSDecimalNumber calculateReturnStringWithOpration:@"-" leftString:self.totalRepaymentCapitalAmount rightString:self.renewalCapitalAmount];
    
    self.delayAmountAmountLabel.text = [NSString stringWithFormat:@"剩余待还 %@ 元",self.renewalAmount];
    [UILabel attributeWithLabel:_delayAmountAmountLabel text:_delayAmountAmountLabel.text textColor:@"666666" attributesOriginalColorStrs:@[_renewalAmount] attributeNewColors:@[K_MainColor] textFont:16 * PX attributesOriginalFontStrs:@[_renewalAmount] attributeNewFonts:@[FONT_Medium(16 * PX)]];


    self.daysLabel.text = [NSString stringWithFormat:@"%@天",self.renewalInfoModel.renewalDay];
    
    //  下次还款日期
    self.aNewNextDateLabel.text = [NSDate dateYMDacrossStringFromLongDate:self.renewalInfoModel.nextGmtPlanRepayment];
    
    //  逾期费
    self.nextDateLabel.text = [NSString stringWithFormat:@"%.2f元",self.renewalInfoModel.overdueAmount];
    //  上期利息
    
    //  最小/最大还款本金
    self.minRepaymentCapitalAmount = [NSDecimalNumber stringWithFloatValue:self.renewalInfoModel.lowestRenewalAmount];
    self.maxRepaymentCapitalAmount = [NSDecimalNumber stringWithFloatValue:self.renewalInfoModel.highestRenewalAmount];
    self.amountSlider.minimumValue = self.renewalInfoModel.lowestRenewalAmount;
    self.amountSlider.maximumValue = self.renewalInfoModel.highestRenewalAmount;
    
    //  还款金额(逾期费+ 延期手续费+上期利息 + 还款本金)
    self.currentPoundageRate = [self gainCurrentPoundageRate];
    NSString *delayInterestAmount = [[NSDecimalNumber calculateReturnDecimalNumberWithOpration:@"*" leftString:self.renewalAmount rightString:self.currentPoundageRate] calculateReturnStringWithOpration:@"*" oprationString:self.renewalInfoModel.renewalDay];
    //  还款金额(逾期费+ 延期手续费+上期利息 + 还款本金)
    NSString *overdueAmount = [NSDecimalNumber stringWithFloatValue:self.renewalInfoModel.overdueAmount];
    NSString *rateAmount = [NSDecimalNumber stringWithFloatValue:self.renewalInfoModel.rateAmount];
    //  (逾期费+延期手续费)
    NSString *overdueAndDelayInterest = [NSDecimalNumber calculateReturnStringWithOpration:@"+" leftString:overdueAmount rightString:delayInterestAmount];
    //  (上期利息 + 本次归还本金)
    NSString *rateAndCapital = [NSDecimalNumber calculateReturnStringWithOpration:@"+" leftString:rateAmount rightString:self.renewalCapitalAmount];
    //  总费用
    NSString *totalPayAmount = [NSDecimalNumber calculateReturnStringWithOpration:@"+" leftString:overdueAndDelayInterest rightString:rateAndCapital];
    
    self.repaymentAmountLabel.text = [NSString stringWithFormat:@"还款金额%@元",  self.minRepaymentCapitalAmount];
    
    //  实际支付按钮文案
    NSString *totalPayScaleTwo = [NSDecimalNumber stringWithScale:2 roundModel:NSRoundDown originalString:totalPayAmount];
    [self.renewalButton setTitle:[NSString stringWithFormat:@"实际支付¥%@元,申请延期",totalPayScaleTwo] forState:UIControlStateNormal];
    _payAmount = totalPayScaleTwo;
    
    //  延期手续费
    self.costLabel.text = [NSString stringWithFormat:@"%@元",[NSDecimalNumber stringWithScale:2 roundModel:NSRoundDown originalString:delayInterestAmount]];
    [self.amountSlider hidePopUpView];

}

//  获取当前金额的手续费率
- (NSString *)gainCurrentPoundageRate
{
    NSString *poundage = @"0";
    if (self.renewalInfoModel.poundageRate) {
        poundage = [NSDecimalNumber stringWithFloatValue:self.renewalInfoModel.poundageRate];
    }
    //  获取区间最大值
    NSString *maxRepaymentAmountString = self.maxRepaymentCapitalAmount;
    for (RenewalAmountModel *renewalAmount in self.renewalInfoModel.renewalList) {
        NSString *highestPayAmountString = [NSDecimalNumber stringWithFloatValue:renewalAmount.highestPayAmount];
        NSComparisonResult compareResult = [NSDecimalNumber compareStringWithleftString:maxRepaymentAmountString rightString:highestPayAmountString];
        if (compareResult == NSOrderedAscending) {
            maxRepaymentAmountString = highestPayAmountString;
        }
    }
    
    for (int i = 0; i < self.renewalInfoModel.renewalList.count; i ++) {
        RenewalAmountModel *renewalAmountModel = self.renewalInfoModel.renewalList[i];
        NSString *lowsetPayAmount = [NSDecimalNumber stringWithFloatValue:renewalAmountModel.lowsetPayAmount];
        NSString *highestPayAmount = [NSDecimalNumber stringWithFloatValue:renewalAmountModel.highestPayAmount];
        NSComparisonResult lowCompareResult = [NSDecimalNumber compareStringWithleftString:self.renewalCapitalAmount rightString:lowsetPayAmount];
        NSComparisonResult highCompareResult = [NSDecimalNumber compareStringWithleftString:self.renewalCapitalAmount rightString:highestPayAmount];
        NSComparisonResult maxCompareResult = [NSDecimalNumber compareStringWithleftString:self.renewalCapitalAmount rightString:maxRepaymentAmountString];
        if (lowCompareResult != NSOrderedAscending && highCompareResult == NSOrderedAscending) {
            //  当前还款金额大于等于最低还款金额 并且小于最高还款金额
            poundage = [NSDecimalNumber stringWithFloatValue:renewalAmountModel.regionPoundageRate];
            break;
        } else if (lowCompareResult != NSOrderedAscending && highCompareResult == NSOrderedSame && maxCompareResult == NSOrderedSame){
            //  当前还款金额大于等于最低还款金额 并且等于最高还款金额
            poundage = [NSDecimalNumber stringWithFloatValue:renewalAmountModel.regionPoundageRate];
            break;
        }
    }
    
    return poundage;
}



/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end

//
//  LoanFirstCell.m
//  ZTMXFXunMiaoiOS
//
//  Created by 陈传亮 on 2018/3/10.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "ZTMXFLoanFirstCell.h"
#import "UILabel+Attribute.h"
#import "UIButton+Attribute.h"
#import "ZTMXFAmountSlider.h"
#import "LoanModel.h"
#import "ZTMXFTitleButton.h"
#import "JBBorrowRateAlertView.h"
#import "ZTMXFTestimonialsAlertView.h"

#define kLoanSliderAddAmount 10

@interface ZTMXFLoanFirstCell ()

@property (nonatomic, strong)UILabel * amountLabel;

@property (nonatomic, strong)UILabel * promptLabel;

/** 滑竿 */
@property (nonatomic, strong) ZTMXFAmountSlider  *amountSlider;

@property (nonatomic, strong)UILabel * maxLabel;

@property (nonatomic, strong)UILabel * minLabel;

@property (nonatomic, strong)UIView *timeButtonView;
@property (nonatomic, strong)UIButton * firstTimeBtn;
@property (nonatomic, strong)UIButton * secondTimeBtn;
@property (nonatomic, strong)UIButton * thirdTimeBtn;

/**
 服务费
 */
@property (nonatomic, strong)UILabel * serviceFeeLabel;
/**
 描述按钮
 */
@property (nonatomic, strong) ZTMXFTitleButton *describeButton;

@property (nonatomic, copy) NSArray * timeBtns;



@end

@implementation ZTMXFLoanFirstCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _amountLabel = [UILabel new];
        _amountLabel.textAlignment = NSTextAlignmentCenter;
        
        _promptLabel = [UILabel new];
        _promptLabel.textAlignment = NSTextAlignmentCenter;
        _promptLabel.textColor = COLOR_SRT(@"#999999");
        _promptLabel.font = FONT_Regular(13 * PY);
//        _promptLabel.text = @"不向学生及20岁以下用户提供借款服务";
        
        _timeButtonView = [UIView new];
        _timeButtonView.backgroundColor = [UIColor clearColor];
        
        _firstTimeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _firstTimeBtn.titleLabel.font = FONT_Regular(14);
        _secondTimeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _secondTimeBtn.titleLabel.font = FONT_Regular(14);
        _thirdTimeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _thirdTimeBtn.titleLabel.font = FONT_Regular(14);
        
        _firstTimeBtn.layer.borderWidth = 1;
        _firstTimeBtn.layer.borderColor = K_MainColor.CGColor;
        _firstTimeBtn.layer.cornerRadius = 2;
        _firstTimeBtn.layer.masksToBounds = YES;
        
        _secondTimeBtn.layer.borderWidth = 1;
        _secondTimeBtn.layer.borderColor = K_MainColor.CGColor;
        _secondTimeBtn.layer.cornerRadius = 2;
        _secondTimeBtn.layer.masksToBounds = YES;
        
        _thirdTimeBtn.layer.borderWidth = 1;
        _thirdTimeBtn.layer.borderColor = K_MainColor.CGColor;
        _thirdTimeBtn.layer.cornerRadius = 2;
        _thirdTimeBtn.layer.masksToBounds = YES;
        
        [_timeButtonView addSubview:_firstTimeBtn];
        [_timeButtonView addSubview:_secondTimeBtn];
        [_timeButtonView addSubview:_thirdTimeBtn];
        
        _firstTimeBtn.hidden = YES;
        _secondTimeBtn.hidden = YES;
        _thirdTimeBtn.hidden = YES;
        _firstTimeBtn.userInteractionEnabled = NO;
        _secondTimeBtn.userInteractionEnabled = NO;
        _thirdTimeBtn.userInteractionEnabled = NO;
        
        
        [_firstTimeBtn addTarget:self action:@selector(timeActionBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_secondTimeBtn addTarget:self action:@selector(timeActionBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_thirdTimeBtn addTarget:self action:@selector(timeActionBtn:) forControlEvents:UIControlEventTouchUpInside];

        
        _submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_submitBtn setTitle:@"立即借款" forState:UIControlStateNormal];
        [_submitBtn setTitleColor:K_BtnTitleColor forState:UIControlStateNormal];
        [_submitBtn setTitleColor:K_BtnTitleColor forState:UIControlStateHighlighted];
        _submitBtn.titleLabel.font = FONT_Medium(16);
        _submitBtn.backgroundColor = K_MainColor;
        _submitBtn.layer.cornerRadius = X(5);
        _minLabel = [UILabel new];
        _minLabel.textColor = K_B8B8B8;
        _minLabel.font = FONT_Regular(13 * PY);
        
        _maxLabel = [UILabel new];
        _maxLabel.textColor = K_B8B8B8;
        _maxLabel.font = FONT_Regular(13 * PY);
        _maxLabel.textAlignment = NSTextAlignmentRight;
        
        _serviceFeeLabel = [UILabel new];
        _serviceFeeLabel.font = FONT_Regular(13);
        _serviceFeeLabel.textColor = K_GoldenColor;
        _serviceFeeLabel.textAlignment = NSTextAlignmentCenter;
        
        
        [self.contentView addSubview:_amountLabel];
        [self.contentView addSubview:_promptLabel];
        [self.contentView addSubview:_timeButtonView];
        [self.contentView addSubview:_submitBtn];
        [self.contentView addSubview:self.amountSlider];
        [self.contentView addSubview:_maxLabel];
        [self.contentView addSubview:_minLabel];
        [self.contentView addSubview:self.describeButton];
        _timeBtns = @[_firstTimeBtn, _secondTimeBtn,_thirdTimeBtn];

        
        UILabel * timeTextLabel = [UILabel new];
        timeTextLabel.text = @"借多久";
        timeTextLabel.font = FONT_Regular(15 * PX);
        timeTextLabel.textColor = K_333333;
        [self.contentView addSubview:timeTextLabel];
        timeTextLabel.hidden = YES;
        
        UILabel *sliderTextLabel = [UILabel new];
        sliderTextLabel.text = @"借多少";
        sliderTextLabel.font = FONT_Regular(15 * PX);
        sliderTextLabel.textColor = K_333333;
        [self.contentView addSubview:sliderTextLabel];
        sliderTextLabel.hidden = YES;
        
        
        _amountLabel.sd_layout
        .leftEqualToView(self.contentView)
        .rightEqualToView(self.contentView)
        .topSpaceToView(self.contentView, 20 * PY)
        .heightIs(50 * PY);
        
        _describeButton.sd_layout
        .leftSpaceToView(self.contentView, 20)
        .rightSpaceToView(self.contentView, 20)
        .topSpaceToView(_amountLabel, 13 * PY)
        .heightIs(20 * PY);
        
        sliderTextLabel.sd_layout
        .leftSpaceToView(self.contentView, X(28))
        .widthIs(X(60))
        .topSpaceToView(_amountLabel, X(45))
        .heightIs(X(20));
        
        _amountSlider.sd_layout
        .leftSpaceToView(self.contentView, 35)
        .rightSpaceToView(self.contentView, 35)
        .centerYEqualToView(sliderTextLabel)
        .heightIs(9);
        
        _minLabel.sd_layout
        .leftEqualToView(_amountSlider)
        .topSpaceToView(_amountSlider, 7)
        .widthRatioToView(_amountSlider, 0.5)
        .heightIs(20*PY);
        
        _maxLabel.sd_layout
        .rightEqualToView(_amountSlider)
        .topEqualToView(_minLabel)
        .widthRatioToView(_minLabel, 1)
        .bottomEqualToView(_minLabel);
        
        timeTextLabel.sd_layout
        .leftEqualToView(sliderTextLabel)
        .topSpaceToView(_amountSlider, 62 * PY)
        .heightIs(20 * PY);
        [timeTextLabel setSingleLineAutoResizeWithMaxWidth:200];
        
        _timeButtonView.sd_layout
        .rightEqualToView(_amountSlider)
        .leftEqualToView(_amountSlider)
        .topSpaceToView(_amountSlider, 62 * PY)
        .heightIs(38 * PX);
        
        _secondTimeBtn.sd_layout
        .centerXEqualToView(_timeButtonView)
        .topSpaceToView(_timeButtonView, 0)
        .widthIs(70 * PX)
        .heightIs(38 * PX);

        _firstTimeBtn.sd_layout
        .leftSpaceToView(_secondTimeBtn, 20 * PX)
        .topEqualToView(_secondTimeBtn)
        .heightRatioToView(_secondTimeBtn, 1)
        .widthRatioToView(_secondTimeBtn, 1);

        _thirdTimeBtn.sd_layout
        .rightSpaceToView(_secondTimeBtn, 20 * PX)
        .topEqualToView(_secondTimeBtn)
        .heightRatioToView(_secondTimeBtn, 1)
        .widthRatioToView(_secondTimeBtn, 1);
        
        _submitBtn.sd_layout
        .topSpaceToView(_amountSlider, 134 * PY)
        .centerXEqualToView(_amountSlider)
        .widthRatioToView(_amountSlider, 1)
        .heightIs(44 * PY);
        
//        _submitBtn.sd_layout
//        .leftSpaceToView(self.contentView, 20)
//        .rightSpaceToView(self.contentView, 20)
//        .topSpaceToView(_amountSlider, 134 * PY)
//        .heightIs(44 * PY);
    
        _promptLabel.sd_layout
        .leftEqualToView(self.contentView)
        .rightEqualToView(self.contentView)
        .topSpaceToView(_submitBtn, 14)
        .heightIs(20 * PY);
        
    }
    return self;
}







- (ZTMXFTitleButton *)describeButton{
    if (_describeButton == nil) {
        _describeButton = [ZTMXFTitleButton buttonWithType:UIButtonTypeCustom];
        [_describeButton addTarget:self action:@selector(describeButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [_describeButton setTitle:@"" forState:UIControlStateNormal];
        _describeButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_describeButton setTitleColor:[UIColor colorWithHexString:COLOR_LIGHT_STR] forState:UIControlStateNormal];
        [_describeButton setImage:[UIImage imageNamed:@"homePage_reminder"] forState:UIControlStateNormal];
    }
    return _describeButton;
}

- (void)describeButtonAction
{
    NSString *poundageRateString = self.loanModel.statusInfo.xlPoundageRate;
    NSString *bankRateString = self.loanModel.statusInfo.bankRate;
    NSString *bankRate = [NSDecimalNumber calculateReturnStringWithOpration:@"*" leftString:bankRateString rightString:@"100"];
    NSString *poundageRate = [NSDecimalNumber calculateReturnStringWithOpration:@"*" leftString:poundageRateString rightString:@"100"];
    NSString * str1 = [NSString stringWithFormat:@"服务费 = 借款本金*服务费率*借款天数"];
    NSString * str2 = [NSString stringWithFormat:@"服务费率: %@%%",poundageRate];
    NSString * str3 = [NSString stringWithFormat:@"借款日利率: %@%%",bankRate];
    NSString * str = [NSString stringWithFormat:@"%@\n\n%@\n\n%@", str1, str2, str3];
    [ZTMXFTestimonialsAlertView showWithMessage:str];
    
}

- (void)timeActionBtn:(UIButton *)btn
{
    NSString *string = [btn.titleLabel.text stringByReplacingOccurrencesOfString:@"天" withString:@""];
    //后台打点
    [XLServerBuriedPointHelper xl_BuriedPointWithPointCode:@"jq" PointSubCode:@"click.jq_ts" OtherDict:[@{@"jqDayNumber":string} mutableCopy]];
    [self selectBtn:btn];
}

- (void)selectBtn:(UIButton *)btn{
    _loanModel.timeParameter = [btn.titleLabel.text stringByReplacingOccurrencesOfString:@"天" withString:@""];
    [btn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    btn.layer.borderColor = K_MainColor.CGColor;
    [btn setBackgroundImage:[UIImage imageWithColor:K_MainColor] forState:UIControlStateNormal];
    btn.titleLabel.font = FONT_Medium(14 * PX);
    for (UIButton * button in _timeBtns) {
        NSString * buttonStr = [button.titleLabel.text stringByReplacingOccurrencesOfString:@"天" withString:@""];
        if (![buttonStr isEqualToString:_loanModel.timeParameter]) {
            [button setTitleColor:COLOR_SRT(@"#666666") forState:UIControlStateNormal];
            button.layer.borderColor = K_MainColor.CGColor;
            button.titleLabel.font = FONT_Regular(14 * PX);
            [button setBackgroundImage:[UIImage imageWithColor:UIColor.whiteColor] forState:UIControlStateNormal];
            //            button.backgroundColor = [UIColor whiteColor];
        }
    }
    [self updateAmount];

}

- (ZTMXFAmountSlider *)amountSlider
{
    if (_amountSlider == nil) {
        _amountSlider = [[ZTMXFAmountSlider alloc] init];
        _amountSlider.minimumTrackTintColor = K_MainColor;
        _amountSlider.maximumTrackTintColor = COLOR_SRT(@"#F2F2F2");
        [_amountSlider setThumbImage:[UIImage imageNamed:@"renewal_slider_thumb"] forState:UIControlStateNormal];
        [_amountSlider addTarget:self action:@selector(amountSliderChange:) forControlEvents:UIControlEventValueChanged];
        [_amountSlider addTarget:self action:@selector(amountSliderBegin:) forControlEvents:UIControlEventTouchDown];
    }
    return _amountSlider;
}

- (void)setLoanModel:(LoanModel *)loanModel
{
    if (_loanModel != loanModel) {
        _loanModel = loanModel;
    }
    _maxLabel.text = _loanModel.statusInfo.maxAmount;
    _minLabel.text = _loanModel.statusInfo.minAmount;
    _amountSlider.maximumValue = [_loanModel.statusInfo.maxAmount floatValue];
    _amountSlider.minimumValue = [_loanModel.statusInfo.minAmount floatValue];
    _amountSlider.value =  [_loanModel.amountParameter floatValue];
   
    for (UIButton * dayBtn in _timeBtns) {
        dayBtn.hidden = YES;
        dayBtn.userInteractionEnabled = NO;
    }
    if (self.loanModel.days.count <= _timeBtns.count) {
        for (int i = 0; i < self.loanModel.days.count; i++) {
            UIButton * btn = _timeBtns[i];
            btn.userInteractionEnabled = YES;
            btn.hidden = NO;
            NSString * str = [NSString stringWithFormat:@"%@天", self.loanModel.days[self.loanModel.days.count - 1 - i]];
            [btn setTitle:str forState:UIControlStateNormal];
            if ([self.loanModel.timeParameter isEqualToString:self.loanModel.days[self.loanModel.days.count - 1 - i]]) {
                [self selectBtn:btn];
            }
        }
    }
    [self configTimeBtnLayout];
    _promptLabel.text = _loanModel.underReminder;
    [self updateAmount];

}

// 调整时间按钮布局
- (void)configTimeBtnLayout
{
    BOOL evenNum = (self.loanModel.days.count % 2) ? NO : YES;
    BOOL singleNum = (self.loanModel.days.count % 3) == 1 ? YES : NO;
    CGFloat btnCenter = _timeButtonView.width / 2.f;
    if (evenNum) {
        btnCenter = (_timeButtonView.width - 90.f * PX) / 2.f;
    } else if (singleNum) {
        btnCenter = _timeButtonView.width / 2.f - 90.f * PX;
    }
    _secondTimeBtn.sd_resetLayout
    .centerXIs(btnCenter)
    .topSpaceToView(_timeButtonView, 0)
    .widthIs(70 * PX)
    .heightIs(38 * PX);
    
    _firstTimeBtn.sd_resetLayout
    .leftSpaceToView(_secondTimeBtn, 20 * PX)
    .topEqualToView(_secondTimeBtn)
    .heightRatioToView(_secondTimeBtn, 1)
    .widthRatioToView(_secondTimeBtn, 1);
    
    _thirdTimeBtn.sd_resetLayout
    .rightSpaceToView(_secondTimeBtn, 20 * PX)
    .topEqualToView(_secondTimeBtn)
    .heightRatioToView(_secondTimeBtn, 1)
    .widthRatioToView(_secondTimeBtn, 1);
    
}

//  滑动借钱金额
- (void)amountSliderChange:(ZTMXFAmountSlider *)sender{
    //  滑动滑块增加的金额
    NSInteger y = round(powf(kLoanSliderAddAmount, _minLabel.text.length)) / kLoanSliderAddAmount;

    NSInteger amount = round(sender.value / y) * y;
    self.loanModel.amountParameter = [@(amount) stringValue];
    [self updateAmount];
}

- (void)amountSliderBegin:(ZTMXFAmountSlider *)sender{
    //后台打点
    [XLServerBuriedPointHelper xl_BuriedPointWithPointCode:@"jq" PointSubCode:@"click.jq_edt" OtherDict:nil];
}

- (void)updateAmount
{
    NSString * amountStr = [NSString stringWithFormat:@"%@", _loanModel.amountParameter?:@""];
    [UILabel attributeWithLabel:_amountLabel text:amountStr maxFont:50 * PY minFont:28 * PY attributes:@[@"",amountStr] attributeFonts:@[FONT_LIGHT(28 * PY), FONT_Medium(48 * PY)]];
    NSString *loanProcedureFee = [[NSDecimalNumber calculateReturnDecimalNumberWithOpration:@"*" leftString:self.loanModel.amountParameter rightString:self.loanModel.timeParameter] calculateReturnStringWithOpration:@"*" oprationString:self.loanModel.statusInfo.xlPoundageRate];
    
    NSString * describeString = [NSString stringWithFormat:@"服务费 %@元 ", loanProcedureFee];
    [UIButton attributeWithBUtton:self.describeButton title:describeString titleColor:COLOR_GRAY_STR forState:UIControlStateNormal attributes:@[loanProcedureFee, @"元"] attributeColors:@[COLOR_SRT(@"2b91f0"), COLOR_SRT(@"2b91f0")]];
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end

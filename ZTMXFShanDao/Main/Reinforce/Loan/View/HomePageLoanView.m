//
//  HomePageLoanView.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/12/7.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "HomePageLoanView.h"
#import "ZTMXFLeftImageLabel.h"
#import "ZTMXFTitleButton.h"
#import "ZTMXFAmountSlider.h"
#import "LSBorrowMenuView.h"
#import "LSBorrowHomeInfoModel.h"
#import "JBBorrowRateAlertView.h"
#import "UIButton+Attribute.h"
#import "ZTMXFDoubleLineLabel.h"

#define kLoanSliderAddAmount 100

@interface HomePageLoanView ()<LSBorrowMenuViewDelegate, LSBorrowMenuViewDelegate>

/** title */
@property (nonatomic, strong) ZTMXFLeftImageLabel *titleImageLabel;
/** right title */
@property (nonatomic, strong) UILabel *rightTitleLabel;
/** lineView */
@property (nonatomic, strong) UIView *lineView;
/** row button */
@property (nonatomic, strong) UIButton *rowButton;


/** 金额label */
@property (nonatomic, strong) UILabel *amountLabel;
/** 描述按钮 */
@property (nonatomic, strong) ZTMXFTitleButton *describeButton;

/** 滑竿 */
@property (nonatomic, strong) ZTMXFAmountSlider  *amountSlider;
/** 最小金额 */
@property (nonatomic, strong) UILabel    *minAmountLabel;
/** 最大金额 */
@property (nonatomic, strong) UILabel    *maxAmountLabel;

/** 设置借款天数 */
@property (nonatomic, strong) LSBorrowMenuView *borrowDaysMenu;
/** 借款按钮 */
@property (nonatomic, strong) ZTMXFButton *loanButton;
/** no loan label */
@property (nonatomic, strong) ZTMXFDoubleLineLabel *noLoanLabel;

/** 借款类型 */
@property (nonatomic, assign) LoanViewType loanViewType;

/** 借钱数组 */
@property (nonatomic, strong) NSArray *borrowDaysArray;

/** 最小借款金额 */
@property (nonatomic, assign) CGFloat minLoanAmount;
/** 最大借款金额 */
@property (nonatomic, assign) CGFloat maxLoanAmount;
/** 服务费率 */
@property (nonatomic, copy) NSString *serviceFeeRate;
/** 日利率 */
@property (nonatomic, copy) NSString *dayRate;
/** 当前选中天数 */
@property (nonatomic, copy) NSString *currentSelectDay;
/** 借款金额 */
@property (nonatomic, assign) CGFloat currentLoanAmount;

@end

@implementation HomePageLoanView



- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

//  添加子控件
- (void)setupViews{
    
    [self addSubview:self.titleImageLabel];
    [self addSubview:self.rightTitleLabel];
    [self addSubview:self.lineView];
    if (_loanViewType == WhiteLoanViewType) {
        [self addSubview:self.rowButton];
    }
    [self addSubview:self.amountLabel];
    [self addSubview:self.describeButton];
    [self addSubview:self.amountSlider];
    [self addSubview:self.minAmountLabel];
    [self addSubview:self.maxAmountLabel];
    [self addSubview:self.borrowDaysMenu];
    [self addSubview:self.loanButton];
//    v 1.7.0 抛弃
//    if (_loanViewType == ConsumeLoanViewType) {
//        [self addSubview:self.noLoanLabel];
//        self.noLoanLabel.lineColor = [UIColor colorWithHexString:@"EDEFF0"];
//        self.noLoanLabel.lineWidth = AdaptedWidth(35.0);
//        self.noLoanLabel.lineHeight = AdaptedHeight(1);
//        self.noLoanLabel.lineMarging = 8.0;
//    }
    
    [self.amountSlider addTarget:self action:@selector(amountSliderChange:) forControlEvents:UIControlEventValueChanged];
    [self.loanButton addTarget:self action:@selector(loanButtonAction) forControlEvents:UIControlEventTouchUpInside];
}
- (instancetype)initWithLoanType:(LoanViewType)loanViewType{
    _loanViewType = loanViewType;
    if (self = [super init]) {
    }
    return self;
}


- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat viewWidth = self.bounds.size.width;
    self.titleImageLabel.frame = CGRectMake(5.0, AdaptedHeight(12.0), 120.0, AdaptedHeight(22.0));
    WhiteLoanStatusInfo *whiteStatusInfo = self.homeInfoModel.whiteStatusInfo;
    if (!kStringIsEmpty(whiteStatusInfo.whiteAuthInfo)) {
        //  白领贷审核中
        self.rightTitleLabel.frame = CGRectMake(Main_Screen_Width - 200.0 - 25.0, 0.0, 200.0, AdaptedHeight(44.0));
    } else if (!kStringIsEmpty(whiteStatusInfo.whiteRiskRetrialRemind)) {
        //  白领贷认证未通过
        self.rightTitleLabel.frame = CGRectMake(Main_Screen_Width - 200.0 - 25.0, 0.0, 200.0, AdaptedHeight(44.0));
    } else {
        self.rightTitleLabel.frame = CGRectMake(Main_Screen_Width - 200.0 - 12.0, 0.0, 200.0, AdaptedHeight(44.0));
    }
    
    self.lineView.frame = CGRectMake(0.0, CGRectGetMaxY(self.rightTitleLabel.frame), viewWidth, 0.5);
    self.rowButton.frame = CGRectMake(viewWidth - 12.0 - 200.0, 0.0, 200.0, CGRectGetHeight(self.rightTitleLabel.frame));
    
    self.amountLabel.frame = CGRectMake(0.0, CGRectGetMaxY(self.lineView.frame) + AdaptedHeight(15), viewWidth, AdaptedHeight(50.0));
    self.describeButton.frame = CGRectMake(0.0, CGRectGetMaxY(self.amountLabel.frame) + AdaptedHeight(10.0), viewWidth, AdaptedHeight(20.0));
    self.amountSlider.frame = CGRectMake(AdaptedWidth(28.0), CGRectGetMaxY(self.describeButton.frame) + AdaptedHeight(25.0), viewWidth - AdaptedWidth(28.0) * 2, AdaptedHeight(10.0));
    self.minAmountLabel.frame = CGRectMake(CGRectGetMinX(self.amountSlider.frame), CGRectGetMaxY(self.amountSlider.frame) + AdaptedHeight(6.0),  200.0, AdaptedHeight(18.0));
    self.maxAmountLabel.frame = CGRectMake(CGRectGetMaxX(self.amountSlider.frame) - 200.0, CGRectGetMinY(self.minAmountLabel.frame), 200.0, CGRectGetHeight(self.minAmountLabel.frame));
    
    self.borrowDaysMenu.frame = CGRectMake(AdaptedWidth(50.0), CGRectGetMaxY(self.minAmountLabel.frame) + AdaptedHeight(12.0), viewWidth - AdaptedWidth(50.0) * 2, AdaptedHeight(30.0));
    
    self.loanButton.frame = CGRectMake(AdaptedWidth(48.0), CGRectGetMaxY(self.amountSlider.frame) + AdaptedHeight(82.0), viewWidth - AdaptedWidth(48.0) * 2, AdaptedHeight(44.0));
//    self.noLoanLabel.frame = CGRectMake(0.0, CGRectGetMaxY(self.loanButton.frame) + AdaptedHeight(12), Main_Screen_Width, AdaptedHeight(18.0));
    self.height = self.loanButton.bottom+AdaptedWidth(20);
}

#pragma mark - LSBorrowMenuViewDelegate
//  获取借款天数
- (void)borrowMenuViewSelectBorrowDays:(NSString *)borrowDays{
    self.currentSelectDay = borrowDays;
    [self amountSliderChange:self.amountSlider];
}

#pragma mark - 按钮点击事件
//  滑动借钱金额
- (void)amountSliderChange:(ZTMXFAmountSlider *)sender{
    //  滑动滑块增加的金额
    double addAmountDouble = sender.value - self.minLoanAmount;
    NSInteger addIntegerAmount = floor(addAmountDouble / kLoanSliderAddAmount) * kLoanSliderAddAmount;
    //  当前借款金额
    self.currentLoanAmount = addIntegerAmount + self.minLoanAmount;
    NSString *currentLoanAmountString = [NSDecimalNumber stringWithFloatValue:self.currentLoanAmount];
    self.amountLabel.text = currentLoanAmountString;
    //  借款手续费(借款本金 * 借款手续费利率 * 借款天数)
    NSString *loanProcedureFee = [[NSDecimalNumber calculateReturnDecimalNumberWithOpration:@"*" leftString:currentLoanAmountString rightString:self.serviceFeeRate] calculateReturnStringWithOpration:@"*" oprationString:self.currentSelectDay];
    //  实际到账金额
    NSString *arriveAmount = [NSDecimalNumber calculateReturnStringWithOpration:@"-" leftString:currentLoanAmountString rightString:loanProcedureFee];
    NSString *loanProcedureFeeString = [NSString stringWithFormat:@"%@元",loanProcedureFee];
    NSString *arriveAmountString = [NSString stringWithFormat:@"%@元", arriveAmount];
    NSString *describeString = [NSString string];
    if (_loanViewType == WhiteLoanViewType) {
        //  白领贷
        describeString = [NSString stringWithFormat:@"到账金额 %@ | 服务费 %@", arriveAmountString, loanProcedureFeeString];
    } else {
        //  消费贷
        describeString = [NSString stringWithFormat:@"服务费 %@", loanProcedureFeeString];
    }
    UIColor *redColor = [UIColor colorWithHexString:COLOR_RED_STR];
    [UIButton attributeWithBUtton:self.describeButton title:describeString titleColor:COLOR_GRAY_STR forState:UIControlStateNormal attributes:@[arriveAmountString, loanProcedureFeeString] attributeColors:@[redColor, redColor]];

}

//  借钱按钮点击事件
- (void)loanButtonAction{
    if (self.delegate && [self.delegate respondsToSelector:@selector(homePageLoanViewClickBorrowMoney:loanAmount:loanDays:)]) {
        [self.delegate homePageLoanViewClickBorrowMoney:self loanAmount:[NSDecimalNumber stringWithFloatValue:self.currentLoanAmount] loanDays:self.currentSelectDay];
    }
}

/** 服务费按钮 */
- (void)describeButtonAction{
    NSLog(@"服务费弹窗");
    if (self.loanViewType == WhiteLoanViewType) {
        //  白领贷
        NSString *poundageRateString = [NSDecimalNumber stringWithFloatValue:self.homeInfoModel.whiteStatusInfo.whitePoundageRate];
        NSString *bankRateString = [NSDecimalNumber stringWithFloatValue:self.homeInfoModel.whiteStatusInfo.bankRate];
        NSString *bankRate = [NSDecimalNumber calculateReturnStringWithOpration:@"*" leftString:bankRateString rightString:@"100"];
        NSString *poundageRate = [NSDecimalNumber calculateReturnStringWithOpration:@"*" leftString:poundageRateString rightString:@"100"];
        JBBorrowRateAlertView* viAlert = [[JBBorrowRateAlertView alloc] init];
        [viAlert updateWithProcedureRates:poundageRate dayRate:bankRate loanAlertType:WhiteLoanAlertViewType];
        [viAlert show];
    } else {
        //  消费贷
        NSString *poundageRateString = [NSDecimalNumber stringWithFloatValue:self.homeInfoModel.statusInfo.newPoundageRate];
        NSString *bankRateString = self.homeInfoModel.statusInfo.bankRate;
        NSString *bankRate = [NSDecimalNumber calculateReturnStringWithOpration:@"*" leftString:bankRateString rightString:@"100"];
        NSString *poundageRate = [NSDecimalNumber calculateReturnStringWithOpration:@"*" leftString:poundageRateString rightString:@"100"];
        JBBorrowRateAlertView* viAlert = [[JBBorrowRateAlertView alloc] init];
        [viAlert updateWithProcedureRates:poundageRate dayRate:bankRate loanAlertType:ConsumeLoanAlertViewType];
        [viAlert show];
    }
}

/** 箭头按钮点击事件 */
- (void)rowButtonAction{
    if (self.delegate && [self.delegate respondsToSelector:@selector(homePageLoanViewClickWhiteLoanTitle:loanAmount:loanDays:)]) {
        [self.delegate homePageLoanViewClickWhiteLoanTitle:self loanAmount:[NSDecimalNumber stringWithFloatValue:self.currentLoanAmount] loanDays:self.currentSelectDay];
    }
}

#pragma mark - setter getter
- (ZTMXFLeftImageLabel *)titleImageLabel{
    if (_titleImageLabel == nil) {
        _titleImageLabel = [ZTMXFLeftImageLabel leftImageLabelWithImageStr:@"" title:@"" origin:CGPointMake(0.0, 0.0)];
        _titleImageLabel.imageTitleMargin = 2.0;
        _titleImageLabel.titleFont = [UIFont boldSystemFontOfSize:16];
        _titleImageLabel.titleColor = [UIColor colorWithHexString:COLOR_GRAY_STR];
    }
    return _titleImageLabel;
}

- (UILabel *)rightTitleLabel{
    if (_rightTitleLabel == nil) {
        _rightTitleLabel = [UILabel labelWithTitleColorStr:COLOR_LIGHT_STR fontSize:14 alignment:NSTextAlignmentRight];
        _rightTitleLabel.text = @"";
    }
    return _rightTitleLabel;
}

- (UIView *)lineView{
    if (_lineView == nil) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor colorWithHexString:COLOR_BORDER_STR];
    }
    return _lineView;
}

- (UIButton *)rowButton{
    if (_rowButton == nil) {
        _rowButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rowButton setImage:[UIImage imageNamed:@"mine_right_arrow"] forState:UIControlStateNormal];
        _rowButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [_rowButton addTarget:self action:@selector(rowButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rowButton;
}

- (UILabel *)amountLabel{
    if (_amountLabel == nil) {
        _amountLabel = [UILabel labelWithTitleColorStr:COLOR_BLACK_STR fontSize:36 alignment:NSTextAlignmentCenter];
        _amountLabel.font = [UIFont boldSystemFontOfSize:36];
        _amountLabel.text = @"";
    }
    return _amountLabel;
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

- (ZTMXFAmountSlider *)amountSlider{
    if (_amountSlider == nil) {
        _amountSlider = [[ZTMXFAmountSlider alloc] init];
//        _amountSlider.maximumTrackTintColor = [UIColor colorWithHexString:COLOR_LIGHTBG_STR];
//        [_amountSlider setThumbImage:[UIImage imageNamed:@"renewal_slider_thumb"] forState:UIControlStateNormal];
//        [_amountSlider setMinimumTrackImage:[UIImage imageNamed:@"XL_slider_track"] forState:UIControlStateNormal];
        
        
        _amountSlider.minimumTrackTintColor = K_MainColor;
        _amountSlider.maximumTrackTintColor = COLOR_SRT(@"#F2F2F2");
        [_amountSlider setThumbImage:[UIImage imageNamed:@"renewal_slider_thumb"] forState:UIControlStateNormal];
    }
    return _amountSlider;
}

- (UILabel *)minAmountLabel{
    if (_minAmountLabel == nil) {
        _minAmountLabel = [UILabel labelWithTitleColorStr:COLOR_LIGHT_STR fontSize:13 alignment:NSTextAlignmentLeft];
        _minAmountLabel.text = @"";
    }
    return _minAmountLabel;
}

- (UILabel *)maxAmountLabel{
    if (_maxAmountLabel == nil) {
        _maxAmountLabel = [UILabel labelWithTitleColorStr:COLOR_LIGHT_STR fontSize:13 alignment:NSTextAlignmentRight];
        _maxAmountLabel.text = @"";
    }
    return _maxAmountLabel;
}

- (LSBorrowMenuView *)borrowDaysMenu{
    if (!_borrowDaysMenu) {
        _borrowDaysMenu = [[LSBorrowMenuView alloc] init];
        _borrowDaysMenu.frame = CGRectMake(AdaptedWidth(50.0), CGRectGetMaxY(_minAmountLabel.frame) + AdaptedHeight(12.0), Main_Screen_Width - AdaptedWidth(50.0) * 2, AdaptedHeight(30.0));
        _borrowDaysMenu.delegate = self;
    }
    return _borrowDaysMenu;
}

- (ZTMXFButton *)loanButton{
    if (_loanButton == nil) {
        _loanButton = [ZTMXFButton buttonWithType:UIButtonTypeCustom];
        [_loanButton setTitle:@"去借钱" forState:UIControlStateNormal];
    }
    return _loanButton;
}

- (ZTMXFDoubleLineLabel *)noLoanLabel{
    if (_noLoanLabel == nil) {
        _noLoanLabel = [[ZTMXFDoubleLineLabel alloc] init];
        _noLoanLabel.font = [UIFont systemFontOfSize:12];
        _noLoanLabel.textColor = [UIColor colorWithHexString:COLOR_LIGHT_GRAY_STR];
        _noLoanLabel.textAlignment = NSTextAlignmentCenter;
        _noLoanLabel.text = @"不向学生及20岁以下用户提供借款服务";
        _noLoanLabel.hidden = YES;
    }
    return _noLoanLabel;
}

#pragma mark - setter
- (void)setBorrowDaysArray:(NSArray *)borrowDaysArray{
    if (_borrowDaysArray != borrowDaysArray) {
        _borrowDaysArray = borrowDaysArray;
    }
    
    if (!kArrayIsEmpty(_borrowDaysArray)) {
        self.borrowDaysMenu.borrowDays = _borrowDaysArray;;
    }
}

- (void)setHomeInfoModel:(LSBorrowHomeInfoModel *)homeInfoModel{
    if (_homeInfoModel != homeInfoModel) {
        _homeInfoModel = homeInfoModel;
    }
    
    if (_loanViewType == ConsumeLoanViewType) {
        //  消费贷
        ConsumeLoanStatusInfo *consumeStatusInfo = self.homeInfoModel.statusInfo;
        //  借钱天数数组
        self.borrowDaysArray = [self separateString:consumeStatusInfo.borrowMoneyDays delimiter:@","];
        self.borrowDaysMenu.borrowDays = self.borrowDaysArray;
        //  设置当前借款天数
        if (self.borrowDaysArray.count > 0) {
            if (![self.borrowDaysArray containsObject:self.currentSelectDay]) {
                self.currentSelectDay = self.borrowDaysArray[0];
            } else {
                NSInteger currentIndex = [self.borrowDaysArray indexOfObject:self.currentSelectDay];
                [self.borrowDaysMenu configCurrentIndex:currentIndex animate:NO];
            }
        }
        //  服务费率
        self.serviceFeeRate = [NSDecimalNumber stringWithFloatValue:consumeStatusInfo.newPoundageRate];
        //  最小借款金额,最大借款金额
        self.minLoanAmount = consumeStatusInfo.minAmount;
        self.maxLoanAmount = consumeStatusInfo.maxAmount;
        self.amountSlider.minimumValue = self.minLoanAmount;
        self.amountSlider.maximumValue = self.maxLoanAmount;
        self.minAmountLabel.text = [NSDecimalNumber stringWithFloatValue:self.minLoanAmount];
        self.maxAmountLabel.text = [NSDecimalNumber stringWithFloatValue:self.maxLoanAmount];
        //  当前借款金额(默认显示最大)
        if (self.currentLoanAmount <= 0 || self.currentLoanAmount > self.maxLoanAmount || self.currentLoanAmount < self.minLoanAmount) {
            self.currentLoanAmount = self.maxLoanAmount;
        }
        self.amountSlider.value = self.currentLoanAmount;

        [self amountSliderChange:self.amountSlider];

    } else if (_loanViewType == WhiteLoanViewType) {
        //  白领贷
        WhiteLoanStatusInfo *whiteStatusInfo = self.homeInfoModel.whiteStatusInfo;
        if (!kStringIsEmpty(whiteStatusInfo.whiteAuthInfo)) {
            //  白领贷审核中
            self.rightTitleLabel.text = whiteStatusInfo.whiteAuthInfo;
            self.rightTitleLabel.textColor = [UIColor colorWithHexString:COLOR_RED_STR];
            self.rowButton.hidden = NO;
            self.rightTitleLabel.frame = CGRectMake(Main_Screen_Width - 200.0 - 25.0, 0.0, 200.0, AdaptedHeight(44.0));
        } else if (!kStringIsEmpty(whiteStatusInfo.whiteRiskRetrialRemind)) {
            //  白领贷认证未通过
            self.rightTitleLabel.text = whiteStatusInfo.whiteRiskRetrialRemind;
            self.rightTitleLabel.textColor = [UIColor colorWithHexString:COLOR_RED_STR];
            self.rowButton.hidden = NO;
            self.rightTitleLabel.frame = CGRectMake(Main_Screen_Width - 200.0 - 25.0, 0.0, 200.0, AdaptedHeight(44.0));
        } else {
            self.rightTitleLabel.text = @"有社保/公积金就能借款";
            self.rightTitleLabel.textColor = [UIColor colorWithHexString:COLOR_LIGHT_STR];
            self.rowButton.hidden = YES;
            self.rightTitleLabel.frame = CGRectMake(Main_Screen_Width - 200.0 - 12.0, 0.0, 200.0, AdaptedHeight(44.0));
        }
        
        //  借钱天数数组
        self.borrowDaysArray = [self separateString:whiteStatusInfo.whiteBorrowDays delimiter:@","];
        self.borrowDaysMenu.borrowDays = self.borrowDaysArray;
        //  设置当前借款天数
        if (self.borrowDaysArray.count > 0) {
            if (![self.borrowDaysArray containsObject:self.currentSelectDay]) {
                self.currentSelectDay = self.borrowDaysArray[0];
            } else {
                NSInteger currentIndex = [self.borrowDaysArray indexOfObject:self.currentSelectDay];
                [self.borrowDaysMenu configCurrentIndex:currentIndex animate:NO];
            }
        }
        //  服务费率
        self.serviceFeeRate = [NSDecimalNumber stringWithFloatValue:whiteStatusInfo.whitePoundageRate];
        //  最小借款金额,最大借款金额
        self.minLoanAmount = whiteStatusInfo.whiteMinAmount;
        self.maxLoanAmount = whiteStatusInfo.whiteMaxAmount;
        self.amountSlider.minimumValue = self.minLoanAmount;
        self.amountSlider.maximumValue = self.maxLoanAmount;
        self.minAmountLabel.text = [NSDecimalNumber stringWithFloatValue:self.minLoanAmount];
        self.maxAmountLabel.text = [NSDecimalNumber stringWithFloatValue:self.maxLoanAmount];
        //  当前借款金额
        if (self.currentLoanAmount <= 0 || self.currentLoanAmount > self.maxLoanAmount || self.currentLoanAmount < self.minLoanAmount) {
            self.currentLoanAmount = self.maxLoanAmount;
        }
        self.amountSlider.value = self.currentLoanAmount;
        
        [self amountSliderChange:self.amountSlider];
    }
    
}

- (NSArray *)separateString:(NSString *)separate delimiter:(NSString *)delimiter{
    NSMutableArray *resultArray = [NSMutableArray array];
    if (separate) {
        NSArray *separateArray = [separate componentsSeparatedByString:delimiter];
        for (NSString *separateString in separateArray) {
            if (separateString && separateString.length > 0) {
                [resultArray addObject:separateString];
            }
        }
    }
    return resultArray;
}


/** 设置title */
- (void)configLoanTitle:(NSString *)title{
    if (title) {
        self.titleImageLabel.title = title;
    }
}
/** 设置title ICON */
- (void)configLoanTitleIcon:(NSString *)titleIcon{
    if (titleIcon) {
        self.titleImageLabel.leftImageStr = titleIcon;
    }
}
/** 设置title 描述 */
- (void)configTitleDescribe:(NSString *)describe{
    if (describe) {
        self.rightTitleLabel.text = describe;
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

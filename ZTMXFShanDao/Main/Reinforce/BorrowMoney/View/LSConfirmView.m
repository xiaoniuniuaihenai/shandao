//
//  LSConfirmView.m
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2017/12/22.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "LSConfirmView.h"
#import "LSBorrwingCashInfoModel.h"
#import "PickerView.h"
#import "InstalmentAlertView.h"

@interface LSConfirmView () <PickerViewDelegete>

/** 借款类型 */
@property (nonatomic, assign) LoanType loanType;
/** 分期弹窗 */
@property (nonatomic, strong) InstalmentAlertView *insAlertView;

/** 借款用途按钮 */
@property (nonatomic, strong) UIButton *purposeBtn;

@property (nonatomic, assign) CGFloat viewBottom;

@end

@implementation LSConfirmView

- (instancetype)initWithFrame:(CGRect)frame confirmType:(LoanType)loanType
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        self.loanType = loanType;
    }
    return self;
}

#pragma mark - setter
- (void)setCashInfoModel:(LSBorrwingCashInfoModel *)cashInfoModel{
    _cashInfoModel = cashInfoModel;
    
    _viewBottom = 0;
    // 借款期限
    if (_cashInfoModel.borrowDays.length > 0) {
//        UIView *borrowDaysView = [self creatViewWithTitle:@"借款期限" andValue:[NSString stringWithFormat:@"%@天",_cashInfoModel.borrowDays] image:nil];
//        borrowDaysView.top = _viewBottom;
//        [self addSubview:borrowDaysView];
//        _viewBottom = borrowDaysView.bottom;
    }
    // 分期
    if (self.loanType == WhiteLoanType) {
        // 白领贷显示分期
        NSInteger num = [_cashInfoModel.borrowDays intValue]/30;
        UIView *periodView = [self creartButtonView:@"分期" value:[NSString stringWithFormat:@"%li期",num]];
        periodView.top = _viewBottom;
        [self addSubview:periodView];
        _viewBottom = periodView.bottom;
    }
    // 服务费
    if (_cashInfoModel.serviceAmount.length > 0) {
//        UIView *serviceAmountView = [self creatViewWithTitle:@"服务费" andValue:[NSString stringWithFormat:@"%@元",[NSDecimalNumber stringWithFloatValue:[_cashInfoModel.serviceAmount floatValue]]] image:nil];
//        serviceAmountView.top = _viewBottom;
//        [self addSubview:serviceAmountView];
//        _viewBottom = serviceAmountView.bottom;
    }
    // 购物金额
    if (self.loanType == ConsumeLoanType) {
//        // 消费贷显示购物金额
//        UIView *purchaseView = [self creatViewWithTitle:@"购物金额" andValue:[NSString stringWithFormat:@"%@元",[NSDecimalNumber stringWithFloatValue:_cashInfoModel.goodPrice]] image:nil];
//        purchaseView.top = _viewBottom;
//        [self addSubview:purchaseView];
//        _viewBottom = purchaseView.bottom;
    }
    // 到账金额
    if (_cashInfoModel.arrivalAmount.length > 0) {
        UIView *view = [self creatViewWithTitle:@"到账金额" andValue:[NSString stringWithFormat:@"%@元",_cashInfoModel.arrivalAmount] image:nil];
        view.top = _viewBottom;
        [self addSubview:view];
        _viewBottom = view.bottom;
    }
    // 借款用途
    if (self.loanType == WhiteLoanType) {
        if (_cashInfoModel.borrowApplications.count > 0) {
            NSString *purposeValue = [_cashInfoModel.borrowApplications firstObject];
            self.purposeTitle = purposeValue;
            UIView *view = [self creatViewWithTitle:@"借款用途" andValue:purposeValue image:nil];
            view.top = _viewBottom;
            [self addSubview:view];
            _viewBottom = view.bottom;
        }
    }else if (self.loanType == ConsumeLoanType){
        self.purposeTitle = @"购物";
        UIView *view = [self creatViewWithTitle:@"借款用途" andValue:@"购物" image:nil];
        view.top = _viewBottom;
        [self addSubview:view];
        _viewBottom = view.bottom;
    }
    // 到账银行
    NSString * bankId = @"";
    if ([_cashInfoModel.bankCard length]>4) {
        bankId = [_cashInfoModel.bankCard substringFromIndex:[_cashInfoModel.bankCard length]-4];
    }
    NSString * bankIdStr = [NSString stringWithFormat:@"尾号%@",bankId];
    if (_cashInfoModel.bankName.length > 0) {
        UIView *bankView = [self creatViewWithTitle:_cashInfoModel.bankName andValue:bankIdStr image:_cashInfoModel.bankIcon];
        bankView.top = _viewBottom;
        [self addSubview:bankView];
        _viewBottom = bankView.bottom;
    }
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

#pragma mark - PickerViewDelegete
- (void)choosePurposeWithTitle:(NSString *)title{
    if (title.length > 0) {
        UIView *cellView = self.purposeBtn.superview;
        UILabel *purposeLabel = [cellView viewWithTag:1000];
        purposeLabel.text = title;
        self.purposeTitle = title;
    }
}

#pragma mark - 点击分期按钮
- (void)clickPromotButton{
    // 弹出提示窗
    [self.insAlertView show];
}

#pragma mark - 点击选择借款用途
- (void)clickPurposeButton{
    //
    PickerView *pickerView = [[PickerView alloc] initWithTitleArray:_cashInfoModel.borrowApplications];
    pickerView.delegete = self;
    [pickerView show];
}

- (InstalmentAlertView *)insAlertView{
    if (!_insAlertView) {
        _insAlertView = [[InstalmentAlertView alloc] initWithInstalmentDays:self.cashInfoModel.borrowDays amountMoney:[self.cashInfoModel.amount floatValue]];
    }
    return _insAlertView;
}

- (UIView *)creatViewWithTitle:(NSString *)title andValue:(NSString *)value image:(NSString *)imageName{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, AdaptedHeight(50))];
    view.backgroundColor = [UIColor whiteColor];
    
    CGFloat left = 12.0;
    if (imageName.length > 0) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(12, 0, 25, 25)];
        [imageView sd_setImageWithURL:[NSURL URLWithString:imageName] placeholderImage:[UIImage imageNamed:@""]];
        imageView.centerY = view.height/2.;
        [view addSubview:imageView];
        left = imageView.right + 8.0;
        
        UILabel *subLabel = [UILabel labelWithTitleColor:[UIColor colorWithHexString:COLOR_LIGHT_GRAY_STR] fontSize:AdaptedWidth(11) alignment:NSTextAlignmentLeft];
        [subLabel setFrame:CGRectMake(left+AdaptedWidth(80), 0, 60, view.height)];
        subLabel.centerY = view.height/2.;
        subLabel.text = @"到账银行";
        [view addSubview:subLabel];
    }
    
    UILabel *titleLabel = [UILabel labelWithTitleColor:[UIColor colorWithHexString:COLOR_BLACK_STR] fontSize:AdaptedWidth(15) alignment:NSTextAlignmentLeft];
    [titleLabel setFrame:CGRectMake(left, 0, 80, view.height)];
    [titleLabel setText:title];
    [view addSubview:titleLabel];
    
    UILabel *valueLabel = [UILabel labelWithTitleColor:[UIColor colorWithHexString:COLOR_LIGHT_GRAY_STR] fontSize:AdaptedWidth(15) alignment:NSTextAlignmentRight];
    [valueLabel setFrame:CGRectMake(0, 0, 100, view.height)];
    [valueLabel setText:value];
    valueLabel.right = SCREEN_WIDTH - 12.0;
    [view addSubview:valueLabel];
    
    if ([title isEqualToString:@"借款用途"] && self.loanType == WhiteLoanType) {
        // 白领贷借款用途
        UIImageView *rowView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 20.0, 0.0, 8.0, view.height)];
        rowView.contentMode = UIViewContentModeCenter;
        rowView.image = [UIImage imageNamed:@"XL_common_right_arrow"];
        [view addSubview:rowView];
        
        valueLabel.right = rowView.left - 8.0;
        
        self.purposeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.purposeBtn setFrame:CGRectMake(0, 0, view.width, view.height)];
        [self.purposeBtn addTarget:self action:@selector(clickPurposeButton) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:self.purposeBtn];
        
        valueLabel.tag = 1000;
    }
    
    UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, view.height-1, SCREEN_WIDTH, 1.0)];
    [lineLabel setBackgroundColor:[UIColor colorWithHexString:COLOR_LIGHTBG_STR]];
    [view addSubview:lineLabel];
    
    return view;
}

- (UIView *)creartButtonView:(NSString *)title value:(NSString *)value{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, AdaptedHeight(50))];
    view.backgroundColor = [UIColor whiteColor];
    
    UILabel *titleLabel = [UILabel labelWithTitleColor:[UIColor colorWithHexString:COLOR_BLACK_STR] fontSize:AdaptedWidth(15) alignment:NSTextAlignmentLeft];
    [titleLabel setFrame:CGRectMake(12, 0, 80, view.height)];
    [titleLabel setText:title];
    [view addSubview:titleLabel];
    
    UIButton *promotButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [promotButton setFrame:CGRectMake(0, 0, 50, view.height)];
    promotButton.right = SCREEN_WIDTH - 12.0;
    [promotButton.titleLabel setFont:[UIFont systemFontOfSize:AdaptedWidth(15)]];
    [promotButton setTitleColor:[UIColor colorWithHexString:COLOR_LIGHT_GRAY_STR] forState:UIControlStateNormal];
    [promotButton setTitle:value forState:UIControlStateNormal];
    [promotButton setImage:[UIImage imageNamed:@"XL_brwPrompt"] forState:UIControlStateNormal];
    [promotButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -30, 0, 0)];
    [promotButton setImageEdgeInsets:UIEdgeInsetsMake(0, 33, 0, 0)];
    [promotButton addTarget:self action:@selector(clickPromotButton) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:promotButton];
    
    UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, view.height-1, SCREEN_WIDTH, 1.0)];
    [lineLabel setBackgroundColor:[UIColor colorWithHexString:COLOR_LIGHTBG_STR]];
    [view addSubview:lineLabel];
    
    return view;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.height = _viewBottom;
}

@end

//
//  LSLoanRepaymentView.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/12/15.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "LSLoanRepaymentView.h"
#import "ALATitleValueCellView.h"
#import "LSRepaymentPageInfoModel.h"
#import "CounponModel.h"
#import "UILabel+Attribute.h"
#import "ZTMXFConfirmLoanHeaderView.h"
#import "LSRepaymentCouponListApi.h"
//版本1.2
#import "ZTMXFFirstConfirmLoanView.h"
#import "LSRepaymentPageInfoApi.h"
@interface LSLoanRepaymentView ()<UITextFieldDelegate>

/** headerview */
//@property (nonatomic, strong) ZTMXFConfirmLoanHeaderView        * confirmLoanHeaderView;

@property (nonatomic, strong) ZTMXFFirstConfirmLoanView *firstConfirmView;
/** topView */
@property (nonatomic, strong) UIView        *topView;
/** 还款title */
@property (nonatomic, strong) UILabel       *repaymentTitleLabel;
/** 编辑还款金额 */
@property (nonatomic, strong) UITextField   *editAmountTextField;
/** 编辑按钮 */
@property (nonatomic, strong) UIButton      *editButton;
/** 细线 */
@property (nonatomic, strong) UIView        *lineView;
/** 应还金额和待还金额描述 */
@property (nonatomic, strong) UILabel       *repaymentDescribeLabel;

/** 优惠券view */
@property (nonatomic, strong) ALATitleValueCellView *couponView;

/** 账户余额view */
@property (nonatomic, strong) ALATitleValueCellView *balanceView;
/** 返利余额 */
@property (nonatomic, strong) UILabel  *balanceLabel;
/** 是否使用返利余额 */
@property (nonatomic, strong) UISwitch *balanceSwitch;

/** 实际支付 */
@property (nonatomic, strong) ALATitleValueCellView *needPayCellView;

/** 支付按钮 */
@property (nonatomic, strong) XLButton *payButton;


/** 使用余额支付金额 */
@property (nonatomic, copy) NSString *useBalanceAmount;
/** 实际支付金额 */
@property (nonatomic, copy) NSString *actualPayAmount;

/** 最小还款金额 */
@property (nonatomic, copy) NSString *minRepaymentAmountString;

@end

@implementation LSLoanRepaymentView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.minRepaymentAmountString = @"10";
        [self setupViews];
    }
    return self;
}

- (void)setupViews{
    
    UIView * whitheView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KW, 156 * PX)];
    whitheView.backgroundColor = [UIColor whiteColor];
    [self addSubview:whitheView];

    UIImageView *bgView = [[UIImageView alloc]initWithFrame:whitheView.bounds];
    bgView.image = [UIImage imageNamed:@"JZ_Loan_Also_Money_BG"];
    [whitheView addSubview:bgView];
    
    /* 版本1.2注
    _confirmLoanHeaderView = [[ZTMXFConfirmLoanHeaderView alloc] initWithFrame:CGRectMake(12, 16 * PY, KW - 24, 140 * PY)];
    _confirmLoanHeaderView.textLabel.text = @"应还金额(元)";
    
    [self addSubview:_confirmLoanHeaderView];
    
    [_confirmLoanHeaderView addSubview:self.editAmountTextField];
    _editAmountTextField.frame = _confirmLoanHeaderView.amountLabel.frame;
    */
//    _firstConfirmView = [[ZTMXFFirstConfirmLoanView alloc]initWithFrame:CGRectMake(0, 0, KW, 140 * PX)];
//
//    [_firstConfirmView addSubview:self.editAmountTextField];
//    _editAmountTextField.frame = _firstConfirmView.amountLabel.frame;

    
//    [self addSubview:self.topView];

//    [self addSubview:self.editButton];
//    [self addSubview:self.lineView];
//    [self addSubview:self.repaymentDescribeLabel];
    
    [whitheView addSubview:self.repaymentTitleLabel];
    [whitheView addSubview:self.editAmountTextField];
    
    UIView *bottomLine = [[UIView alloc]initWithFrame:CGRectMake(0, whitheView.height - 10, KW, 10)];
    bottomLine.backgroundColor = K_BackgroundColor;
    [whitheView addSubview:bottomLine];
    
    [self addSubview:self.couponView];
    [self addSubview:self.balanceView];
    _balanceView.frame = CGRectMake(0, whitheView.bottom + 1, KW, AdaptedHeight(50.0));
    _couponView.frame = CGRectMake(0, _balanceView.bottom + 1, KW, AdaptedHeight(50.0));
    
    [self.balanceView addSubview:self.balanceSwitch];
    [self.balanceView addSubview:self.balanceLabel];
    CGSize balanceSwitchSize = self.balanceSwitch.size;
    self.balanceSwitch.origin = CGPointMake(SCREEN_WIDTH - 12.0 - balanceSwitchSize.width, (AdaptedHeight(50.0) - balanceSwitchSize.height) / 2.0);
    self.balanceLabel.frame = CGRectMake(CGRectGetMinX(self.balanceSwitch.frame) - 200.0 - 15.0, 0.0, 200.0, AdaptedHeight(50.0));

//    [self addSubview:self.needPayCellView];
    [self addSubview:self.payButton];
    _payButton.frame = CGRectMake(20, self.height - 18 - TabBar_Addition_Height - 44 * PX, KW - 40, 44 * PX);
    
    [self.editAmountTextField addTarget:self action:@selector(editAmountTextFieldTextChange:) forControlEvents:UIControlEventAllEditingEvents];
    [self.editAmountTextField addTarget:self action:@selector(editAmountTextFieldEditingDidEnd) forControlEvents:UIControlEventEditingDidEnd];

    [self.balanceSwitch addTarget:self action:@selector(balanceSwitchAction:) forControlEvents:UIControlEventValueChanged];
    [self.payButton addTarget:self action:@selector(payButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField{
    self.selectCouponModel = nil;
    //  判断金额输入是否超出限制
    [self resetRepaymentAmount];
    //  计算金额
    [self calculatePayAmount];
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSRange rangeStr = [@"1234567890." rangeOfString:string];
    if (![string isEqualToString:@""]) {
        if (([textField.text rangeOfString:@"."].location !=NSNotFound&&[string isEqualToString:@"."])||rangeStr.location == NSNotFound) {
            return NO;
        }else
        {
            NSArray * arrComp = [textField.text componentsSeparatedByString:@"."];
            if ([arrComp count]==2) {
                if ([arrComp.lastObject length]==2) {
                    return NO;
                }
            }
        }
    }
    return YES;
}

- (void)editAmountTextFieldTextChange:(UITextField *)sender{
    //    首位为小点
    if ([_editAmountTextField.text hasPrefix:@"."]&&[_editAmountTextField.text length]>1) {
        _editAmountTextField.text = [@"0" stringByAppendingString:_editAmountTextField.text];
    }
    //    首位为零 第二位不为零 插入小数点
    //  首位为零
    if ([_editAmountTextField.text hasPrefix:@"0"]&&![_editAmountTextField.text containsString:@"."]) {
        
        _editAmountTextField.text = [NSString stringWithFormat:@"%ld",[_editAmountTextField.text integerValue]];
    }
    
    //  最大还款金额不能超过总金额
    NSString *editRepaymentAmount = self.editAmountTextField.text;
    NSComparisonResult editCompareResult = [NSDecimalNumber compareStringWithleftString:self.repaymentTotalAmount rightString:editRepaymentAmount];
    if (editCompareResult == NSOrderedAscending) {
        //  编辑金额大于还款金额
        self.editAmountTextField.text = self.repaymentTotalAmount;
    }

    //  计算金额
    [self calculatePayAmount];
}

//  获取我的页面数据
- (void)editAmountTextFieldEditingDidEnd
{
    LSRepaymentPageInfoApi *api = [[LSRepaymentPageInfoApi alloc] initWithBorrowId:self.borrowId repaymentAmount:self.currentRepaymentAmount borrowType:_loanType];
    [api requestWithSuccess:^(NSDictionary *responseDict) {
        NSLog(@"%@", responseDict);
        [SVProgressHUD dismiss];
        NSString *codeStr = [responseDict[@"code"] description];
        if ([codeStr isEqualToString:@"1000"]) {
            NSDictionary *dataDict = responseDict[@"data"];
            LSRepaymentPageInfoModel *repaymentPageInfoModel = [LSRepaymentPageInfoModel mj_objectWithKeyValues:dataDict];
            if (repaymentPageInfoModel) {
                self.selectCouponModel = repaymentPageInfoModel.userCouponInfo;
            }
        }
    } failure:^(__kindof YTKBaseRequest *request) {
        [SVProgressHUD dismiss];
    }];
}


- (void)editAmountTextFieldDidBegin:(UITextField *)textField{
    NSLog(@"开始编辑");
    [XLServerBuriedPointHelper xl_BuriedPointWithPointCode:@"hq" PointSubCode:@"input.hq_ljhk_hkje" OtherDict:nil];
}

//  如果金额小于0或者大于还款金额就是设置还款金额
- (void)resetRepaymentAmount{
    NSString *editRepaymentAmount = self.editAmountTextField.text;
    NSString *minRepaymentAmount = @"0";
    NSComparisonResult editCompareResult = [NSDecimalNumber compareStringWithleftString:self.repaymentTotalAmount rightString:editRepaymentAmount];
    if (editCompareResult == NSOrderedAscending) {
        //  编辑金额大于还款金额
        self.editAmountTextField.text = self.repaymentTotalAmount;
    }
    
    NSComparisonResult minCompareResult = [NSDecimalNumber compareStringWithleftString:minRepaymentAmount rightString:editRepaymentAmount];
    if (minCompareResult != NSOrderedAscending) {
        //  编辑金额小于或者等于0
        self.editAmountTextField.text = self.repaymentTotalAmount;
    }
}

#pragma mark - 按钮点击事件
//  点击修改金额按钮
- (void)editButtonAction{
    [self.editAmountTextField becomeFirstResponder];
}

//  点击优惠券
- (void)couponViewClick{
    if (self.delegate && [self.delegate respondsToSelector:@selector(repaymentViewClickCoupon:)]) {
        [self.delegate repaymentViewClickCoupon:self.currentRepaymentAmount];
    }
}

//  是否使用余额
- (void)balanceSwitchAction:(UISwitch *)sender{
    if (self.balanceSwitch.on) {
        _balanceLabel.textColor = K_EC5346Color;
//        _balanceSwitch.thumbTintColor = K_MainColor;
////        _balanceSwitch.tintColor = K_MainColor;
//        _balanceSwitch.onTintColor = UIColor.whiteColor;
//        _balanceSwitch.layer.borderWidth = 1;
//        _balanceSwitch.layer.borderColor = K_MainColor.CGColor;
//        _balanceSwitch.layer.cornerRadius = _balanceSwitch.height/2*1.1;
//        [_balanceSwitch setValue:UIColor.blackColor forKeyPath:@"_alwaysShowOnOffLabel.layer.borderColor"];
    }else{
        _balanceLabel.textColor = COLOR_SRT(@"999999");
//        _balanceSwitch.thumbTintColor = UIColor.whiteColor;
//        //        _balanceSwitch.tintColor = K_MainColor;
//        _balanceSwitch.onTintColor = UIColor.whiteColor;
//        _balanceSwitch.layer.borderWidth = 1;
//        _balanceSwitch.layer.borderColor = UIColor.grayColor.CGColor;
//        _balanceSwitch.layer.cornerRadius = _balanceSwitch.height/2*1.1;
    }
    //  计算支付金额
    [self calculatePayAmount];
}

//  点击支付
- (void)payButtonAction
{
//    [ZTMXFUMengHelper mqEvent:k_payback_page_pv_xf];
    //  最小还款金额
    NSString *minRepaymentAmountString = [NSString stringWithFormat:@"%@",self.repaymentTotalAmount];
    //  比较还款金额
    NSComparisonResult compareResult = [NSDecimalNumber compareStringWithleftString:self.repaymentTotalAmount rightString:self.minRepaymentAmountString];
    if (compareResult == NSOrderedDescending) {
        //  还款总金额比最低还款金额大 (还款金额要大于等于kMinRepaymentAmount)
        minRepaymentAmountString = self.minRepaymentAmountString;
    } else if (compareResult == NSOrderedSame) {
        //  还款总金额和最低金额相同   (还款金额等于kMinRepaymentAmount)
        minRepaymentAmountString = self.minRepaymentAmountString;
    } else {
        //  还款总金额比最低还款金额小 (还款金额等于还款总金额)
        minRepaymentAmountString = self.repaymentTotalAmount;
    }
    
    NSComparisonResult repaymentCompareResult = [NSDecimalNumber compareStringWithleftString:self.currentRepaymentAmount rightString:minRepaymentAmountString];
    if (repaymentCompareResult == NSOrderedAscending) {
        //  当前还款金额小于最小还款金额(弹出toast 提示)
        [kKeyWindow makeCenterToast:[NSString stringWithFormat:@"最低还款金额不能低于%@元",minRepaymentAmountString]];
        return;
    }
    
    //后台打点
    [XLServerBuriedPointHelper xl_BuriedPointWithPointCode:@"hq" PointSubCode:@"submit.hq_ljhk_fk" OtherDict:nil];
    if (self.delegate && [self.delegate respondsToSelector:@selector(repaymentViewClickPayAcutualAmount:repaymentAmount:couponId:balance:)]) {
        [self.delegate repaymentViewClickPayAcutualAmount:self.actualPayAmount repaymentAmount:self.currentRepaymentAmount couponId:self.selectCouponModel.rid balance:self.useBalanceAmount];
    }
}

/** 计算支付金额 */
- (void)calculatePayAmount{
    self.actualPayAmount = [self calculateActualPayAmount];
    [self setRepaymentButtonTitle:self.actualPayAmount];
}

/** 计算实际支付金额 */
- (NSString *)calculateActualPayAmount{
    NSString *minPayString = @"0";
    self.currentRepaymentAmount = self.editAmountTextField.text;
    
    //  1. 先减去优惠券金额
    CGFloat couponAmount = 0.0;
    if (self.selectCouponModel) {
        couponAmount = self.selectCouponModel.amount;
    }
    NSString *couponAmountStr = [NSDecimalNumber stringWithFloatValue:couponAmount];
    NSString *minusCouponAmount = [NSDecimalNumber calculateReturnStringWithOpration:@"-" leftString:self.currentRepaymentAmount rightString:couponAmountStr];
    NSComparisonResult couponCompreResult = [NSDecimalNumber compareStringWithleftString:minusCouponAmount rightString:minPayString];
    if (couponCompreResult == NSOrderedDescending) {
        //  如果是降序则还需要支付 minusCouponAmount
    } else {
        //  否则实际支付是 0
        return @"0";
    }
    
    //  2. 减去使用账户余额的金额
    CGFloat balanceAmount = 0.0;
    if (self.balanceSwitch.on) {
        balanceAmount = self.repaymentInfoModel.rebateAmount;
    }
    NSString *balanceAmountString = [NSDecimalNumber stringWithFloatValue:balanceAmount];
    NSString *minusBalanceAmount = [NSDecimalNumber calculateReturnStringWithOpration:@"-" leftString:minusCouponAmount rightString:balanceAmountString];
    NSComparisonResult balanceCompreResult = [NSDecimalNumber compareStringWithleftString:minusBalanceAmount rightString:minPayString];
    if (balanceCompreResult == NSOrderedDescending) {
        //  如果是降序则还需要支付 minusBalanceAmount
        
        //  使用余额为
        self.useBalanceAmount = balanceAmountString;
        return minusBalanceAmount;
    } else if (balanceCompreResult == NSOrderedSame) {
        //  实际支付是 0, 但是余额全部用完
        
        //  使用余额为
        self.useBalanceAmount = balanceAmountString;
        return @"0";
    } else {
        //  否则实际支付是 0, 余额用了一部分
        
        //  使用余额为
        self.useBalanceAmount = minusCouponAmount;
        
        return @"0";
    }
}

/** 设置还款按钮title */
- (void)setRepaymentButtonTitle:(NSString *)actualAmount{
    if (_currentRepaymentAmount.length == 0) {
        _currentRepaymentAmount = @"0";
    }
    NSString * payStr = [NSString stringWithFormat:@"实际支付%@元,去付款",actualAmount];
    [_payButton setTitle:payStr forState:UIControlStateNormal];

}

#pragma mark - setter
- (void)setRepaymentInfoModel:(LSRepaymentPageInfoModel *)repaymentInfoModel{
    if (_repaymentInfoModel != repaymentInfoModel) {
        _repaymentInfoModel = repaymentInfoModel;
    }

    self.payButton.enabled = YES;
    //  设置最低还款金额
    self.minRepaymentAmountString = [NSDecimalNumber stringWithFloatValue:_repaymentInfoModel.minPayAmount];
    
    /** 账户余额 */
//    NSString *balanceString = [NSDecimalNumber stringWithFloatValue:self.repaymentInfoModel.rebateAmount];
    self.balanceLabel.text = [NSString stringWithFormat:@"%.2f元",self.repaymentInfoModel.rebateAmount];
    
    //  计算金额
    [self calculatePayAmount];
}

- (void)setRepaymentTotalAmount:(NSString *)repaymentTotalAmount{
    if (_repaymentTotalAmount != repaymentTotalAmount) {
        _repaymentTotalAmount = repaymentTotalAmount;
    }
    //  设置当前还款金额
    _currentRepaymentAmount = _repaymentTotalAmount;
    _editAmountTextField.text = _currentRepaymentAmount;
    
    [self editAmountTextFieldEditingDidEnd];
    //  计算金额
    [self calculatePayAmount];
}

- (void)setSelectCouponModel:(CounponModel *)selectCouponModel{
    if (_selectCouponModel != selectCouponModel) {
        _selectCouponModel = selectCouponModel;
    }
    //  设置优惠券名称
    NSString * amountStr = [NSString stringWithFormat:@"¥%.2f", _selectCouponModel.amount];
    self.couponView.valueStr = amountStr;
    self.couponView.valueLabel.textColor = K_EC5346Color;
//    _selectCouponModel.name;
    //  计算金额
    [self calculatePayAmount];
}

#pragma mark - getter
- (UIView *)topView{
    if (_topView == nil) {
        _topView = [[UIView alloc] init];
        _topView.backgroundColor = [UIColor whiteColor];
    }
    return _topView;
}

- (UILabel *)repaymentTitleLabel{
    if (_repaymentTitleLabel == nil) {
        _repaymentTitleLabel = [UILabel labelWithTitleColorStr:@"FFFFFF" fontSize:14 alignment:NSTextAlignmentCenter];
        _repaymentTitleLabel.text = @"应还金额（元）";
        _repaymentTitleLabel.frame = CGRectMake(0, 40 * PX, KW, 20 * PX);
    }
    return _repaymentTitleLabel;
}

- (UITextField *)editAmountTextField{
    if (_editAmountTextField == nil) {
        _editAmountTextField = [[UITextField alloc] init];
        _editAmountTextField.font = [UIFont boldSystemFontOfSize:36];
        _editAmountTextField.textColor = [UIColor colorWithHexString:@"FFFFFF"];
        _editAmountTextField.keyboardType = UIKeyboardTypeDecimalPad;
        _editAmountTextField.backgroundColor = [UIColor clearColor];
        _editAmountTextField.tintColor = [UIColor colorWithHexString:COLOR_BLUE_STR];
        _editAmountTextField.delegate = self;
        _editAmountTextField.textAlignment = NSTextAlignmentCenter;
        [_editAmountTextField addTarget:self action:@selector(editAmountTextFieldDidBegin:) forControlEvents:UIControlEventEditingDidBegin];
        _editAmountTextField.frame = CGRectMake(0, 64 * PX, KW, 50 * PX);
    }
    return _editAmountTextField;
}

- (UIButton *)editButton{
    if (_editButton == nil) {
        UIColor *titleColor = [UIColor colorWithHexString:COLOR_BLUE_STR];
        _editButton = [UIButton setupButtonWithImageStr:nil title:@"修改金额" titleColor:titleColor titleFont:13 withObject:self action:@selector(editButtonAction)];
        [_editButton setTitleColor:[UIColor colorWithHexString:COLOR_BLUE_STR] forState:UIControlStateNormal];
        [_editButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    }
    return _editButton;
}

- (UIView *)lineView{
    if (_lineView == nil) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor colorWithHexString:COLOR_BORDER_STR];
    }
    return _lineView;
}

- (UILabel *)repaymentDescribeLabel{
    if (_repaymentDescribeLabel == nil) {
        _repaymentDescribeLabel = [UILabel labelWithTitleColorStr:COLOR_GRAY_STR titleFont:AdaptedFontSize(14) alignment:NSTextAlignmentLeft];
    }
    return _repaymentDescribeLabel;
}

/** 优惠券 */
- (ALATitleValueCellView *)couponView{
    if (_couponView == nil) {
        _couponView = [[ALATitleValueCellView alloc] initWithTitle:@"优惠券" value:@"暂无可用" target:self action:@selector(couponViewClick)];
        _couponView.showRowImageView = YES;
        _couponView.showBottomLineView = YES;
        _couponView.backgroundColor = [UIColor whiteColor];
    }
    return _couponView;
}

/** 账户余额 */
- (ALATitleValueCellView *)balanceView{
    if (_balanceView == nil) {
         _balanceView = [[ALATitleValueCellView alloc] initWithTitle:@"账户余额" value:@"" target:self action:nil];
        _balanceView.showRowImageView = NO;
        _balanceView.showBottomLineView = NO;
        _balanceView.backgroundColor = [UIColor whiteColor];
    }
    return _balanceView;
}

- (UISwitch *)balanceSwitch{
    if (_balanceSwitch == nil) {
        _balanceSwitch = [[UISwitch alloc] init];
//        _balanceSwitch.onTintColor = K_MainColor;
        _balanceSwitch.transform = CGAffineTransformMakeScale(.7f, .7f);//缩放
    }
    return _balanceSwitch;
}

- (UILabel *)balanceLabel{
    if (_balanceLabel == nil) {
        _balanceLabel = [UILabel labelWithTitleColorStr:COLOR_LIGHT_STR fontSize:14 alignment:NSTextAlignmentRight];
    }
    return _balanceLabel;
}

/** 实际支付 */
- (ALATitleValueCellView *)needPayCellView{
    if (_needPayCellView == nil) {
        _needPayCellView = [[ALATitleValueCellView alloc] initWithTitle:@"实际支付" value:@"0.00" target:self action:nil];
        _needPayCellView.showRowImageView = NO;
        _needPayCellView.showBottomLineView = NO;
        _needPayCellView.backgroundColor = [UIColor whiteColor];
    }
    return _needPayCellView;
}

- (XLButton *)payButton{
    if (_payButton == nil) {
        _payButton = [XLButton buttonWithType:UIButtonTypeCustom];
        [_payButton setTitle:@"立即支付" forState:UIControlStateNormal];
        [_payButton setTitleColor:K_BtnTitleColor forState:UIControlStateNormal];
//        _payButton.enabled = NO;
    }
    return _payButton;
}


/** 还款页面是否可编辑 */
- (void)configRepaymentViewEdit:(BOOL)edit{
    if (edit) {
        self.editAmountTextField.userInteractionEnabled = YES;
        self.editButton.hidden = NO;
    } else {
        self.editAmountTextField.userInteractionEnabled = NO;
        self.editButton.hidden = YES;
    }
}

/** 借款类型 */
- (void)setLoanType:(LoanType)loanType{
    _loanType = loanType;
    
    if (_loanType == MallLoanType) {
        //  消费分期还款不支持优惠券和余额
        self.couponView.hidden = YES;;
        self.balanceView.hidden = YES;
        self.needPayCellView.hidden = YES;
        
        [self setNeedsLayout];
        [self layoutIfNeeded];
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

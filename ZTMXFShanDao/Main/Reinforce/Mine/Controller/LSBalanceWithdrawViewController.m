//
//  LSBalanceWithdrawViewController.m
//  YWLTMeiQiiOS
//
//  Created by yangpenghua on 2017/9/23.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "LSBalanceWithdrawViewController.h"
#import "ALABankCardInfoView.h"
#import "UITextField+Addition.h"
#import "BalanceWithdrawApi.h"
#import "BalanceWithdrawPageInfoApi.h"
#import "PasswordPopupView.h"
#import "RealNameManager.h"
#import "UILabel+Attribute.h"
#import "ZTMXFConfirmLoanHeaderView.h"

#define minWithdrawAmount 50   //  最小提现余额
#define myDotNumbers     @"0123456789.\n"
#define myNumbers          @"0123456789\n"
@interface LSBalanceWithdrawViewController ()<UITextFieldDelegate, PasswordPopupViewDelegate>

/** 借款金额 */
@property (nonatomic, strong) UITextField   *borrowAmountTextField;

@property (nonatomic, strong) ZTMXFConfirmLoanHeaderView   * confirmLoanHeaderView;


/** 提现金额 */
@property (nonatomic, strong) UILabel       *withdrawAmountLabel;

/** 银行卡背景view */
@property (nonatomic, strong) UIView        *bankCardView;
@property (nonatomic, strong) UIImageView   *bankIconImageView;
@property (nonatomic, strong) UILabel       *bankNameLabel;
@property (nonatomic, strong) UILabel       *bankTailLabel;

/** 确定按钮 */
@property (nonatomic, strong) XLButton      *confirmButton;
/** 最多可借金额 */
@property (nonatomic, assign) CGFloat       maxBorrowMoney;
/** 最小提现金额 */
@property (nonatomic, assign) CGFloat       minWithDraw;
/** 全部提现 */
@property (nonatomic, strong) UIButton       *allBtn;



@end

@implementation LSBalanceWithdrawViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"余额提现";
    self.view.backgroundColor = K_LineColor;
    
    UIView * whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, k_Navigation_Bar_Height, KW, 300)];
    whiteView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:whiteView];
    
    self.confirmLoanHeaderView = [[ZTMXFConfirmLoanHeaderView alloc] initWithFrame:CGRectMake(12, 16 * PY, KW - 24, 140 * PX)];
    _confirmLoanHeaderView.textLabel.text = @"提现金额(元)";
    NSString * costStr = [NSString stringWithFormat:@"%@元", _rebateAmount];
    NSString * serviceAmountStr = [NSString stringWithFormat:@"可提现金额%@元, 全部提现", _rebateAmount];
    _confirmLoanHeaderView.costLabel.userInteractionEnabled = YES;
    [UILabel attributeWithLabel:_confirmLoanHeaderView.costLabel text:serviceAmountStr textColor:@"#666666" attributes:@[costStr,@"全部提现"] attributeColors:@[K_MainColor, K_MainColor]];
    [whiteView addSubview:_confirmLoanHeaderView];
    _confirmLoanHeaderView.costLabel.sd_layout
    .centerXEqualToView(_confirmLoanHeaderView)
    .bottomEqualToView(_confirmLoanHeaderView)
    .heightIs(42 * PY);
//    [_confirmLoanHeaderView sd_resetNewLayout];
//    _confirmLoanHeaderView.costLabel.backgroundColor = DEBUG_COLOR;
//    [_confirmLoanHeaderView.costLabel setSingleLineAutoResizeWithMaxWidth:KW - 24];
//
//    _allBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    _allBtn.sd_layout
//    .leftSpaceToView(_confirmLoanHeaderView.costLabel, 0.1)
//    .topEqualToView(_confirmLoanHeaderView.costLabel)
    
    UITapGestureRecognizer * tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pgy_tapGRAction:)];
    [_confirmLoanHeaderView.costLabel addGestureRecognizer:tapGR];
    
    
    
    UILabel *reminder = [UILabel labelWithTitleColorStr:COLOR_LIGHT_STR fontSize:14 alignment:NSTextAlignmentLeft];
    reminder.text = @"只支持打款至该卡,如需更改,请联系客服";
    reminder.frame = CGRectMake(12, _confirmLoanHeaderView.bottom + 30 * PX, SCREEN_WIDTH , 40.0);
    [whiteView addSubview:reminder];
    
    
    UILabel *bankCardDescribe = [UILabel labelWithTitleColorStr:@"000000" fontSize:18 alignment:NSTextAlignmentLeft];
    bankCardDescribe.text = @"到账银行";
    bankCardDescribe.frame = CGRectMake(reminder.left, reminder.bottom, 100, 45.0);
    [whiteView addSubview:bankCardDescribe];
    
    self.bankTailLabel = [UILabel labelWithTitleColorStr:@"000000" fontSize:18 alignment:NSTextAlignmentRight];
    self.bankTailLabel.frame = CGRectMake(Main_Screen_Width - 100.0 - 12, bankCardDescribe.top, 100.0, bankCardDescribe.height);
    [whiteView addSubview:self.bankTailLabel];
    
    self.bankIconImageView = [UIImageView setupImageViewWithImageName:@"" withSuperView:self.bankCardView];
    self.bankIconImageView.frame = CGRectMake(KW - 102 - 30, _bankTailLabel.top, 30, 30);
    [whiteView addSubview:self.bankIconImageView];
    whiteView.height = _bankIconImageView.bottom + 15;
    _bankIconImageView.centerY = _bankTailLabel.centerY;
   
    
    /** 借款金额输入框 */
    self.borrowAmountTextField = [UITextField textfieldWidthPlaceHolder:@"" placeHolderColorStr:COLOR_LIGHT_STR textColor:@"EC5346" textSize:30 leftMargin:5.0];
    self.borrowAmountTextField.frame = CGRectMake(20, _confirmLoanHeaderView.textLabel.bottom + 5, _confirmLoanHeaderView.width - 40, 40);
    _borrowAmountTextField.adjustsFontSizeToFitWidth = YES;
    _borrowAmountTextField.minimumFontSize = 20;
    _borrowAmountTextField.text = @"0";
    _borrowAmountTextField.backgroundColor = DEBUG_COLOR;
    _borrowAmountTextField.textAlignment = NSTextAlignmentCenter;
    self.borrowAmountTextField.backgroundColor = [UIColor whiteColor];
    self.borrowAmountTextField.keyboardType = UIKeyboardTypeDecimalPad;
    [_borrowAmountTextField addTarget:self action:@selector(pgy_borrowAmountTextFieldChange) forControlEvents:UIControlEventEditingChanged];
//    [_borrowAmountTextField addTarget:self action:@selector(borrowAmountTextFieldChange) forControlEvents:UIControlEventEditingDidEnd];

    self.borrowAmountTextField.delegate = self;
    [self.borrowAmountTextField becomeFirstResponder];
    [_confirmLoanHeaderView addSubview:_borrowAmountTextField];
//    confirmButtonAction
    _confirmButton = [XLButton buttonWithType:UIButtonTypeCustom];
    _confirmButton.frame = CGRectMake(20, KH - TabBar_Addition_Height -20 - 44 * PX, KW - 40,  44 * PX);
    [_confirmButton setTitle:@"立即提现" forState:UIControlStateNormal];
    [_confirmButton addTarget:self action:@selector(confirmButtonAction) forControlEvents:UIControlEventTouchUpInside];
    _confirmButton.alpha = 0.5;
    _confirmButton.userInteractionEnabled = NO;
    [self.view addSubview:_confirmButton];

    [self requestBanlanceWtihdrawPageInfoApi];
}

- (void)pgy_tapGRAction:(UITapGestureRecognizer * )tap
{
    _borrowAmountTextField.text = _rebateAmount;
    [self pgy_borrowAmountTextFieldChange];
    [self.view endEditing:YES];
}

- (void)pgy_borrowAmountTextFieldChange
{
    if ([self.borrowAmountTextField.text floatValue] > [self.rebateAmount floatValue]) {
        _borrowAmountTextField.text = self.rebateAmount;
    }
    if (self.borrowAmountTextField.text.length < 1 | [self.borrowAmountTextField.text floatValue] <=0) {
        _confirmButton.alpha = 0.5;
        _confirmButton.userInteractionEnabled = NO;
    }else{
        _confirmButton.alpha = 1;
        _confirmButton.userInteractionEnabled = YES;
    }
}



- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)      string {
    
    // 判断是否输入内容，或者用户点击的是键盘的删除按钮
    if (![string isEqualToString:@""]) {
        NSCharacterSet *cs;
        // 小数点在字符串中的位置 第一个数字从0位置开始
        
        NSInteger dotLocation = [textField.text rangeOfString:@"."].location;
        
        // 判断字符串中是否有小数点，并且小数点不在第一位
        
        // NSNotFound 表示请求操作的某个内容或者item没有发现，或者不存在
        
        // range.location 表示的是当前输入的内容在整个字符串中的位置，位置编号从0开始
        
        if (dotLocation == NSNotFound && range.location != 0) {
            
            // 取只包含“myDotNumbers”中包含的内容，其余内容都被去掉
            
            /* [NSCharacterSet characterSetWithCharactersInString:myDotNumbers]的作用是去掉"myDotNumbers"中包含的所有内容，只要字符串中有内容与"myDotNumbers"中的部分内容相同都会被舍去在上述方法的末尾加上invertedSet就会使作用颠倒，只取与“myDotNumbers”中内容相同的字符
             */
            cs = [[NSCharacterSet characterSetWithCharactersInString:myDotNumbers] invertedSet];
            if (range.location >= 9) {
                NSLog(@"单笔金额不能超过亿位");
                if ([string isEqualToString:@"."] && range.location == 9) {
                    return YES;
                }
                return NO;
            }
        }else {
            
            cs = [[NSCharacterSet characterSetWithCharactersInString:myNumbers] invertedSet];
            
        }
        // 按cs分离出数组,数组按@""分离出字符串
        
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        
        BOOL basicTest = [string isEqualToString:filtered];
        
        if (!basicTest) {
            
            NSLog(@"只能输入数字和小数点");
            
            return NO;
            
        }
        
        if (dotLocation != NSNotFound && range.location > dotLocation + 2) {
            
            NSLog(@"小数点后最多两位");
            
            return NO;
        }
        if (textField.text.length > 11) {
            
            return NO;
            
        }
    }
    return YES;
}




#pragma mark - Event Response
//  确定借款
- (void)confirmButtonAction{
    //  余额提现
    if (self.borrowAmountTextField.text.length < 1) {
        [self.view makeCenterToast:@"请填写提现金额"];
        return;
    }
    CGFloat moneyAmount = [self.borrowAmountTextField.text floatValue];
    if (moneyAmount <= 0.0) {
        [self.view makeCenterToast:@"请填写金额数字"];
        return;
    }
    
    if ([self.borrowAmountTextField.text floatValue] > 0 && [self.borrowAmountTextField.text floatValue] < self.minWithDraw) {
        NSString *withdrawAmountStr = [NSString stringWithFormat:@"提现金额不能小于%.2f元",self.minWithDraw];
        [self.view makeCenterToast:withdrawAmountStr];
        return;
    }
    if ([self.borrowAmountTextField.text floatValue] > [self.rebateAmount floatValue]) {
        NSString *maxBorrowStr = [NSString stringWithFormat:@"最多可提现%@元", self.rebateAmount];
        [self.view makeCenterToast:maxBorrowStr];
        return;
    }
    
    //  弹出密码框
    PasswordPopupView *passwordPopupView = [PasswordPopupView popupPasswordBoxView];
    passwordPopupView.delegate = self;
}
//-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
//    NSRange rangeStr = [@"1234567890." rangeOfString:string];
//    if (![string isEqualToString:@""]) {
//        if (([textField.text rangeOfString:@"."].location !=NSNotFound&&[string isEqualToString:@"."])||rangeStr.location == NSNotFound) {
//            return NO;
//        }else if([textField.text hasPrefix:@"0"]&&[textField.text length]==1&&![string isEqualToString:@"."]){
//            return NO;
//        }else
//        {
//            NSArray * arrComp = [textField.text componentsSeparatedByString:@"."];
//            if ([arrComp count]==2) {
//                if ([arrComp.lastObject length]==2) {
//                    return NO;
//                }
//            }
//        }
//    }
//    return YES;
//}

-(void)tryTextFieldChangeDid{
    if ([_borrowAmountTextField.text hasPrefix:@"."]&&[_borrowAmountTextField.text length]>1) {
        _borrowAmountTextField.text = [@"0"stringByAppendingString:_borrowAmountTextField.text];
    }
}

#pragma mark - 密码框代理方法
- (void)passwordPopupViewEnterPassword:(NSString *)password{
    //  提现
    [self requestBanlanceWtihdrawApiWithAmount:self.borrowAmountTextField.text password:password];
}

- (void)passwordPopupViewForgetPassword{
    [RealNameManager realNameWithCurrentVc:self andRealNameProgress:RealNameProgressSetPayPaw isSaveBackVcName:YES];
}

#pragma mark - 接口请求
//  获取提现页面数据
- (void)requestBanlanceWtihdrawPageInfoApi{
    BalanceWithdrawPageInfoApi *api = [[BalanceWithdrawPageInfoApi alloc] init];
    [SVProgressHUD showLoadingWithOutMask];
    [api requestWithSuccess:^(NSDictionary *responseDict) {
        NSLog(@"%@", responseDict);
        [SVProgressHUD dismiss];
        NSString *codeStr = [responseDict[@"code"] description];
        if ([codeStr isEqualToString:@"1000"]) {
            NSDictionary *dataDict = responseDict[@"data"];
            self.minWithDraw = [dataDict[@"minAmount"] floatValue];
            [self setupViewDataWithDict:dataDict];
        }
    } failure:^(__kindof YTKBaseRequest *request) {
        [SVProgressHUD dismiss];
    }];
}

//  余额提现
- (void)requestBanlanceWtihdrawApiWithAmount:(NSString *)amount password:(NSString *)password{
    BalanceWithdrawApi *api = [[BalanceWithdrawApi alloc] initWithAmount:amount password:password];
    [SVProgressHUD showLoading];
    [api requestWithSuccess:^(NSDictionary *responseDict) {
        NSLog(@"%@", responseDict);
        [SVProgressHUD dismiss];
        NSString *codeStr = [responseDict[@"code"] description];
        if ([codeStr isEqualToString:@"1000"]) {
            [kKeyWindow makeCenterToast:@"提现成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }
    } failure:^(__kindof YTKBaseRequest *request) {
        [SVProgressHUD dismiss];
    }];
}

#pragma mark - 设置页面数据
- (void)setupViewDataWithDict:(NSDictionary *)dataDict{
    //银行卡ID
//    self.confirmButton.userInteractionEnabled = YES;
    self.maxBorrowMoney = [dataDict[@"usableAmount"] floatValue];
    self.withdrawAmountLabel.text = [NSString stringWithFormat:@"可提现金额%@元",self.rebateAmount];
    NSDictionary *bankCardDict = [self manageData:dataDict];
    [self.bankIconImageView sd_setImageWithURL:[NSURL URLWithString:bankCardDict[kFanBeiBankCardIconUrl]]];
    self.bankNameLabel.text = bankCardDict[kFanBeiBankCardInfoName];
    self.bankTailLabel.text = bankCardDict[kFanBeiBankCardInfoTailNumber];
}

- (NSDictionary *)manageData:(NSDictionary *)originData{
    
    NSMutableDictionary *resultData = [NSMutableDictionary dictionary];
    [resultData setValue:originData[@"bankName"] forKey:kFanBeiBankCardInfoName];
    NSString *bankCard = [originData[@"bankCard"] description];
    NSInteger fromIndex = bankCard.length - 4;
    NSString *tailBankCard = [NSString string];
    if (fromIndex > 0) {
        tailBankCard = [bankCard substringFromIndex:fromIndex];
    }
    [resultData setValue:[NSString stringWithFormat:@"尾号%@",tailBankCard] forKey:kFanBeiBankCardInfoTailNumber];
    [resultData setValue:originData[@"bankIcon"] forKey:kFanBeiBankCardIconUrl];
    return resultData;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

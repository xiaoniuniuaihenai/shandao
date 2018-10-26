//
//  LSLoanRepayViewController.m
//  YWLTMeiQiiOS
//
//  Created by yangpenghua on 2017/9/25.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "LSLoanRepayViewController.h"
#import "ALATitleValueCellView.h"
#import "CounponModel.h"
#import "PayTypePopupView.h"
#import "LSMyCouponListViewController.h"
#import "PayChannelModel.h"
#import "LSRepaymentPageInfoApi.h"
#import "LSRepaymentPageInfoModel.h"
#import "PasswordPopupView.h"
#import "PayManager.h"
#import <YPCashierPay/YPCashierPay.h>
#import "LSPaySuccessViewController.h"
#import "LSPayFailureViewController.h"
#import "NSString+DictionaryValue.h"
#import "ALAIntroduction.h"
#import "NSString+verify.h"
#import "BankCardModel.h"
#import "RealNameManager.h"
#import "LSLoanRepaymentView.h"
#import "LSLocationManager.h"
#import "LSIdfBindCardViewController.h"
#import "ZTMXFChooseBankViewController.h"
#import "ZTMXFPayPWDViewController.h"
#import "ZTMXFSecurityPayViewController.h"


#import "ZTMXFPayManager.h"
@interface LSLoanRepayViewController ()<CouponListViewDelegate, PayManagerDelegate, LoanRepaymentViewDelegate, ZTMXFChooseBankViewControllerDelegate, ZTMXFPayPWDViewControllerDelegate, ZTMXFSecurityPayViewControllerDelegate>

/** 还款页面 */
@property (nonatomic, strong) LSLoanRepaymentView *loanRepaymentView;
/** 实际支付金额 */
@property (nonatomic, copy) NSString *actualAmount;
/** 余额支付金额 */
@property (nonatomic, copy) NSString *balanceAmount;

/** 定位数据 */
@property (nonatomic, copy) NSString *latitudeString;
@property (nonatomic, copy) NSString *longitudeString;

@property (nonatomic, strong)NSMutableDictionary * payDataDict;



@end

@implementation LSLoanRepayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"立即还款";
    [self configueSubViews];
    //V1.3.4新增埋点
    [ZTMXFUMengHelper mqEvent:k_payback_page_pv_xf];
    //  获取还款页面数据
    [self requestRepaymentPageInfoApi];
    //  进入页面统计埋点
    [self enterRepaymentPageStatistics];
    
    //  设置定位
    LSLoanRepayViewController * __weak weakSelf = self;
    if (![LoginManager appReviewState]){
        if([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied) {
            //            NSLog(@"没打开");
        }else{
            [[LSLocationManager shareLocationManager] locationSuccessWithComplish:^(AMapLocationReGeocode *locationGeocode, NSString *latitudeString, NSString *longitudeString) {
                weakSelf.latitudeString = latitudeString;
                weakSelf.longitudeString = longitudeString;
            }];
        }
    }
}

- (void)clickReturnBackEvent{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"" message:nil preferredStyle:UIAlertControllerStyleAlert];
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc] initWithString:@"\n\n及时还款有助于您积累良好的信用并提升额度哦!\n\n"];
    [AttributedStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:X(16)] range:NSMakeRange(0, [[AttributedStr string] length])];
    [AttributedStr addAttribute:NSForegroundColorAttributeName value:COLOR_SRT(@"3E3E3E") range:NSMakeRange(0, [[AttributedStr string] length])];
    [alertVC setValue:AttributedStr forKey:@"attributedTitle"];
    
    UIAlertAction * action1 = [UIAlertAction actionWithTitle:@"还款遇到问题" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        LSWebViewController *webVC = [[LSWebViewController alloc] init];
        webVC.webUrlStr = DefineUrlString(serviceCenter_que_three);
        [self.navigationController pushViewController:webVC animated:YES];
    }];
    UIAlertAction * action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    [alertVC addAction:action1];
    [action1 setValue:COLOR_SRT(@"2B91F0") forKey:@"titleTextColor"];
    
    [alertVC addAction:action2];
    [action2 setValue:K_666666 forKey:@"titleTextColor"];
    [self presentViewController:alertVC animated:YES completion:nil];
}

- (NSMutableDictionary *)payDataDict
{
    if (!_payDataDict) {
        _payDataDict = [NSMutableDictionary dictionary];
    }
    return _payDataDict;
}
#pragma ZTMXFPayPWDViewControllerDelegate Method

/** 点击忘记密码 */
- (void)clickForgetButton
{
    //后台打点
    [XLServerBuriedPointHelper xl_BuriedPointWithPointCode:@"hq" PointSubCode:@"click.hq_ljhk_fk_wjmm" OtherDict:nil];

    [RealNameManager realNameWithCurrentVc:self andRealNameProgress:RealNameProgressSetPayPaw isSaveBackVcName:YES];
}
/** 密码输入完成 */
- (void)passwordPopupViewEnterPassword:(NSString *)password
{
    [self.payDataDict setObject:password forKey:@"payPwd"];
    if (self.loanType == MallLoanType) {
        [ZTMXFPayManager goodsBillRepayParameters:self.payDataDict success:^(id responseObject) {
            [self paySuccessResult:responseObject];
        } failure:^(id failureObject) {
            [self payFailureResult:failureObject];
        }];
    }else{
        [ZTMXFPayManager postJSONWithParameters:self.payDataDict success:^(id responseObject) {
            [self paySuccessResult:responseObject];
        } failure:^(id failureObject) {
            [self payFailureResult:failureObject];
        }];
    }
}


- (void)chooseUseBankCardId:(NSString *)bankCardId bankInfoDic:(NSDictionary *)bankInfoDic
{
    ZTMXFSecurityPayViewController * securityPayVC = [[ZTMXFSecurityPayViewController alloc] init];
    securityPayVC.delegate = self;
    //    securityPayVC.paramDict = _payDataDict;
    securityPayVC.bankInfoDic = bankInfoDic;
    securityPayVC.bankCardId = bankCardId;
    [self.navigationController pushViewController:securityPayVC animated:YES];
}

- (void)signCompleteBankCardId:(NSString *)bankCardId
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self chooseUseBankCardId:bankCardId];
    });
    
}


//** 选择使用的银行卡id   -6 -4支付宝线下  >0 银行卡支付   -111  添加银行卡  */
- (void)chooseUseBankCardId:(NSString *)bankCardId
{
    NSInteger bankId = [bankCardId integerValue];
    if (bankId == -4 || bankId == -6) {
        [self goAlipay];
    }else if(bankId == -111){
        [self goBindingBankCard];
    }else if(bankId > 0){
        [self.payDataDict setObject:bankCardId forKey:@"cardId"];
        ZTMXFPayPWDViewController * payPWDVC = [[ZTMXFPayPWDViewController alloc] init];
        payPWDVC.delegate = self;
        payPWDVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        [self presentViewController:payPWDVC animated:NO completion:^{
            payPWDVC.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        }];
    }else if(bankId == -5){
        LSWebViewController *webVC = [[LSWebViewController alloc] init];
        webVC.webUrlStr = DefineUrlString(otherPayType);
        [self.navigationController pushViewController:webVC animated:YES];
    }
    
}

- (void)pushChooseVC
{
    
    ZTMXFChooseBankViewController * chooseBankVC = [[ZTMXFChooseBankViewController alloc] init];
    chooseBankVC.delegate = self;
    chooseBankVC.showOfflinePay = YES;
    chooseBankVC.amountStr = self.actualAmount;
    chooseBankVC.borrowId = self.borrowId;
    chooseBankVC.bizCode = @"REPAYMENTCASH";
    chooseBankVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    [self presentViewController:chooseBankVC animated:NO completion:^{
        chooseBankVC.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    }];
}

#pragma mark - LoanRepaymentViewDelegate还款页面代理方法
/** 点击优惠券 */
- (void)repaymentViewClickCoupon:(NSString *)repaymentAmount{
    LSMyCouponListViewController *couponVC = [[LSMyCouponListViewController alloc] init];
    couponVC.borrowId = self.borrowId;
    couponVC.repaymentAmount = repaymentAmount;
    couponVC.couponType = RepaymentCouponListType;
    couponVC.delegate = self;
    [self.navigationController pushViewController:couponVC animated:YES];
}

/** 点击去付款 */
- (void)repaymentViewClickPayAcutualAmount:(NSString *)actualAmount repaymentAmount:(NSString *)repaymentAmount couponId:(NSString *)couponId balance:(NSString *)balance{
    self.payDataDict = nil;
    [ZTMXFUMengHelper mqEvent:k_Payback_confirm_click_xf];
    self.actualAmount = actualAmount;
    self.balanceAmount = balance;
    
    NSComparisonResult compareResult = [NSDecimalNumber compareStringWithleftString:actualAmount rightString:@"0"];
    NSString *loanTypeString = [NSString string];
    if (_loanType == CashLoanType) {
        loanTypeString = [NSString stringWithFormat:@"1000"];
    } else {
        loanTypeString = [NSString stringWithFormat:@"1001"];
    }
    
    if (compareResult == NSOrderedDescending) {
        //  选择支付方式
        if (self.loanType == MallLoanType) {
            //  消费分期支付
            self.payDataDict = [ZTMXFPayManager setMallLoanRepaymentParamsWithRepaymentAmount:repaymentAmount billIds:self.borrowId latitude:self.latitudeString longitude:self.longitudeString];
            [self pushChooseVC];
            
        } else {
            //
            self.payDataDict = [ZTMXFPayManager setLoanRepaymentParamsWithBorrowId:self.borrowId acutalAmount:actualAmount repaymentAmount:repaymentAmount couponId:couponId rebateAmount:balance loanType:loanTypeString];
            [self pushChooseVC];
            
        }
    } else {
        //  余额支付
        NSMutableDictionary *payDataDict = [PayManager setLoanRepaymentParamsWithBorrowId:self.borrowId acutalAmount:actualAmount repaymentAmount:repaymentAmount couponId:couponId rebateAmount:balance cardId:@"-2" loanType:loanTypeString];
        [PayManager payManagerWithPayType:LoanRepaymentPayType payModel:PayByPasswordMode payDataDict:payDataDict delegate:self];
    }
    
}

#pragma mark - 优惠券页面选中优惠券
- (void)couponListViewSelectCoupon:(CounponModel *)couponModel{
    if (couponModel) {
        self.loanRepaymentView.selectCouponModel = couponModel;
    }
}

#pragma mark - PayManagerDelegate
- (void)payManagerDidPaySuccess:(NSDictionary *)successInfo{
    NSLog(@"支付成功");
    //  还款成功统计
    [self successRepaymentStatistics];
    
    [self paySuccessResult:successInfo];
}

//  支付成功之后的跳转
- (void)paySuccessResult:(NSDictionary *)resultDict{
    //后台打点
    [XLServerBuriedPointHelper xl_BuriedPointWithPointCode:@"hq" PointSubCode:@"input.hq_ljhk_fk_zfmm" OtherDict:[@{@"successfulRepayment":@"成功",@"paymentPassword":@(YES)} mutableCopy]];
    NSDictionary *dataDict = resultDict[@"data"];
    NSString *submitName = [dataDict[@"submitName"] description];
    NSString *submitDesc = [dataDict[@"submitDesc"] description];
    NSString *finishName = [dataDict[@"finishName"] description];
    NSString *finishDesc = [dataDict[@"finishDesc"] description];
    LSPaySuccessViewController *successVC = [[LSPaySuccessViewController alloc] init];
    successVC.submitName = submitName;
    successVC.submitDesc = submitDesc;
    successVC.finishName = finishName;
    successVC.finishDesc = finishDesc;
    successVC.successResultType = PaySuccessResultRepaymentType;
    [self.navigationController pushViewController:successVC animated:YES];
}

- (void)payManagerDidPayFail:(NSDictionary *)failInfo{
    NSLog(@"支付失败");
    [self payFailureResult:failInfo];
    NSString *errorInfo = [failInfo[@"msg"] description];
    //  还款失败还款
    [self failureRepaymentStatistics:errorInfo];
    
}

//  支付成功之后的跳转
- (void)payFailureResult:(NSDictionary *)resultDict{
    NSString *codeStr = [resultDict[@"code"] description];
    NSString *msgJson = resultDict[@"msg"];
    
    //后台打点
    [XLServerBuriedPointHelper xl_BuriedPointWithPointCode:@"hq" PointSubCode:@"input.hq_ljhk_fk_zfmm" OtherDict:[@{@"successfulRepayment":msgJson?:@"",@"paymentPassword":@([codeStr isEqualToString:@"1120"]?NO:YES)} mutableCopy]];
    NSString *payName = [NSString string];
    NSString *payDesc = [NSString string];
    if (!kStringIsEmpty(msgJson)) {
        NSDictionary *msgDict = [msgJson dictionaryValue];
        if (msgDict[@"payName"]) {
            payName = msgDict[@"payName"];
        }
        if (msgDict[@"payDesc"]) {
            payDesc = msgDict[@"payDesc"];
        }
    }
    NSString * rBtnStr = @"";
    NSString * lBtnStr = @"";
    if ([codeStr isEqualToString:@"6001"]) {
        rBtnStr = @"拨打电话";
        lBtnStr = @"我知道了";
        //  未开通银联无卡支付功能
        
    } else if ([codeStr isEqualToString:@"6002"]) {
        rBtnStr = @"支付宝还款";
        lBtnStr = @"添加新卡";
        //  银行卡余额不足
       
    } else if ([codeStr isEqualToString:@"6003"]) {
        rBtnStr = @"支付宝还款";
        lBtnStr = @"添加新卡";
        //  银行卡次数超限
       
    } else if ([codeStr isEqualToString:@"6004"]) {
        //  交易金额超限
        rBtnStr = @"支付宝还款";
        lBtnStr = @"添加新卡";
    }else if ([codeStr isEqualToString:@"6005"]) {
        rBtnStr = @"支付宝还款";
        lBtnStr = @"添加新卡";
    }
    if (lBtnStr.length > 0) {
        payDesc = [NSString stringWithFormat:@"\n\n%@\n\n", payDesc];
        
        
        MJWeakSelf
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"" message:payDesc preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * action1 = [UIAlertAction actionWithTitle:lBtnStr style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [weakSelf showWithTitle:lBtnStr];
            
        }];
        UIAlertAction * action2 = [UIAlertAction actionWithTitle:rBtnStr style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [weakSelf showWithTitle:rBtnStr];
        }];
        [alert addAction:action1];
        [action1 setValue:[UIColor lightGrayColor] forKey:@"titleTextColor"];
        
        [alert addAction:action2];
        [action2 setValue:K_2B91F0 forKey:@"titleTextColor"];
        [self presentViewController:alert animated:YES completion:nil];
      
    }
}

- (void)showWithTitle:(NSString *)title
{
    if ([title isEqualToString:@"拨打电话"]) {
        [_loanRepaymentView payButtonAction];
    }else if ([title isEqualToString:@"添加新卡"]) {
        [self goBindingBankCard];
    }else if ([title isEqualToString:@"支付宝还款"]) {
        [self goAlipay];
    }
}

- (void)goAlipay
{
    LSWebViewController * webVC = [[LSWebViewController alloc] init];
    NSString * urlStr = [NSString stringWithFormat:@"%@%@?borrowMoney=%@&borrowId=%@",BaseHtmlUrl,alipayPayment, _loanRepaymentView.currentRepaymentAmount, _borrowId];
    webVC.webUrlStr = urlStr;
    //版本1.3.4新增,目的是获取在页面的持续时间及用户路径统计
    webVC.pageName = @"bs_ym_zfbhk";
    [self.navigationController pushViewController:webVC animated:YES];
}




/**
 去绑卡页面
 */
- (void)goBindingBankCard
{
    
    LSIdfBindCardViewController * bankVc = [[LSIdfBindCardViewController alloc] init];
    bankVc.bindCardType = BindBankCardTypeCommon;
    bankVc.loanType = ConsumeLoanType;
    [self.navigationController pushViewController:bankVc animated:YES];
    
}

-(void)goMakePhoneCall
{
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",K_BankCustomerServiceNum];
    dispatch_after(0.3, dispatch_get_main_queue(), ^{
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];//隐私设置
    });
}


#pragma mark - 添加视图控件
//  添加子控件
- (void)configueSubViews{
    [self.view addSubview:self.loanRepaymentView];
    //  设置还款类型
    self.loanRepaymentView.loanType = self.loanType;
    if (_loanType == MallLoanType || _loanType == WhiteLoanType) {
        //  白领贷、商城分期不可编辑
        [self.loanRepaymentView configRepaymentViewEdit:NO];
    } else {
        //  其他可编辑
        [self.loanRepaymentView configRepaymentViewEdit:YES];
    }
    
    //    self.loanRepaymentView.frame = CGRectMake(0.0, k_Navigation_Bar_Height, Main_Screen_Width, Main_Screen_Height - k_Navigation_Bar_Height);
}

#pragma mark - setter getter
- (LSLoanRepaymentView *)loanRepaymentView{
    if (_loanRepaymentView == nil) {
        _loanRepaymentView = [[LSLoanRepaymentView alloc] initWithFrame:CGRectMake(0.0, k_Navigation_Bar_Height, Main_Screen_Width, Main_Screen_Height - k_Navigation_Bar_Height)];
        _loanRepaymentView.backgroundColor = [UIColor colorWithHexString:COLOR_LIGHTBG_STR];
        _loanRepaymentView.borrowId = _borrowId;
        _loanRepaymentView.delegate = self;
        _loanRepaymentView.repaymentTotalAmount = [NSDecimalNumber stringWithFloatValue:self.repayAmount];
        
    }
    return _loanRepaymentView;
}

#pragma mark - 接口请求
//  获取我的页面数据
- (void)requestRepaymentPageInfoApi{
    LSRepaymentPageInfoApi *api = [[LSRepaymentPageInfoApi alloc] initWithBorrowId:self.borrowId repaymentAmount:[NSDecimalNumber stringWithFloatValue:self.repayAmount] borrowType:_loanType];
    [SVProgressHUD showLoadingWithOutMask];
    [api requestWithSuccess:^(NSDictionary *responseDict) {
        NSLog(@"%@", responseDict);
        [SVProgressHUD dismiss];
        NSString *codeStr = [responseDict[@"code"] description];
        if ([codeStr isEqualToString:@"1000"]) {
            NSDictionary *dataDict = responseDict[@"data"];
            LSRepaymentPageInfoModel *repaymentPageInfoModel = [LSRepaymentPageInfoModel mj_objectWithKeyValues:dataDict];
            if (repaymentPageInfoModel) {
                self.loanRepaymentView.repaymentInfoModel = repaymentPageInfoModel;
            }
        }
    } failure:^(__kindof YTKBaseRequest *request) {
        [SVProgressHUD dismiss];
    }];
}

#pragma mark - 还款页面统计
- (void)enterRepaymentPageStatistics{
    
}

#pragma mark - 还款成功页面统计
- (void)successRepaymentStatistics{
    [ZTMXFUMengHelper mqEvent:k_Payback_succ_xf];
}

#pragma mark - 还款失败页面统计
- (void)failureRepaymentStatistics:(NSString *)errorInfo{
    [ZTMXFUMengHelper mqEvent:k_Payback_fail_xf];
    
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

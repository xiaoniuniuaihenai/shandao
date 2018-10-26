//
//  PayManager.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/9/27.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "PayManager.h"
#import "PayTypePopupView.h"
#import "PasswordPopupView.h"
#import "LSPayRepaymentApi.h"
#import "LSBrwMoneyPayRenewalApi.h"
#import "LSBrwMoneyConfirmApi.h"
#import "ZTMXFOrderPayApi.h"

#import "PayChannelModel.h"
#import "RealNameManager.h"
#import "LSAlipayRepaymentViewController.h"
#import "LSAlipayOldRepaymentViewController.h"

#import "GoodsBillRepayApi.h"


@interface PayManager ()<PasswordPopupViewDelegate, PayTypePopupViewDelegate>

@end

@implementation PayManager

static id payManager = nil;

- (NSMutableDictionary *)payDataDict{
    if (_payDataDict == nil) {
        _payDataDict = [NSMutableDictionary dictionary];
    }
    return _payDataDict;
}

/** share Instance */
+ (instancetype)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        payManager = [[PayManager alloc] init];
    });
    return payManager;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    @synchronized (self) {
        if (payManager == nil) {
            payManager = [super allocWithZone:zone];
            return payManager;
        }
        return nil;
    }
}

- (instancetype)init{
    @synchronized (self) {
        if (self = [super init]) {
            return self;
        }
        return nil;
    }
}

#pragma mark - 弹出支付框
+ (void)payManagerWithPayType:(PayManagerType)payType payModel:(PayManagerMode)payMode payDataDict:(NSMutableDictionary *)dataDict delegate:(id<PayManagerDelegate>)delegate{
    [[PayManager shareInstance] payManagerWithType:payType payModel:payMode orderData:dataDict delegate:delegate];
}

/** Choise Pay Type */
- (void)payManagerWithType:(PayManagerType)payType payModel:(PayManagerMode)payMode orderData:(NSMutableDictionary *)dataDict delegate:(id<PayManagerDelegate>)delegate{
    
    [self clearDataCash];
    
    _payType = payType;
    _delegate = delegate;
    _payDataDict = dataDict;
    _payMode = payMode;
    if (_payMode == PayByPasswordMode) {
        //  直接弹出密码支付框
        PasswordPopupView *passwordBoxView = [PasswordPopupView popupPasswordBoxView];
        passwordBoxView.delegate = self;
    } else if (_payMode == PayByChosseChannelMode) {
        //  选择还款支付渠道
        PayTypePopupView *otherPayView = [PayTypePopupView popupView];
        otherPayView.titleStr = @"选择支付方式";
        otherPayView.delegate = self;
        if (_payType == LoanRepaymentPayType) {
            otherPayView.showOfflinePay = YES;
        } else {
            otherPayView.showOfflinePay = NO;
        }
    }
}

#pragma mark - PasswordPopupViewDelegate(密码框支付代理方法)
/** 输入密码完成 */
- (void)passwordPopupViewEnterPassword:(NSString *)password{
    //   -1:微信支付；  -2:余额支付, -3 支付宝支付 银行卡Id->银行卡支付
    if (_payType == LoanRepaymentPayType) {
        //  还钱支付
        [self repaymentWithBorrowId:[self.payDataDict objectForKey:kRepaymentBorrowId] acutalAmount:[self.payDataDict objectForKey:kRepaymentActualAmount] repaymentAmount:[self.payDataDict objectForKey:kRepaymentRepaymentAmount] couponId:[self.payDataDict objectForKey:kRepaymentCouponId] rebateAmount:[self.payDataDict objectForKey:kRepaymentBalanceAmount] password:password cardId:[self.payDataDict objectForKey:kRepaymentCardId] loanType:[self.payDataDict objectForKey:kRepaymentLoanType]];
    } else if (_payType == LoanRenewalPayType) {
        //  延期还款支付(目前延期还款不支持直接弹出密码框支付)
        [self renewalPayWith:[self.payDataDict objectForKey:kRenewalBorrowId] password:password cardId:[self.payDataDict objectForKey:kRenewalCardId] renewalAmount:[self.payDataDict objectForKey:kRenewalRenewalAmount] repaymentCapital:[self.payDataDict objectForKey:kRenewalRepaymentCapitalAmount] loanType:[self.payDataDict objectForKey:kRenewalType] renewalPoundageRate:[self.payDataDict objectForKey:kRenewalDelayPoundageRate]];
        
    } else if (_payType == LoanPaymentPayType) {
        //  借钱支付
        [self bonePaymentWithLoanAmount:[self.payDataDict objectForKey:kLoanAmount] loanDays:[self.payDataDict objectForKey:kLoanDays] password:password latitude:[self.payDataDict objectForKey:kLoanLatitude] longitude:[self.payDataDict objectForKey:kLoanlongitude] pronvince:[self.payDataDict objectForKey:kLoanPronvince] city:[self.payDataDict objectForKey:kLoanCity] country:[self.payDataDict objectForKey:kLoanCountry] address:[self.payDataDict objectForKey:kLoanAddress] borrowType:[self.payDataDict objectForKey:kBorrowType] borrowUse:[self.payDataDict objectForKey:kBorrowUse] goodsPrice:[self.payDataDict objectForKey:kConsumeAmount] goodsId:[self.payDataDict objectForKey:kGoodId] couponId:[self.payDataDict objectForKey:kCouponId]];
    } else if (_payType == MallGoodsOrderPayType) {
        //  商城商品订单支付
        [self mallOrderPaymentWithOrderId:[self.payDataDict objectForKey:kMallOrderPayOrderId] password:password cardId:[self.payDataDict objectForKey:kMallOrderPayCardId] nper:[self.payDataDict objectForKey:kMallOrderPayNper] latitude:[self.payDataDict objectForKey:kMallOrderPayLatitude] longitude:[self.payDataDict objectForKey:kMallOrderPayLongitude] province:[self.payDataDict objectForKey:kMallOrderPayProvince] city:[self.payDataDict objectForKey:kMallOrderPayCity] county:[self.payDataDict objectForKey:kMallOrderPayCounty]];
    }
}

/** 忘记密码 */
- (void)passwordPopupViewForgetPassword{
    if (_payType == LoanPaymentPayType) {
        //后台打点
        [XLServerBuriedPointHelper xl_BuriedPointWithPointCode:@"jq" PointSubCode:@"click.jq_qjq_wjmm" OtherDict:nil];
    }else if(_payType == LoanRepaymentPayType){
        //后台打点
        [XLServerBuriedPointHelper xl_BuriedPointWithPointCode:@"jq" PointSubCode:@"click.hq_ljhk_fk_wjmm" OtherDict:nil];
        
    }
    [self jumpToForgetPayPassword];
}

#pragma mark - PayTypePopupViewDelegate(选择支付渠道代理方法)
/** 输入密码完成 */
- (void)payTypePopupViewEnterPassword:(NSString *)password channelModel:(PayChannelModel *)channelModel{
    if (_payType == LoanRepaymentPayType) {
        //  还钱支付
        [self repaymentWithBorrowId:[self.payDataDict objectForKey:kRepaymentBorrowId] acutalAmount:[self.payDataDict objectForKey:kRepaymentActualAmount] repaymentAmount:[self.payDataDict objectForKey:kRepaymentRepaymentAmount] couponId:[self.payDataDict objectForKey:kRepaymentCouponId] rebateAmount:[self.payDataDict objectForKey:kRepaymentBalanceAmount] password:password cardId:channelModel.channelId loanType:[self.payDataDict objectForKey:kRepaymentLoanType]];
        
    } else if (_payType == LoanRenewalPayType) {
        //  延期还款支付
        [self renewalPayWith:[self.payDataDict objectForKey:kRenewalBorrowId] password:password cardId:channelModel.channelId renewalAmount:[self.payDataDict objectForKey:kRenewalRenewalAmount] repaymentCapital:[self.payDataDict objectForKey:kRenewalRepaymentCapitalAmount] loanType:[self.payDataDict objectForKey:kRenewalType] renewalPoundageRate:[self.payDataDict objectForKey:kRenewalDelayPoundageRate]];
    } else if (_payType == LoanPaymentPayType) {
        //  借钱支付(不支持弹出选择支付渠道支付)
        
    } else if (_payType == MallLoanRepaymentPayType) {
        //  商城分期还款支付
        [self mallRepaymentWithBillId:[self.payDataDict objectForKey:kRepaymentBorrowId] repaymentAmount:[self.payDataDict objectForKey:kRepaymentRepaymentAmount] cardId:channelModel.channelId password:password latitude:[self.payDataDict objectForKey:kRepaymentLatitude] longitude:[self.payDataDict objectForKey:kRepaymentLongitude]];
    }
}

/** 线下支付宝支付 */
- (void)payTypePopupViewAlipayWithChannelModel:(PayChannelModel *)channelModel isNewPayStyle:(NSInteger)isNewPayStyle{
    if (_payType == LoanRepaymentPayType) {
        //  还钱支付
        if ([_delegate isKindOfClass:[UIViewController class]]) {
            UIViewController *viewController = (UIViewController *)_delegate;
            LSWebViewController * webVC = [[LSWebViewController alloc] init];
            NSString * urlStr = [NSString stringWithFormat:@"%@%@?borrowMoney=%@&borrowId=%@",BaseHtmlUrl,alipayPayment, [self.payDataDict objectForKey:kRepaymentRepaymentAmount], [self.payDataDict objectForKey:kRepaymentBorrowId]];
            webVC.webUrlStr = urlStr;
            //版本1.3.4新增,目的是获取在页面的持续时间及用户路径统计
            webVC.pageName = @"bs_ym_zfbhk";
            //                webVC.appInfoIgnore = YES;
            [viewController.navigationController pushViewController:webVC animated:YES];
        }
    } else if (_payType == LoanRenewalPayType) {
        //  延期还款支付
    }
}

/** 其他支付方式 */
- (void)payTypePopupViewOtherPayStyleWithChannelModel:(PayChannelModel *)channelModel{
    if (_payType == LoanRepaymentPayType) {
        //  还钱支付
        if ([_delegate isKindOfClass:[UIViewController class]]) {
            UIViewController *viewController = (UIViewController *)_delegate;
            LSWebViewController *webVC = [[LSWebViewController alloc] init];
            webVC.webUrlStr = DefineUrlString(otherPayType);
            [viewController.navigationController pushViewController:webVC animated:YES];
        }
        
    } else if (_payType == LoanRenewalPayType) {
        //  延期还款支付
    }
    
}

/** 忘记密码 */
- (void)payTypePopupViewClickForgetPassword{
    //后台打点
    
    if (_payType == LoanPaymentPayType) {
        //后台打点
        [XLServerBuriedPointHelper xl_BuriedPointWithPointCode:@"jq" PointSubCode:@"click.jq_qjq_wjmm" OtherDict:nil];
    }else if(_payType == LoanRepaymentPayType){
        //后台打点
        [XLServerBuriedPointHelper xl_BuriedPointWithPointCode:@"jq" PointSubCode:@"click.hq_ljhk_fk_wjmm" OtherDict:nil];
        
    }
    [self jumpToForgetPayPassword];
}

#pragma mark - 跳转到忘记支付密码
- (void)jumpToForgetPayPassword{
    if (_delegate && [_delegate isKindOfClass:[UIViewController class]]) {
        UIViewController *fromViewController = (UIViewController *)_delegate;
        [RealNameManager realNameWithCurrentVc:fromViewController andRealNameProgress:RealNameProgressSetPayPaw isSaveBackVcName:YES];
    }
}

#pragma mark - 跳转到其他支付方式
- (void)jumpToOtherPayType{
    if (_delegate && [_delegate isKindOfClass:[UIViewController class]]) {
        UIViewController *controller = (UIViewController *)_delegate;
        LSWebViewController *webVC = [[LSWebViewController alloc] init];
        webVC.webUrlStr = DefineUrlString(otherPayType);
        [controller.navigationController pushViewController:webVC animated:YES];
    }
}

#pragma mark - 还款支付(支持银行卡, 支付宝, 余额支付)
//  还款支付
- (void)repaymentWithBorrowId:(NSString *)borrowId acutalAmount:(NSString *)actualAmount repaymentAmount:(NSString *)repaymentAmount couponId:(NSString *)couponId rebateAmount:(NSString *)balanceAmount password:(NSString *)password cardId:(NSString *)cardId loanType:(NSString *)loanType{
    LSPayRepaymentApi *repaymentApi = [[LSPayRepaymentApi alloc] initWithBorrowId:borrowId actualAmount:actualAmount repaymentAmount:repaymentAmount couponId:couponId rebateAmount:balanceAmount password:password cardId:cardId loanType:loanType];
    [SVProgressHUD showLoading];
    [repaymentApi requestWithSuccess:^(NSDictionary *responseDict) {
        [SVProgressHUD dismiss];
        NSString *codeStr = [responseDict[@"code"] description];
        if ([codeStr isEqualToString:@"1000"]) {
            /** 渠道id(银行卡就是银行卡Id, 微信:-1, 余额: -2,支付宝: -3；支付宝线下还款：-4；其他还款方式：-5) */
            if ([cardId isEqualToString:@"-3"]) {
                //  支付宝线上支付
                if (self.delegate && [self.delegate respondsToSelector:@selector(payManagerAlipayPayDataDict:)]) {
                    NSDictionary *dataDict = responseDict[@"data"];
                    [self.delegate payManagerAlipayPayDataDict:dataDict];
                }
            } else {
                //  银行卡支付
                if (self.delegate && [self.delegate respondsToSelector:@selector(payManagerDidPaySuccess:)]) {
                    [self.delegate payManagerDidPaySuccess:responseDict];
                }
            }
        } else {
            if (self.delegate && [self.delegate respondsToSelector:@selector(payManagerDidPayFail:)]) {
                [self.delegate payManagerDidPayFail:responseDict];
            }
        }
    } failure:^(__kindof YTKBaseRequest *request) {
        [SVProgressHUD dismiss];
    }];
}


#pragma mark - 延期还款支付(支持银行卡, 支付宝支付)
- (void)renewalPayWith:(NSString *)borrowId password:(NSString *)password cardId:(NSString *)cardId renewalAmount:(NSString *)renewalAmount repaymentCapital:(NSString *)capital loanType:(NSString *)loanType renewalPoundageRate:(NSString *)poundageRate{
    LSBrwMoneyPayRenewalApi * payApi = [[LSBrwMoneyPayRenewalApi alloc] initWithBorrowId:borrowId andPayPwd:password andCardId:cardId renewalAmount:renewalAmount repaymentCapital:capital loanType:loanType renewalPoundageRate:poundageRate];
    [SVProgressHUD showLoading];
    [payApi requestWithSuccess:^(NSDictionary *responseDict) {
        [SVProgressHUD dismiss];
        NSString * codeStr = [responseDict[@"code"]description];
        if ([codeStr isEqualToString:@"1000"]) {
            if ([cardId isEqualToString:@"-3"]) {
                //  支付宝支付
                if (self.delegate && [self.delegate respondsToSelector:@selector(payManagerAlipayPayDataDict:)]) {
                    NSDictionary *dataDict = responseDict[@"data"];
                    [self.delegate payManagerAlipayPayDataDict:dataDict];
                }
            } else {
                //  银行卡支付
                if (self.delegate && [self.delegate respondsToSelector:@selector(payManagerDidPaySuccess:)]) {
                    [self.delegate payManagerDidPaySuccess:responseDict];
                }
            }
            
        } else {
            if (self.delegate && [self.delegate respondsToSelector:@selector(payManagerDidPayFail:)]) {
                [self.delegate payManagerDidPayFail:responseDict];
            }
        }
    } failure:^(__kindof YTKBaseRequest *request) {
        [SVProgressHUD dismiss];
    }];
}

#pragma mark - 借钱支付(输入密码校验支付)
- (void)bonePaymentWithLoanAmount:(NSString *) loanAmount loanDays:(NSString *)loanDays password:(NSString *)password latitude:(NSString *)latitude longitude:(NSString *)longitude pronvince:(NSString *)pronvice city:(NSString *)city country:(NSString *)country address:(NSString *)address borrowType:(NSString *)borrowType borrowUse:(NSString *)borrowUse goodsPrice:(NSString *)goodsPrice goodsId:(NSString *)goodsId couponId:(NSString *)couponId{
    LSBrwMoneyConfirmApi * confirmApi = [[LSBrwMoneyConfirmApi alloc]initWithBrwMoneyConfirmWithAmount:loanAmount andDay:loanDays andPwd:password andLatitude:latitude andLongitude:longitude andProvince:pronvice andCity:city andCounty:country andAddress:address borrowType:borrowType borrowUse:borrowUse goodsPrice:goodsPrice goodsId:goodsId couponId:couponId];
    [SVProgressHUD showLoading];
    [confirmApi requestWithSuccess:^(NSDictionary *responseDict) {
        NSString * codeStr = [responseDict[@"code"]description];
        if ([codeStr isEqualToString:@"1000"]) {
            //  借钱申请提交成功
            if (self.delegate && [self.delegate respondsToSelector:@selector(payManagerDidPaySuccess:)]) {
                [self.delegate payManagerDidPaySuccess:responseDict];
            }
        } else {
            if (self.delegate && [self.delegate respondsToSelector:@selector(payManagerDidPayFail:)]) {
                [self.delegate payManagerDidPayFail:responseDict];
            }
        }
        [SVProgressHUD dismiss];
    } failure:^(__kindof YTKBaseRequest *request) {
        [SVProgressHUD dismiss];
    }];
}

#pragma mark - 商城商品订单支付`
- (void)mallOrderPaymentWithOrderId:(NSString *)orderId password:(NSString *)password cardId:(NSString *)cardId nper:(NSString *)nper latitude:(NSString*)latitude longitude:(NSString*)longitude province:(NSString*)province city:(NSString*)city county:(NSString*)county{
    ZTMXFOrderPayApi * orderPayApi = [[ZTMXFOrderPayApi alloc] initWithOrderId:orderId password:password cardId:cardId nper:nper latitude:latitude longitude:longitude province:province city:city county:county];
    [SVProgressHUD showLoading];
    [orderPayApi requestWithSuccess:^(NSDictionary *responseDict) {
        NSString * codeStr = [responseDict[@"code"] description];
        if ([codeStr isEqualToString:@"1000"]) {
            /** 支付结果 1:支付成功； 2:支付中；-1:支付失败； */
            NSString *status = [responseDict[@"data"][@"status"] description];
            if ([status isEqualToString:@"1"]) {
                //  订单支付成功
                if (self.delegate && [self.delegate respondsToSelector:@selector(payManagerDidPaySuccess:)]) {
                    [self.delegate payManagerDidPaySuccess:responseDict];
                }
            } else if ([status isEqualToString:@"2"]) {
                //  订单支付处理中
                if (self.delegate && [self.delegate respondsToSelector:@selector(payManagerDidPayProcess:)]) {
                    [self.delegate payManagerDidPayProcess:responseDict];
                }
            } else if ([status isEqualToString:@"-1"]) {
                //  支付失败
                if (self.delegate && [self.delegate respondsToSelector:@selector(payManagerDidPayFail:)]) {
                    [self.delegate payManagerDidPayFail:responseDict];
                }
            }
        } else {
        }
        [SVProgressHUD dismiss];
    } failure:^(__kindof YTKBaseRequest *request) {
        [SVProgressHUD dismiss];
    }];
}

#pragma mark - 商城分期还款支付
- (void)mallRepaymentWithBillId:(NSString *)billIds repaymentAmount:(NSString *)repaymentAmount cardId:(NSString *)cardId password:(NSString *)password latitude:(NSString*)latitude longitude:(NSString*)longitude{
    GoodsBillRepayApi * goodsPayApi = [[GoodsBillRepayApi alloc] initWithBillId:billIds repaymentAmount:repaymentAmount password:password cardId:cardId latitude:latitude longitude:longitude];
    [SVProgressHUD showLoading];
    [goodsPayApi requestWithSuccess:^(NSDictionary *responseDict) {
        [SVProgressHUD dismiss];
        NSString *codeStr = [responseDict[@"code"] description];
        if ([codeStr isEqualToString:@"1000"]) {
            //  银行卡支付
            if (self.delegate && [self.delegate respondsToSelector:@selector(payManagerDidPaySuccess:)]) {
                [self.delegate payManagerDidPaySuccess:responseDict];
            }
        } else {
            if (self.delegate && [self.delegate respondsToSelector:@selector(payManagerDidPayFail:)]) {
                [self.delegate payManagerDidPayFail:responseDict];
            }
        }
        
    } failure:^(__kindof YTKBaseRequest *request) {
        [SVProgressHUD dismiss];
    }];
}


#pragma mark - 获取借钱还款支付参数
+ (NSMutableDictionary *)setLoanRepaymentParamsWithBorrowId:(NSString *)borrowId acutalAmount:(NSString *)actualAmount repaymentAmount:(NSString *)repaymentAmount couponId:(NSString *)couponId rebateAmount:(NSString *)balanceAmount cardId:(NSString *)cardId loanType:(NSString *)loanType{
    NSMutableDictionary *paramDict = [NSMutableDictionary dictionary];
    [paramDict setValue:borrowId forKey:kRepaymentBorrowId];
    [paramDict setValue:actualAmount forKey:kRepaymentActualAmount];
    [paramDict setValue:repaymentAmount forKey:kRepaymentRepaymentAmount];
    [paramDict setValue:couponId forKey:kRepaymentCouponId];
    [paramDict setValue:balanceAmount forKey:kRepaymentBalanceAmount];
    [paramDict setValue:cardId forKey:kRepaymentCardId];
    [paramDict setValue:loanType forKey:kRepaymentLoanType];
    return paramDict;
}

#pragma mark - 设置延期还款支付参数
+ (NSMutableDictionary *)setLoanRenewalParamsWithBorrowId:(NSString *)borrowId cardId:(NSString *)cardId renewalAmount:(NSString *)renewalAmount repaymentCapital:(NSString *)capital loanType:(LoanType)loanType renewalPoundageRate:(NSString *)poundageRate{
    NSMutableDictionary *paramDict = [NSMutableDictionary dictionary];
    [paramDict setValue:borrowId forKey:kRenewalBorrowId];
    [paramDict setValue:cardId forKey:kRenewalCardId];
    [paramDict setValue:renewalAmount forKey:kRenewalRenewalAmount];
    [paramDict setValue:capital forKey:kRenewalRepaymentCapitalAmount];
    if (loanType == CashLoanType) {
        //  现金贷
        [paramDict setValue:@"1" forKey:kRenewalType];
    } else {
        //  消费贷
        [paramDict setValue:@"2" forKey:kRenewalType];
    }
    [paramDict setValue:poundageRate forKey:kRenewalDelayPoundageRate];
    return paramDict;
}

#pragma mark - 设置借钱支付参数
+ (NSMutableDictionary *)setLoanPayParamsWithLoanAmount:(NSString *) loanAmount loanDays:(NSString *)loanDays latitude:(NSString *)latitude longitude:(NSString *)longitude pronvince:(NSString *)pronvice city:(NSString *)city country:(NSString *)country address:(NSString *)address borrowType:(NSString *)borrowType borrowUse:(NSString *)borrowUse goodsPrice:(NSString *)goodsPrice goodsId:(NSString *)goodsId couponID:(NSString *)couponID{
    NSMutableDictionary *paramDict = [NSMutableDictionary dictionary];
    [paramDict setValue:loanAmount forKey:kLoanAmount];
    [paramDict setValue:loanDays forKey:kLoanDays];
    [paramDict setValue:latitude forKey:kLoanLatitude];
    [paramDict setValue:longitude forKey:kLoanlongitude];
    [paramDict setValue:pronvice forKey:kLoanPronvince];
    [paramDict setValue:city forKey:kLoanCity];
    [paramDict setValue:country forKey:kLoanCountry];
    [paramDict setValue:address forKey:kLoanAddress];
    
    [paramDict setValue:borrowType forKey:kBorrowType];
    [paramDict setValue:borrowUse forKey:kBorrowUse];
    [paramDict setValue:goodsPrice forKey:kConsumeAmount];
    [paramDict setValue:goodsId forKey:kGoodId];
    [paramDict setValue:couponID forKey:kCouponId];
    
    return paramDict;
}

#pragma mark - 设置商城订单支付参数
+ (NSMutableDictionary *)setMallOrderPayParamsWithOrderId:(NSString *)orderId cardId:(NSString *)cardId nper:(NSString *)nper latitude:(NSString *)latitude longitude:(NSString *)longitude province:(NSString *)province city:(NSString *)city county:(NSString *)county{
    
    NSMutableDictionary *paramDict = [NSMutableDictionary dictionary];
    [paramDict setValue:orderId forKey:kMallOrderPayOrderId];
    [paramDict setValue:cardId forKey:kMallOrderPayCardId];
    [paramDict setValue:nper forKey:kMallOrderPayNper];
    [paramDict setValue:latitude forKey:kMallOrderPayLatitude];
    [paramDict setValue:longitude forKey:kMallOrderPayLongitude];
    [paramDict setValue:province forKey:kMallOrderPayProvince];
    [paramDict setValue:city forKey:kMallOrderPayCity];
    [paramDict setValue:county forKey:kMallOrderPayCounty];
    return paramDict;
}

#pragma mark - 设置商品分期支付参数
+ (NSMutableDictionary *)setMallLoanRepaymentParamsWithRepaymentAmount:(NSString *)repaymentAmount billIds:(NSString *)billIds cardId:(NSString *)cardId payPwd:(NSString *)payPwd latitude:(NSString *)latitude longitude:(NSString *)longitude{
    NSMutableDictionary *paramDict = [NSMutableDictionary dictionary];
    [paramDict setValue:repaymentAmount forKey:kRepaymentRepaymentAmount];
    [paramDict setValue:billIds forKey:kRepaymentBorrowId];
    [paramDict setValue:cardId forKey:kRepaymentCardId];
    [paramDict setValue:latitude forKey:kRepaymentLatitude];
    [paramDict setValue:longitude forKey:kRepaymentLongitude];
    return paramDict;
}

#pragma mark - 清除数据缓存
- (void)clearDataCash{
    [self.payDataDict removeAllObjects];
}

@end

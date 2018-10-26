//
//  PayManager.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/9/27.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import <Foundation/Foundation.h>
@class PayChannelModel;

#pragma mark - 支付类型
typedef enum : NSUInteger {
    LoanRepaymentPayType,       //  借钱还款支付
    LoanRenewalPayType,         //  借钱延期还款支付
    LoanPaymentPayType,         //  借钱支付
    MallGoodsOrderPayType,      //  商城商品订单支付
    MallLoanRepaymentPayType,   //  商城分期还款支付
} PayManagerType;


#pragma mark - 支付弹窗方式
typedef enum : NSUInteger {
    PayByPasswordMode,              //  直接弹出密码框支付
    PayByChosseChannelMode,         //  选择支付渠道支付
} PayManagerMode;


#pragma mark - 借钱还款支付需要用到的参数
//   -1:微信支付；  -2:余额支付, -3 支付宝支付 银行卡Id->银行卡支付
#define kRepaymentCardId          @"kRepaymentCardId"
#define kRepaymentBorrowId          @"kRepaymentBorrowId"             //  借钱还款Id
#define kRepaymentActualAmount      @"kRepaymentActualAmount"         //  还款实际支付金额
#define kRepaymentRepaymentAmount   @"kRepaymentRepaymentAmount"
#define kRepaymentCouponId          @"kRepaymentCouponId"             //  还款优惠券Id
#define kRepaymentBalanceAmount     @"kRepaymentBalanceAmount"        //  还款使用余额
#define kRepaymentLoanType          @"kRepaymentLoanType"             //  还款类型
#define kRepaymentLatitude          @"kRepaymentLatitude"
#define kRepaymentLongitude         @"kRepaymentLongitude"


#pragma mark - 延期还款支付用到的参数
#define kRenewalBorrowId            @"kRenewalBorrowId"               //  延期还款借款ID
#define kRenewalCardId              @"kRenewalCardId"                 //  延期还款银行卡ID
#define kRenewalRenewalAmount       @"kRenewalRenewalAmount"          //  延期还款金额
#define kRenewalRepaymentCapitalAmount @"kRenewalRepaymentCapitalAmount"  //  延期还款还款本金
#define kRenewalType                @"kRenewalType"          //  延期还款类型
#define kRenewalDelayPoundageRate   @"kRenewalDelayPoundageRate"   //  延期还款手续费率


#pragma mark - 借钱用到的参数
#define kLoanAmount                  @"kLoanAmount"                    //  借钱金额
#define kLoanDays                    @"kLoanDays"                      //  借钱天数
#define kLoanLatitude                @"kLoanLatitude"
#define kLoanlongitude               @"kLoanlongitude"
#define kLoanPronvince               @"kLoanPronvince"
#define kLoanCity                    @"kLoanCity"
#define kLoanCountry                 @"kLoanCountry"
#define kLoanAddress                 @"kLoanAddress"
#define kBorrowType                  @"kBorrowType"     // 1，表示白领贷，2表示消费贷
#define kBorrowUse                   @"kBorrowUse"      //  借钱用途(消费贷必填)
#define kConsumeAmount               @"kConsumeAmount"  //  消费价格
#define kGoodId                      @"kGoodId"         //  商品id
#define kCouponId                      @"kCouponId"         // 优惠券id

#pragma mark - 商城订单支付参数
#define kMallOrderPayOrderId    @"kMallOrderPayOrderId" //  订单Id
#define kMallOrderPayCardId     @"kMallOrderPayCardId"  //  cardId
#define kMallOrderPayNper       @"kMallOrderPayNper"    //  分期数
#define kMallOrderPayLatitude   @"kMallOrderPayLatitude"
#define kMallOrderPayLongitude  @"kMallOrderPayLongitude"
#define kMallOrderPayProvince   @"kMallOrderPayProvince"
#define kMallOrderPayCity       @"kMallOrderPayCity"
#define kMallOrderPayCounty     @"kMallOrderPayCounty"


@protocol PayManagerDelegate <NSObject>

@optional
/** 支付宝支付 */
- (void)payManagerAlipayPayDataDict:(NSDictionary *)payDataDict;

/** pay success */
- (void)payManagerDidPaySuccess:(NSDictionary *)successInfo;
/** pay fail */
- (void)payManagerDidPayFail:(NSDictionary *)failInfo;
/** pay process */
- (void)payManagerDidPayProcess:(NSDictionary *)processInfo;

@end


@interface PayManager : NSObject

/** 支付类型 */
@property (nonatomic, assign) PayManagerType payType;
/** 支付模式 */
@property (nonatomic, assign) PayManagerMode payMode;
/** pay Data Dictionary(支付用到的一些参数) */
@property (nonatomic, strong) NSMutableDictionary *payDataDict;
/** Delegate */
@property (nonatomic, weak) id<PayManagerDelegate> delegate;

/** Show Pay Type */
+ (void)payManagerWithPayType:(PayManagerType)payType payModel:(PayManagerMode)payMode payDataDict:(NSMutableDictionary *)dataDict delegate:(id<PayManagerDelegate>)delegate;


#pragma mark - 获取借钱还款支付参数
+ (NSMutableDictionary *)setLoanRepaymentParamsWithBorrowId:(NSString *)borrowId acutalAmount:(NSString *)actualAmount repaymentAmount:(NSString *)repaymentAmount couponId:(NSString *)couponId rebateAmount:(NSString *)balanceAmount cardId:(NSString *)cardId loanType:(NSString *)loanType;

#pragma mark - 设置延期还款支付参数
+ (NSMutableDictionary *)setLoanRenewalParamsWithBorrowId:(NSString *)borrowId cardId:(NSString *)cardId renewalAmount:(NSString *)renewalAmount repaymentCapital:(NSString *)capital loanType:(LoanType)loanType renewalPoundageRate:(NSString *)poundageRate;

#pragma mark - 设置借钱支付参数
+ (NSMutableDictionary *)setLoanPayParamsWithLoanAmount:(NSString *) loanAmount loanDays:(NSString *)loanDays latitude:(NSString *)latitude longitude:(NSString *)longitude pronvince:(NSString *)pronvice city:(NSString *)city country:(NSString *)country address:(NSString *)address borrowType:(NSString *)borrowType borrowUse:(NSString *)borrowUse goodsPrice:(NSString *)goodsPrice goodsId:(NSString *)goodsId couponID:(NSString *)couponID;

#pragma mark - 设置商城订单支付参数
+ (NSMutableDictionary *)setMallOrderPayParamsWithOrderId:(NSString *)orderId cardId:(NSString *)cardId nper:(NSString *)nper latitude:(NSString*)latitude longitude:(NSString*)longitude province:(NSString*)province city:(NSString*)city county:(NSString*)county;

#pragma mark - 设置商品分期支付参数
+ (NSMutableDictionary *)setMallLoanRepaymentParamsWithRepaymentAmount:(NSString *)repaymentAmount billIds:(NSString *)billIds cardId:(NSString *)cardId payPwd:(NSString *)payPwd latitude:(NSString *)latitude longitude:(NSString *)longitude;


@end

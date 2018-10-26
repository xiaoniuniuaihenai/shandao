//
//  YPCashierPay.h
//  YPCashierPay
//
//  Created by BiuKia on 17/3/13.
//  Copyright © 2017年 YEEPAY. All rights reserved.
//

#import <UIKit/UIKit.h>

//! Project version number for YPCashierPay.
FOUNDATION_EXPORT double YPCashierPayVersionNumber;

//! Project version string for YPCashierPay.
FOUNDATION_EXPORT const unsigned char YPCashierPayVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <YPCashierPay/PublicHeader.h>

/**
 SDK入参请求对象
 */
@interface Payment : NSObject

/**
 初始化SDK入参请求对象

 @param token token
 @param merchantNo 商户编号
 @param userType 用户类型（IMEI,MAC,USER_ID,EMAIL,PHONE,ID_CARD,AGREEMENT_NO,WECHAT或为空）
 @param userNo 用户号
 @param directPayType 直连类型 (YJZF WX ZFB 或者其他，当为其他时为非直连)
 @param timeStamp 时间戳
 @param longitude 交易经度
 @param latitude  交易纬度
 @param sign 签名
 @return payment object
 */
-(instancetype)init:(NSString *)token
         merchantNo:(NSString *)merchantNo
           userType:(NSString *)userType
             userNo:(NSString *)userNo
           cardType:(NSString *)cardType
      directPayType:(NSString *)directPayType
          timeStamp:(NSString *)timeStamp
          longitude:(NSString *)longitude
           latitude:(NSString *)latitude
               sign:(NSString *)sign;
@end


typedef enum : NSInteger {
    YPCashierResultSucc = 0,                     //支付成功,包含了一次确认查单
    YPCashierResultProcess = 1,                  //支付处理中，需要app去查单
    YPCashierResultCancel = -1,                  //支付取消
    YPCashierResultFail = -2,                    //支付失败
} YPCashierResultStatus;


@interface YPCashierResult : NSObject
@property (assign, nonatomic) YPCashierResultStatus resultStatus;
@property (strong, nonatomic) NSDictionary * info; //其他信息（**** 当支付成功、处理中、失败时该字段不为nil)
@end

typedef void (^YPCashierCompletion)(NSString *mesg, YPCashierResult *result);

@interface YPCashierPay : NSObject


/**
 商户App调用支付
 
 @param viewcontroller 发起支付当前页面
 @param payment 易宝的该笔订单信息
 @param schemes URL Schemes [支付宝，微信]App 回调需要的URL Scheme(如果用户开有支付宝支付和微信支付功能，urlScheme key定义具体见line 97)
 @param completion 支付结果(mesg,提示信息 YPCashierResult：具体支付结果)
 */
+(void)createPayment:(UIViewController *)viewcontroller
             payment:(Payment *)payment
          urlSchemes:(NSDictionary<NSString *, NSString *> *)schemes
      withCompletion:(YPCashierCompletion)completion;


/**
 回调结果接口(支付宝/微信）
 
 @param url 结果url
 @param completion 支付结果回调 Block，保证跳转支付过程中，当 app 被 kill 掉时，能通过这个接口得到支付结果
 @return 当无法处理 URL 或者 URL 格式不正确时，会返回 NO
 */
+ (BOOL)handleOpenURL:(NSURL *)url withCompletion:(YPCashierCompletion)completion;

@end

FOUNDATION_EXPORT NSString * const kAlipayUrlSchemeKey;
FOUNDATION_EXPORT NSString * const kWeChatUrlSchemeKey;


//
//  ZTMXFPayManager.m
//  YWLTMeiQiiOS
//
//  Created by 陈传亮 on 2018/5/31.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "ZTMXFPayManager.h"
#import "ZTMXFPayRepaymentApi.h"
#import "ZTMXFDelayReimbursementApi.h"
#import "ZTMXFGoodsBillRepayApi.h"
@implementation ZTMXFPayManager

//  还款支付
+ (void)postJSONWithParameters:(id)parameters
                       success:(void (^)(id responseObject))success
                       failure:(void (^)(id failureObject))failure
{
    ZTMXFPayRepaymentApi *repaymentApi = [[ZTMXFPayRepaymentApi alloc] initWithPayInfoDic:parameters];
    [SVProgressHUD showLoading];
    [repaymentApi requestWithSuccess:^(NSDictionary *responseDict) {
        [SVProgressHUD dismiss];
        NSString *codeStr = [responseDict[@"code"] description];
        if ([codeStr isEqualToString:@"1000"]) {
            /** 渠道id(银行卡就是银行卡Id, 微信:-1, 余额: -2,支付宝: -3；支付宝线下还款：-4；其他还款方式：-5) */
            NSString * cardId = parameters[@"cardId"];

            if ([cardId isEqualToString:@"-3"]) {
                //  支付宝线上支付
                NSDictionary *dataDict = responseDict[@"data"];
                if (success) {
                    success(dataDict);
                }
            } else {
                if (success) {
                    success(responseDict);
                }
            }
        } else {
            if (failure) {
                failure(responseDict);
            }
        }
    } failure:^(__kindof YTKBaseRequest *request) {
        [SVProgressHUD dismiss];
    }];
}

/**
 延期还款支付
 */
+ (void)delayPayParameters:(id)parameters
                   success:(void (^)(id responseObject))success
                   failure:(void (^)(id failureObject))failure
{
    ZTMXFDelayReimbursementApi * payApi = [[ZTMXFDelayReimbursementApi alloc] initWithPayInfoDic:parameters];
    [SVProgressHUD showLoading];
    [payApi requestWithSuccess:^(NSDictionary *responseDict) {
        [SVProgressHUD dismiss];
        NSString * codeStr = [responseDict[@"code"]description];
        if ([codeStr isEqualToString:@"1000"]) {
            //  银行卡支付
            if (success) {
                success(responseDict);
            }
        } else {
            if (failure) {
                failure(responseDict);
            }
        }
    } failure:^(__kindof YTKBaseRequest *request) {
        [SVProgressHUD dismiss];
    }];
}

+ (void)goodsBillRepayParameters:(id)parameters
                         success:(void (^)(id responseObject))success
                         failure:(void (^)(id failureObject))failure
{
    ZTMXFGoodsBillRepayApi * goodsPayApi = [[ZTMXFGoodsBillRepayApi alloc] initWithDictionary:parameters];
    [SVProgressHUD showLoading];
    [goodsPayApi requestWithSuccess:^(NSDictionary *responseDict) {
        [SVProgressHUD dismiss];
        NSString *codeStr = [responseDict[@"code"] description];
        if ([codeStr isEqualToString:@"1000"]) {
            //  银行卡支付
            if (success) {
                success(responseDict);
            }
        } else {
            if (failure) {
                failure(responseDict);
            }
        }
    } failure:^(__kindof YTKBaseRequest *request) {
        [SVProgressHUD dismiss];
    }];
}


#pragma mark - 获取借钱还款支付参数
+ (NSMutableDictionary *)setLoanRepaymentParamsWithBorrowId:(NSString *)borrowId acutalAmount:(NSString *)actualAmount repaymentAmount:(NSString *)repaymentAmount couponId:(NSString *)couponId rebateAmount:(NSString *)balanceAmount loanType:(NSString *)loanType
{
    NSMutableDictionary *paramDict = [NSMutableDictionary dictionary];
    [paramDict setValue:borrowId forKey:@"borrowIds"];
    [paramDict setValue:actualAmount forKey:@"actualAmount"];
    [paramDict setValue:repaymentAmount forKey:@"repaymentAmount"];
    [paramDict setValue:couponId forKey:@"couponId"];
    [paramDict setValue:balanceAmount forKey:@"rebateAmount"];
    [paramDict setValue:loanType forKey:@"borrowType"];

    return paramDict;
}

#pragma mark - 设置延期还款支付参数
+ (NSMutableDictionary *)setLoanRenewalParamsWithBorrowId:(NSString *)borrowId cardId:(NSString *)cardId renewalAmount:(NSString *)renewalAmount repaymentCapital:(NSString *)capital loanType:(LoanType)loanType renewalPoundageRate:(NSString *)poundageRate
{
    NSMutableDictionary *paramDict = [NSMutableDictionary dictionary];
    [paramDict setValue:borrowId forKey:@"borrowId"];
    [paramDict setValue:cardId forKey:@"cardId"];
    [paramDict setValue:renewalAmount forKey:@"renewalAmount"];
    [paramDict setValue:capital forKey:@"capital"];
    if (loanType == CashLoanType) {
        //  现金贷
        [paramDict setValue:@"1" forKey:@"borrowType"];
    } else {
        //  消费贷
        [paramDict setValue:@"2" forKey:@"borrowType"];
    }
    [paramDict setValue:poundageRate forKey:@"renewalPoundageRate"];
    return paramDict;
}

#pragma mark - 设置商品分期支付参数
+ (NSMutableDictionary *)setMallLoanRepaymentParamsWithRepaymentAmount:(NSString *)repaymentAmount
                                                               billIds:(NSString *)billIds
                                                              latitude:(NSString *)latitude
                                                             longitude:(NSString *)longitude
{
    NSMutableDictionary *paramDict = [NSMutableDictionary dictionary];
    [paramDict setValue:repaymentAmount forKey:@"repaymentAmount"];
    [paramDict setValue:billIds forKey:@"billIds"];
    [paramDict setValue:latitude forKey:@"latitude"];
    [paramDict setValue:longitude forKey:@"latitude"];
    return paramDict;
}


//- (id)requestArgument
//{
//    NSMutableDictionary *paramDict = [NSMutableDictionary dictionary];
//    [paramDict setValue:_billIds forKey:@"billIds"];
//    [paramDict setValue:_repaymentAmount forKey:@"repaymentAmount"];
//    [paramDict setValue:_password forKey:@"payPwd"];
//    [paramDict setValue:_cardId forKey:@"cardId"];
//    [paramDict setValue:_latitude forKey:@"latitude"];
//    [paramDict setValue:_longitude forKey:@"longitude"];
//    return paramDict;
//}

@end

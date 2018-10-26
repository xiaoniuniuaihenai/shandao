//
//  ZTMXFPayManager.h
//  YWLTMeiQiiOS
//
//  Created by 陈传亮 on 2018/5/31.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZTMXFPayManager : NSObject

/**
 消费贷还款
 */
+ (void)postJSONWithParameters:(id)parameters
                success:(void (^)(id responseObject))success
                       failure:(void (^)(id failureObject))failure;

/**
 延期还款支付
 */
+ (void)delayPayParameters:(id)parameters
                       success:(void (^)(id responseObject))success
                       failure:(void (^)(id failureObject))failure;
/**
 消费分期支付支付
 */
+ (void)goodsBillRepayParameters:(id)parameters
                   success:(void (^)(id responseObject))success
                   failure:(void (^)(id failureObject))failure;
/**
  借钱参数
 */
+ (NSMutableDictionary *)setLoanRepaymentParamsWithBorrowId:(NSString *)borrowId acutalAmount:(NSString *)actualAmount repaymentAmount:(NSString *)repaymentAmount couponId:(NSString *)couponId rebateAmount:(NSString *)balanceAmount loanType:(NSString *)loanType;
/**
 延期还款
 */
+ (NSMutableDictionary *)setLoanRenewalParamsWithBorrowId:(NSString *)borrowId cardId:(NSString *)cardId renewalAmount:(NSString *)renewalAmount repaymentCapital:(NSString *)capital loanType:(LoanType)loanType renewalPoundageRate:(NSString *)poundageRate;
/**
 消费分期参数
 */
+ (NSMutableDictionary *)setMallLoanRepaymentParamsWithRepaymentAmount:(NSString *)repaymentAmount billIds:(NSString *)billIds latitude:(NSString *)latitude longitude:(NSString *)longitude;


@end

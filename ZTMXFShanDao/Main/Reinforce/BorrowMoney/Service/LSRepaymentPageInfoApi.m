//
//  LSRepaymentPageInfoApi.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/9/26.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "LSRepaymentPageInfoApi.h"

@interface LSRepaymentPageInfoApi ()

@property (nonatomic, copy) NSString *borrowId;
@property (nonatomic, copy) NSString *repaymentAmount;
@property (nonatomic, assign) LoanType borrowType;

@end

@implementation LSRepaymentPageInfoApi

- (instancetype)initWithBorrowId:(NSString *)borrowId repaymentAmount:(NSString *)repaymentAmount borrowType:(LoanType)borrowType{
    self = [super init];
    if (self) {
        _borrowId = borrowId;
        _repaymentAmount = repaymentAmount;
        _borrowType = borrowType;
    }
    return self;
}

-(NSString * )requestUrl{
    return @"/repayCash/getConfirmRepayInfoV2";
}

-(id)requestArgument{
    NSMutableDictionary * paramDict = [[NSMutableDictionary alloc]init];
    [paramDict setValue:_borrowId forKey:@"borrowIds"];
    [paramDict setValue:_repaymentAmount forKey:@"repaymentAmount"];
    if (_borrowType == WhiteLoanType) {
        //  白领贷
        [paramDict setValue:@"1002" forKey:@"borrowType"];
    } else if (_borrowType == ConsumeLoanType) {
        //  消费贷
        [paramDict setValue:@"1001" forKey:@"borrowType"];
    } else if (_borrowType == CashLoanType) {
        //  现金贷
        [paramDict setValue:@"1000" forKey:@"borrowType"];
    } else if (_borrowType == MallLoanType) {
        // 消费分期
        [paramDict setValue:@"1003" forKey:@"borrowType"];
    }
    return paramDict;
}

@end

//
//  LSBrwGetConfirmRenewalApi.m
//  ZTMXFXunMiaoiOS
//
//  Created by 朱吉达 on 2017/9/26.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "LSBrwGetConfirmRenewalApi.h"
@interface LSBrwGetConfirmRenewalApi()
@property (nonatomic,copy) NSString * borrowId;
@property (nonatomic, assign) LoanType loanType;
@end
@implementation LSBrwGetConfirmRenewalApi
-(instancetype)initWithBorrowId:(NSString*)borrowId loanType:(LoanType)loanType{
    if (self = [super init]) {
        _borrowId = borrowId;
        _loanType = loanType;
    }
    return self;
}

-(NSString*)requestUrl{
    return @"/borrowCash/getConfirmRenewal";
}
-(id)requestArgument{
    NSMutableDictionary * dicRq = [[NSMutableDictionary alloc]init];
    [dicRq setValue:_borrowId forKey:@"borrowId"];
    if (_loanType == CashLoanType) {
        //  现金贷
        [dicRq setValue:@"1" forKey:@"borrowType"];
    } else {
        //  消费贷
        [dicRq setValue:@"2" forKey:@"borrowType"];
    }
    return dicRq;
}
@end

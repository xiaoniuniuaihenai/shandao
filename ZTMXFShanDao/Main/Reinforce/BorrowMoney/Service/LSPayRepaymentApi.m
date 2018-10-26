//
//  LSPayRepaymentApi.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/9/25.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "LSPayRepaymentApi.h"

@interface LSPayRepaymentApi ()

@property (nonatomic, copy) NSString *borrowId;
@property (nonatomic, copy) NSString *actualAmount;
@property (nonatomic, copy) NSString *repaymentAmount;
@property (nonatomic, copy) NSString *couponId;
@property (nonatomic, copy) NSString *rebateAmount;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, copy) NSString *cardId;
@property (nonatomic, copy) NSString *loanType;

@end

@implementation LSPayRepaymentApi

- (instancetype)initWithBorrowId:(NSString *)borrowId actualAmount:(NSString *)actualAmount repaymentAmount:(NSString *)repaymentAmount couponId:(NSString *)couponId rebateAmount:(NSString *)rebateAmount password:(NSString *)password cardId:(NSString *)cardId loanType:(NSString *)loanType{
    self = [super init];
    if (self) {
        _borrowId = borrowId;
        _actualAmount = actualAmount;
        _repaymentAmount = repaymentAmount;
        _couponId = couponId;
        _rebateAmount = rebateAmount;
        _password = password;
        _cardId = cardId;
        _loanType = loanType;
    }
    return self;
}

-(NSString * )requestUrl{
    return @"/pay/payRepayV2";
}

-(id)requestArgument{
    NSMutableDictionary * paramDict = [[NSMutableDictionary alloc]init];
    [paramDict setValue:_actualAmount forKey:@"actualAmount"];
    [paramDict setValue:_borrowId forKey:@"borrowIds"];
    [paramDict setValue:_repaymentAmount forKey:@"repaymentAmount"];
    [paramDict setValue:_couponId forKey:@"couponId"];
    [paramDict setValue:_rebateAmount forKey:@"rebateAmount"];
    [paramDict setValue:_password forKey:@"payPwd"];
    [paramDict setValue:_cardId forKey:@"cardId"];
    [paramDict setValue:_loanType forKey:@"borrowType"];
    return paramDict;
}

@end

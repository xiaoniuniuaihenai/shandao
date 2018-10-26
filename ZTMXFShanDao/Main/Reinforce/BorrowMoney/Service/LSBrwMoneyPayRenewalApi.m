//
//  LSBrwMoneyPayRenewalApi.m
//  ZTMXFXunMiaoiOS
//
//  Created by 朱吉达 on 2017/9/26.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "LSBrwMoneyPayRenewalApi.h"
@interface LSBrwMoneyPayRenewalApi()
@property (nonatomic,strong) NSString * borrowId;
@property (nonatomic,strong) NSString * payPwd;
@property (nonatomic,strong) NSString * cardId;
@property (nonatomic, copy) NSString *renewalAmount;
@property (nonatomic, copy) NSString *repaymentCapital;
@property (nonatomic, copy) NSString *loanType;
@property (nonatomic, copy) NSString *poundageRate;
@end
@implementation LSBrwMoneyPayRenewalApi
-(instancetype)initWithBorrowId:(NSString*)borrowId andPayPwd:(NSString*)payPwd andCardId:(NSString*)cardId renewalAmount:(NSString *)renewalAmount repaymentCapital:(NSString *)capital loanType:(NSString *)loanType renewalPoundageRate:(NSString *)poundageRate{
    if (self = [super init]) {
        _borrowId = borrowId;
        _payPwd = payPwd;
        _cardId = cardId;
        _renewalAmount = renewalAmount;
        _repaymentCapital = capital;
        _loanType = loanType;
        _poundageRate = poundageRate;
    }
    return self;
}

-(NSString*)requestUrl{
    return @"/pay/payRenewal";
}
-(id)requestArgument{
    NSMutableDictionary * dicRq = [[NSMutableDictionary alloc]init];
    [dicRq setValue:_borrowId forKey:@"borrowId"];
    [dicRq setValue:_payPwd forKey:@"payPwd"];
    [dicRq setValue:_cardId forKey:@"cardId"];
    [dicRq setValue:_renewalAmount forKey:@"renewalAmount"];
    [dicRq setValue:_repaymentCapital forKey:@"capital"];
    [dicRq setValue:_loanType forKey:@"borrowType"];
    [dicRq setValue:_poundageRate forKey:@"renewalPoundageRate"];
    return dicRq;
}
@end

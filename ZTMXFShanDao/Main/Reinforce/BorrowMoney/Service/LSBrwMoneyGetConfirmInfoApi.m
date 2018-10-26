//
//  LSBrwMoneyGetConfirmInfoApi.m
//  ZTMXFXunMiaoiOS
//
//  Created by 朱吉达 on 2017/9/25.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "LSBrwMoneyGetConfirmInfoApi.h"
@interface LSBrwMoneyGetConfirmInfoApi()
@property (nonatomic,copy) NSString * amount;
@property (nonatomic,copy) NSString * borrowDays;
@property (nonatomic,copy) NSString * borrowType;
@end
@implementation LSBrwMoneyGetConfirmInfoApi
- (instancetype)initBrwMoneyGetConfirmInfoWithAmount:(NSString *)amount andBorrowDays:(NSString *)borrowDays andBorrowType:(NSString *)borrowType{
    if (self = [super init]) {
        _amount = amount;
        _borrowDays = borrowDays;
        _borrowType = borrowType;
    }
    return self;
}

-(NSString*)requestUrl{
    return @"/borrowCash/getConfirmBorrowInfoV1";
}
-(id)requestArgument{
    NSMutableDictionary * dicRq = [[NSMutableDictionary alloc]init];
    [dicRq setValue:_amount  forKey:@"amount"];
    [dicRq setValue:_borrowDays  forKey:@"borrowDays"];
    [dicRq setValue:_borrowType  forKey:@"borrowType"];
    return dicRq;
}
@end

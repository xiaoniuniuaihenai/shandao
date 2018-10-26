//
//  LSBindBankCardApi.m
//  YWLTMeiQiiOS
//
//  Created by 朱吉达 on 2017/9/22.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "LSBindBankCardApi.h"
@interface LSBindBankCardApi()
@property (nonatomic,copy) NSString * bankId;
@property (nonatomic,copy) NSString * verifyCode;
@property (nonatomic,assign) int type;

@end
@implementation LSBindBankCardApi

-(instancetype)initWithBankId:(NSString*)bankId andVerifyCode:(NSString*)verifyCode type:(int)type
{
    if (self = [super init]) {
        _bankId = bankId;
        _verifyCode = verifyCode;
        _type = type;
    }
    return self;
}




-(NSString*)requestUrl{
    if (_type == 1) {
        return @"/auth/checkBankcard2";
    }
    return @"/auth/checkBankcard";
}
-(id)requestArgument{
    NSMutableDictionary * dicRq = [[NSMutableDictionary alloc]init];
    [dicRq setValue:_verifyCode forKey:@"verifyCode"];
    [dicRq setValue:_bankId forKey:@"bankId"];
    
    return dicRq;
}
-(instancetype)initWithBankId:(NSString*)bankId andVerifyCode:(NSString*)verifyCode{
    if (self = [super init]) {
        _bankId = bankId;
        _verifyCode = verifyCode;
    }
    return self;
}
@end

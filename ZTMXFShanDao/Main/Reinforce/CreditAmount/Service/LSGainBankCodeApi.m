//
//  LSGainBankCodeApi.m
//  ZTMXFXunMiaoiOS
//
//  Created by 朱吉达 on 2017/9/22.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "LSGainBankCodeApi.h"
@interface LSGainBankCodeApi()
@property (nonatomic,copy)NSString * cardNumber;
@property (nonatomic,copy)NSString * mobile;
@property (nonatomic,copy)NSString * bankCode;
@property (nonatomic,copy)NSString * bankName;

@end
@implementation LSGainBankCodeApi



-(instancetype)initWithCardNumber:(NSString*)cardNumber andMobile:(NSString*)mobile andBankCode:(NSString*)bankCode andBankName:(NSString*)bankName{
    if (self =[super init]) {
        _cardNumber = cardNumber;
        _mobile =mobile;
        _bankCode = bankCode;
        _bankName = bankName;
    }
    return self;
}



-(id)requestArgument{
    NSMutableDictionary * dicPra = [[NSMutableDictionary alloc]init];
    [dicPra setValue:_cardNumber forKey:@"cardNumber"];
    [dicPra setValue:_mobile forKey:@"mobile"];
    [dicPra setValue:_bankCode forKey:@"bankCode"];
    [dicPra setValue:_bankName forKey:@"bankName"];
    return dicPra;
}

-(NSString*)requestUrl{
    return @"/auth/authBankcard";
}
@end

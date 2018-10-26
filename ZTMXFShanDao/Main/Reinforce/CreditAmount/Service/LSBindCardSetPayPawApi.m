//
//  LSBindCardSetPayPawApi.m
//  ZTMXFXunMiaoiOS
//
//  Created by 朱吉达 on 2017/9/23.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "LSBindCardSetPayPawApi.h"
@interface LSBindCardSetPayPawApi()
@property (nonatomic,copy) NSString * idNumber;
@property (nonatomic,copy) NSString * payPaw;
@end
@implementation LSBindCardSetPayPawApi
-(instancetype)initWithIdNumber:(NSString*)idNumber andPaw:(NSString*)payPaw{
    if (self = [super init]) {
        _idNumber = idNumber;
        _payPaw = payPaw;
    }
    return self;
}

-(id)requestArgument{
    NSMutableDictionary * rqPra = [[NSMutableDictionary alloc]init];
    [rqPra setValue:_idNumber forKey:@"idNumber"];
    [rqPra setValue:_payPaw forKey:@"password"];
    [rqPra setValue:@"S" forKey:@"type"];
    return rqPra;
}

-(NSString*)requestUrl{
    return @"/user/setPayPwd";
}
@end

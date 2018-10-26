//
//  OrderPayApi.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2018/1/11.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "ZTMXFOrderPayApi.h"

@interface ZTMXFOrderPayApi ()

@property (nonatomic, copy) NSString *orderId;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, copy) NSString *cardId;
@property (nonatomic, copy) NSString *nper;
@property (nonatomic, copy) NSString *latitude;
@property (nonatomic, copy) NSString *longitude;
@property (nonatomic, copy) NSString *province;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *county;

@end


@implementation ZTMXFOrderPayApi

- (instancetype)initWithOrderId:(NSString *)orderId password:(NSString *)password cardId:(NSString *)cardId nper:(NSString *)nper latitude:(NSString*)latitude longitude:(NSString*)longitude province:(NSString*)province city:(NSString*)city county:(NSString*)county{
    if (self = [super init]) {
        _orderId = orderId;
        _password = password;
        _cardId = cardId;
        _nper = nper;
        _latitude = latitude;
        _longitude = longitude;
        _province = province;
        _city = city;
        _county = county;
    }
    return self;
}



- (id)requestArgument{
    NSMutableDictionary * paramDict = [[NSMutableDictionary alloc]init];
    [paramDict setValue:self.orderId forKey:@"orderId"];
    [paramDict setValue:self.cardId forKey:@"cardId"];
    [paramDict setValue:self.password forKey:@"payPwd"];
    [paramDict setValue:self.nper forKey:@"nper"];
    NSString *blackBox = [FMDeviceManager sharedManager]->getDeviceInfo();
    [paramDict setValue:blackBox forKey:@"blackBox"];
    [paramDict setValue:self.province forKey:@"province"];
    [paramDict setValue:self.city forKey:@"city"];
    [paramDict setValue:self.county forKey:@"county"];
    [paramDict setValue:self.latitude forKey:@"latitude"];
    [paramDict setValue:self.longitude forKey:@"longitude"];
    return paramDict;
}
- (NSString * )requestUrl{
    return @"/pay/payOrder";
}
@end

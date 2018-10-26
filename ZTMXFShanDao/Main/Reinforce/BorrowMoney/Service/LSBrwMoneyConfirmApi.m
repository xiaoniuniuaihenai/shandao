//
//  LSBrwMoneyConfirmApi.m
//  YWLTMeiQiiOS
//
//  Created by 朱吉达 on 2017/9/25.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "LSBrwMoneyConfirmApi.h"

@interface LSBrwMoneyConfirmApi ()
@property (nonatomic,copy) NSString *amount;
@property (nonatomic,copy) NSString * borrowDays;
@property (nonatomic,copy) NSString * pwd;
@property (nonatomic,copy) NSString * latitude;
@property (nonatomic,copy) NSString * longitude;
@property (nonatomic,copy) NSString * province;
@property (nonatomic,copy) NSString * city;
@property (nonatomic,copy) NSString * county;
@property (nonatomic,copy) NSString * address;
@property (nonatomic,copy) NSString *deviceInfo;

@property (nonatomic, copy) NSString *borrowType;
@property (nonatomic, copy) NSString *borrowUse;
@property (nonatomic, copy) NSString *goodsPrice;
@property (nonatomic, copy) NSString *goodsId;
@property (nonatomic, copy) NSString *couponId;
@end
@implementation LSBrwMoneyConfirmApi
-(instancetype)initWithBrwMoneyConfirmWithAmount:(NSString*)amount andDay:(NSString*)borrowDays andPwd:(NSString*)pwd andLatitude:(NSString*)latitude andLongitude:(NSString*)longitude andProvince:(NSString*)province andCity:(NSString*)city andCounty:(NSString*)county andAddress:(NSString*)address borrowType:(NSString *)borrowType borrowUse:(NSString *)borrowUse goodsPrice:(NSString *)goodsPrice goodsId:(NSString *)goodsId couponId:(NSString *)couponId{
    if (self = [super init]) {
        _amount = amount;
        _borrowDays = borrowDays;
        _pwd = pwd;
        _latitude = latitude;
        _longitude = longitude;
        _province = province;
        _city = city;
        _county = county;
        _address = address;
        _deviceInfo = [FMDeviceManager sharedManager]->getDeviceInfo();
        _borrowType = borrowType;
        _borrowUse = borrowUse;
        _goodsPrice = goodsPrice;
        _goodsId = goodsId;
        _couponId = couponId;
    }
    return self;
}

-(NSString*)requestUrl{
    return @"/borrowCash/applyBorrowCashV1";
}
-(id)requestArgument{
    NSMutableDictionary * dicRq = [[NSMutableDictionary alloc]init];
    [dicRq setValue:_amount forKey:@"amount"];
    [dicRq setValue:_borrowDays forKey:@"borrowDays"];
    [dicRq setValue:_pwd forKey:@"pwd"];
    [dicRq setValue:_latitude forKey:@"latitude"];
    [dicRq setValue:_longitude forKey:@"longitude"];
    [dicRq setValue:_province forKey:@"province"];
    [dicRq setValue:_city forKey:@"city"];
    [dicRq setValue:_county forKey:@"county"];
    [dicRq setValue:_address forKey:@"address"];
    [dicRq setValue:_deviceInfo forKey:@"blackBox"];
    [dicRq setValue:_borrowType forKey:@"borrowType"];
    [dicRq setValue:_borrowUse forKey:@"borrowUse"];
    [dicRq setValue:_goodsPrice forKey:@"consumeAmount"];
    [dicRq setValue:_goodsId forKey:@"goodId"];
    [dicRq setValue:_couponId forKey:@"couponId"];
    return dicRq;
}
@end

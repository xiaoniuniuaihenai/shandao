//
//  CreateMobileRechargeOrderApi.m
//  ZTMXFXunMiaoiOS
//
//  Created by 朱吉达 on 2018/1/31.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "CreateMobileRechargeOrderApi.h"
#import "CreateRechargeOrderInfoModel.h"
@interface CreateMobileRechargeOrderApi ()
@property (nonatomic,strong) CreateRechargeOrderInfoModel * infoModel;
@end
@implementation CreateMobileRechargeOrderApi
-(instancetype)initWithOrderInfo:(CreateRechargeOrderInfoModel *)orderModel{
    if (self = [super init]) {
        _infoModel = orderModel;
    }
    return self;
}

-(NSString *)requestUrl{
    return @"/mall/commitMoblieOrder";
}


-(id)requestArgument{
    NSMutableDictionary * dicArg = [[NSMutableDictionary alloc]init];
    [dicArg setValue:_infoModel.mobile forKey:@"mobile"];
    [dicArg setValue:_infoModel.province forKey:@"province"];
    [dicArg setValue:_infoModel.company forKey:@"company"];
    [dicArg setValue:_infoModel.amount forKey:@"amount"];
    return dicArg;
}

@end

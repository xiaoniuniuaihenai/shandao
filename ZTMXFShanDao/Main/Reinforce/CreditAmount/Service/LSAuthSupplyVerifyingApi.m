//
//  LSAuthSupplyVerifyingApi.m
//  ZTMXFXunMiaoiOS
//
//  Created by 朱吉达 on 2017/9/23.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "LSAuthSupplyVerifyingApi.h"
@interface LSAuthSupplyVerifyingApi()
@property (nonatomic,assign) AuthSupplyType verfyingType;
@end
@implementation LSAuthSupplyVerifyingApi


-(instancetype)initWithVerifyingType:(AuthSupplyType)verfyingType{
    if (self = [super init]) {
        _verfyingType = verfyingType;
    }
    return self;
}

-(id)requestArgument{
    NSMutableDictionary * dicRq = [[NSMutableDictionary alloc]init];
    switch (_verfyingType) {
        case AuthSupplyTypeGongJiJin:{
            //            公积金
            [dicRq setValue:@"FUND" forKey:@"authType"];
        }break;
        case AuthSupplyTypeSheBao:  {         //            社保
            [dicRq setValue:@"SOCIAL_SECURITY" forKey:@"authType"];
        }break;
        case AuthSupplyTypeXinYongKa:{
            //            信用卡
            [dicRq setValue:@"CREDIT" forKey:@"authType"];
        }break;
        case AuthSupplyTypeZhiFuBao:{
            //            支付宝
            [dicRq setValue:@"ALIPAY" forKey:@"authType"];
        }break;
        case AuthSupplyTypeJingDong:{
            //            京东
            [dicRq setValue:@"JINGDONG" forKey:@"authType"];
        }break;
        case AuthSupplyTypeTaoBao:{
            //            淘宝
            [dicRq setValue:@"TAOBAO" forKey:@"authType"];
        }break;
        default:
            break;
    }
    return dicRq;
}

-(NSString*)requestUrl{
    return @"/auth/authSupplyVerifying";
}
@end

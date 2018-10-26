//
//  LSAuthSupplyApi.m
//  ZTMXFXunMiaoiOS
//
//  Created by 朱吉达 on 2017/9/23.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "LSAuthSupplyApi.h"
@interface LSAuthSupplyApi ()
@property (nonatomic,assign) AuthSupplyType supplyType;
@end
@implementation LSAuthSupplyApi

-(NSString*)requestUrl{
    switch (_supplyType) {
        case AuthSupplyTypeSheBao:{
            return @"/auth/authSocialSecurity";
        }break;
        case AuthSupplyTypeZhiFuBao:{
            return @"/auth/authAlipay";
        }break;
        case AuthSupplyTypeGongJiJin:{
            return @"/auth/authFund";
        }break;
        case AuthSupplyTypeXinYongKa:{
            return @"/auth/authCreditCard";
        }break;
        case AuthSupplyTypeJingDong:{
            return @"/auth/authJingdong";
        }break;
        case AuthSupplyTypeTaoBao:{
            return @"/auth/authTaobao";
        }break;
        default:
            break;
    }
}
-(id)requestArgument{
    return @{};
}
-(instancetype )initWithSupplyType:(AuthSupplyType)supplyType{
    if (self = [super init]) {
        _supplyType = supplyType;
    }
    return self;
}
@end

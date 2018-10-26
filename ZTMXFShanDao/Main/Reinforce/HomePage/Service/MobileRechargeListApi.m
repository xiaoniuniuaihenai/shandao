//
//  MobileRechargeListApi.m
//  ZTMXFXunMiaoiOS
//
//  Created by 朱吉达 on 2018/1/30.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "MobileRechargeListApi.h"
@interface MobileRechargeListApi ()
//手机归属地
@property (nonatomic,copy) NSString * province;
//手机公司：1:Mobile移动  2:Telecom电信 3:Unicom联通。

@property (nonatomic,assign) MobileCompanyType  companyType;

@end
@implementation MobileRechargeListApi
-(instancetype)initWithProvince:(NSString *)province company:(MobileCompanyType )companyType{
    if (self = [super init]) {
        _province = province;
        _companyType = companyType;
    }
    return self;
}



-(NSString *)requestUrl{
    return @"/mall/getMobileRechargeList";
}
-(id)requestArgument{
    //手机公司：1:Mobile移动  2:Telecom电信 3:Unicom联通。
    NSMutableDictionary * dicArgument = [[NSMutableDictionary alloc]init];
    [dicArgument setValue:_province forKey:@"province"];
    switch (_companyType) {
        case MobileCompanyTypeMobile:{
//            移动
            [dicArgument setValue:@"1" forKey:@"company"];
        }
            break;
        case MobileCompanyTypeTelecom:{
//            电信
            [dicArgument setValue:@"2" forKey:@"company"];
        }break;
        case MobileCompanyTypeUnicom:{
//            联通
            [dicArgument setValue:@"3" forKey:@"company"];
        }break;
        default:{
            
        }
            break;
    }
    return dicArgument;
}
@end

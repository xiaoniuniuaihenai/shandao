//
//  MobileRechargeListApi.h
//  ZTMXFXunMiaoiOS
//
//  Created by 朱吉达 on 2018/1/30.
//  Copyright © 2018年 LSCredit. All rights reserved.
//
typedef NS_ENUM(NSInteger,MobileCompanyType) {
    MobileCompanyTypeMobile= 0, // 移动
    MobileCompanyTypeUnicom,    // 联通
    MobileCompanyTypeTelecom,    // 电信
    MobileCompanyTypeMobileUnknown, // 未知

};
#import "BaseRequestSerivce.h"

@interface MobileRechargeListApi : BaseRequestSerivce
-(instancetype)initWithProvince:(NSString *)province company:(MobileCompanyType )companyType;

@end

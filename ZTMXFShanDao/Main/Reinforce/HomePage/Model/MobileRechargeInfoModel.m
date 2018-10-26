//
//  MobileRechargeInfoModel.m
//  ZTMXFXunMiaoiOS
//
//  Created by 朱吉达 on 2018/2/1.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "MobileRechargeInfoModel.h"

@implementation MobileRechargeInfoModel
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"rechargeList":[ZTMXFMobileRechargeMoneyModel class]};
}
@end

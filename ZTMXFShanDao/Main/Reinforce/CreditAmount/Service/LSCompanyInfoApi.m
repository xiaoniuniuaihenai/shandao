//
//  LSCompanyInfoApi.m
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2017/12/29.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "LSCompanyInfoApi.h"

@implementation LSCompanyInfoApi



-(id)requestArgument{
    return @{};
}


-(NSString*)requestUrl{
    return @"/user/getLastCompany";
}
@end

//
//  LSAmountPageApi.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/9/26.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "LSAmountPageApi.h"

@implementation LSAmountPageApi

-(NSString*)requestUrl{
    return @"/auth/getQuotaPageInfo";
}



-(id)requestArgument{
    return @{};
}

@end

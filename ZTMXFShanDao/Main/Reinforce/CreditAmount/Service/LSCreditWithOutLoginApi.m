//
//  LSCreditWithOutLoginApi.m
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2018/1/13.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "LSCreditWithOutLoginApi.h"

@implementation LSCreditWithOutLoginApi

-(NSString*)requestUrl{
    return @"/auth/getCreditQuotaInfoWithoutLogin";
}


-(id)requestArgument{
    
    return @{};
}

@end

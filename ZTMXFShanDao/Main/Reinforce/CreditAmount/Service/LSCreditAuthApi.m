//
//  LSCreditAuthApi.m
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2018/1/9.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "LSCreditAuthApi.h"

@implementation LSCreditAuthApi



-(id)requestArgument{
    
    return @{};
}
-(NSString*)requestUrl{
    return @"/auth/getCreditQuotaInfo";
}
@end

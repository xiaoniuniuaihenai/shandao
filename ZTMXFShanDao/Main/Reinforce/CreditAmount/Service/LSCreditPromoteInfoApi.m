//
//  LSCreditPromoteInfoApi.m
//  ZTMXFXunMiaoiOS
//
//  Created by 朱吉达 on 2017/9/23.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "LSCreditPromoteInfoApi.h"

@implementation LSCreditPromoteInfoApi

-(NSString *)requestUrl{
    return @"/auth/getCreditPromoteInfo";
}


-(id)requestArgument{
    return @{};
}
@end

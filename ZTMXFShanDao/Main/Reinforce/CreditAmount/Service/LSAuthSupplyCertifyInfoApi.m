//
//  LSAuthSupplyCertifyInfoApi.m
//  ZTMXFXunMiaoiOS
//
//  Created by 朱吉达 on 2017/9/23.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "LSAuthSupplyCertifyInfoApi.h"

@implementation LSAuthSupplyCertifyInfoApi
-(NSString*)requestUrl{
    return @"/auth/authSupplyCertify";
}

-(id)requestArgument{
    return @{};
}
@end

//
//  DefaultAddressApi.m
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2017/12/13.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "DefaultAddressApi.h"

@implementation DefaultAddressApi

-(NSString*)requestUrl{
    return @"/user/getUserDefaultAddress";
}
-(id)requestArgument{
    return @{};
}

@end

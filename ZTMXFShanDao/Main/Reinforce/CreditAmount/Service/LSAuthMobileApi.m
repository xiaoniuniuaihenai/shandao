//
//  LSAuthMobileApi.m
//  ZTMXFXunMiaoiOS
//
//  Created by 朱吉达 on 2017/9/24.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "LSAuthMobileApi.h"

@implementation LSAuthMobileApi
-(NSString*)requestUrl{
    return @"/auth/authMobile";
}


-(id)requestArgument{
    return @{};
}
@end

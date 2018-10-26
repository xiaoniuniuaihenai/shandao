//
//  GetUserInfoApi.m
//  ZTMXFXunMiaoiOS
//
//  Created by 朱吉达 on 2017/10/19.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "GetUserInfoApi.h"

@implementation GetUserInfoApi
-(NSString*)requestUrl{
    return @"/user/getUserInfo";
}
-(id)requestArgument{
    return @{};
}
@end

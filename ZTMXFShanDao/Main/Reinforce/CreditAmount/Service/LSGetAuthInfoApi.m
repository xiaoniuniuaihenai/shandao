//
//  LSGetAuthInfoApi.m
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2018/1/10.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "LSGetAuthInfoApi.h"

@interface LSGetAuthInfoApi ()

@property (nonatomic, copy) NSString *authType;

@end

@implementation LSGetAuthInfoApi

- (instancetype)initWithAuthType:(NSString *)authType
{
    if (self = [super init]) {
        _authType = authType;
    }
    return self;
}



-(id)requestArgument{
    
    return @{@"authType":self.authType};
}

-(NSString*)requestUrl{
    return @"/auth/getAuthInfo";
}

@end

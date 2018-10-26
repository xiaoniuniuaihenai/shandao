//
//  LSCompanyAuthApi.m
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2017/12/28.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "LSCompanyAuthApi.h"

@interface LSCompanyAuthApi ()

@property (nonatomic, strong) NSDictionary *paramsDict;

@end

@implementation LSCompanyAuthApi

- (instancetype)initWithCompanyAuthParams:(NSDictionary *)params{
    self = [super init];
    if (self) {
        _paramsDict = params;
    }
    return self;
}



-(id)requestArgument{
    NSMutableDictionary *paramDict = [[NSMutableDictionary alloc] initWithDictionary:_paramsDict];
    
    return paramDict;
}
-(NSString*)requestUrl{
    return @"/auth/authCompany";
}
@end

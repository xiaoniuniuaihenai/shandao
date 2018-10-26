//
//  LSCompanyPhoneAuthApi.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/12/13.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "LSCompanyPhoneAuthApi.h"

@interface LSCompanyPhoneAuthApi ()

@property (nonatomic, copy) NSString *companyPhone;

@end

@implementation LSCompanyPhoneAuthApi

- (instancetype)initWithCompanyPhone:(NSString *)companyPhone{
    if (self = [super init]) {
        _companyPhone = companyPhone;
    }
    return self;
}



-(id)requestArgument{
    NSMutableDictionary *paramsDict = [[NSMutableDictionary alloc]init];
    [paramsDict setValue:_companyPhone forKey:@"phoneAuth"];
    return paramsDict;
}


- (NSString* )requestUrl{
    return @"/auth/whiteRiskAuthPhone";
}
@end

//
//  XLSubmitXbehaviorRiskApi.m
//  YWLTMeiQiiOS
//
//  Created by 余金超 on 2018/8/2.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "XLSubmitXbehaviorRiskApi.h"
#import "UIDevice+FCUUID.h"

@interface XLSubmitXbehaviorRiskApi ()

@property (nonatomic, strong) NSString *creditValue;
@property (nonatomic, strong) NSString *userName;

@end

@implementation XLSubmitXbehaviorRiskApi

- (instancetype)initWithCreditValue:(NSString *)creditValue UserName:(NSString *)userName{
    if (self = [super init]) {
        _creditValue = creditValue;
        _userName = userName;
    }
    return self;
}

- (NSString *)requestUrl{
    return @"/user/submitXbehaviorRisk";
}

- (id)requestArgument{
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [params setObject:_creditValue?:@"" forKey:@"xbehaviorDeviceId"];
    [params setObject:_userName?:@"" forKey:@"userName"];
    [params setObject:[UIDevice currentDevice].uuid?:@"" forKey:@"deviceId"];
    [params setObject:@"" forKey:@"userId"];
    return params;
}

@end

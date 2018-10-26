//
//  LSAuthStrongRiskApi.m
//  ZTMXFXunMiaoiOS
//
//  Created by 朱吉达 on 2017/9/23.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "LSAuthStrongRiskApi.h"
@interface LSAuthStrongRiskApi()

@property (nonatomic, assign) LoanType authType;
/** 如果是2 会默默的后台调一次消费贷 */
@property (nonatomic, copy) NSString *entrance;
@property (nonatomic, copy) NSString *deviceInfo;
/** 经度 */
@property (nonatomic, copy) NSString *latitude;
/** 纬度 */
@property (nonatomic, copy) NSString *longitude;

@end
@implementation LSAuthStrongRiskApi
- (instancetype)initWithAuthType:(LoanType)authType entranceType:(NSString *)entrance Latitude:(NSString *)latitude Longitude:(NSString *)longitude{
    if (self = [super init]) {
        _deviceInfo = [FMDeviceManager sharedManager]->getDeviceInfo();
        _authType = authType;
        _entrance = entrance;
        _latitude = latitude;
        _longitude = longitude;
    }
    return self;
}






-(id)requestArgument{
    NSMutableDictionary * requestDict = [[NSMutableDictionary alloc]init];
    [requestDict setValue:_deviceInfo forKey:@"blackBox"];
    if (_authType == WhiteLoanType) {
        //  白领贷
        [requestDict setValue:@"1" forKey:@"authType"];
    } else if (_authType == ConsumeLoanType) {
        //  消费贷
        [requestDict setValue:@"2" forKey:@"authType"];
    } else if (_authType == MallLoanType) {
        // 消费分期
        [requestDict setValue:@"3" forKey:@"authType"];
    }
    [requestDict setValue:_entrance forKey:@"entranceType"];
    [requestDict setValue:_latitude forKey:@"latitude"];
    [requestDict setValue:_longitude forKey:@"longitude"];

    return requestDict;
}

-(NSString*)requestUrl
{
    return @"/auth/creditAuthStrongRisk";
}
@end

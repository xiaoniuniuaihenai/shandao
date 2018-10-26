//
//  ZTMXFCertificationListApi.m
//  ZTMXFXunMiaoiOS
//
//  Created by 陈传亮 on 2018/4/8.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "ZTMXFCertificationListApi.h"

@interface ZTMXFCertificationListApi ()

@property (nonatomic, copy)NSString * authType;

@end

@implementation ZTMXFCertificationListApi



- (id)initWithAuthType:(NSString *)authType
{
    self = [super init];
    if (self) {
        _authType = authType;
    }
    return self;
}




- (id)requestArgument{
    return @{@"appAuthType":_authType};
}
- (NSString *)requestUrl{
    return @"/auth/authCenterConfigureApi";
}
@end

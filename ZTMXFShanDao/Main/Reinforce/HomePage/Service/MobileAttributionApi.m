//
//  MobileAttributionApi.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2018/1/30.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "MobileAttributionApi.h"
#define  kJuHeMobileUrl    @"http://apis.juhe.cn/mobile/get"
//讯秒
#define  kJuHeMobileAppKey @"bf99b477846df79ad15b28b1df6bafee"
@interface MobileAttributionApi ()

@property (nonatomic, copy) NSString *mobileNumber;

@end

@implementation MobileAttributionApi

- (instancetype)initWithMobile:(NSString *)phoneNumber{
    if (self = [super init]) {
        _mobileNumber = phoneNumber;
    }
    return self;
}



//  自定义请求
- (NSURLRequest *)buildCustomUrlRequest{
    NSString *mobileUrlString = [NSString stringWithFormat:@"%@?key=%@&phone=%@",kJuHeMobileUrl,kJuHeMobileAppKey,self.mobileNumber];
    mobileUrlString = [mobileUrlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL *mobileUrl = [NSURL URLWithString:mobileUrlString];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:mobileUrl];
    [request setHTTPMethod:@"GET"];
    return request;
}

@end

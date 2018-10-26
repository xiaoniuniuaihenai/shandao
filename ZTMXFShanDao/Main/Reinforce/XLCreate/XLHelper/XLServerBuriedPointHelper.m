//
//  XLServerBuriedPointHelper.m
//  YWLTMeiQiiOS
//
//  Created by 余金超 on 2018/7/13.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "XLServerBuriedPointHelper.h"
#import "UIDevice+FCUUID.h"
#import <SystemConfiguration/CaptiveNetwork.h>
#import <NetworkExtension/NetworkExtension.h>
#import "LSLocationManager.h"
#import "LoginManager.h"
#import "ZTMXFPhoneModel.h"
#import "NSString+UrlEncode.h"
#import "NSDictionary+JSONString.h"
#import "XLH5UserInfo.h"


@interface XLServerBuriedPointHelper()

@property (nonatomic, strong) NSMutableDictionary *otherDictionary;
@property (nonatomic, copy)   NSString            *pointCode;
@property (nonatomic, copy)   NSString            *pointSubCode;

@end

@implementation XLServerBuriedPointHelper

+(void)xl_BuriedPointWithPointCode:(NSString *)pointCode PointSubCode:(NSString *)pointSubCode Request:(YTKBaseRequest *)request{
    
}

+ (void)xl_BuriedPointWithPointCode:(NSString *)pointCode PointSubCode:(NSString *)pointSubCode OtherDict:(NSMutableDictionary *)otherDictionary{
    XLServerBuriedPointHelper *server = [[XLServerBuriedPointHelper alloc] initWithPointCode:pointCode PointSubCode:pointSubCode OtherDict:otherDictionary];
    NSLog(@"\n******************************************************************************************************************************************************************************************************************************************************************************\n%@\n%@\n%@******************************************************************************************************************************************************************************************************************************************************************************",pointCode,pointSubCode,otherDictionary);
    [server requestWithSuccess:^(NSDictionary *responseDict) {
        NSLog(@"\n\npointSubCode\n后台打点返回数据:%@",responseDict);
    } failure:^(__kindof YTKBaseRequest *request) {
        NSLog(@"\n\npointSubCode\n后台打点返回数据:%@",request.error);
    }];
}

- (instancetype)initWithPointCode:(NSString *)pointCode PointSubCode:(NSString *)pointSubCode OtherDict:(NSMutableDictionary *)otherDictionary{
    if (self = [super init]) {
        _pointSubCode = pointSubCode;
        _pointCode = pointCode;
        _otherDictionary = otherDictionary;
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (NSString *)requestUrl{
    return @"/point/add";
}

- (NSString *)baseUrl {
    return k_statisticalURL;
}

- (id)requestArgument{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setValue:[XLServerBuriedPointHelper baseDictionary] forKey:@"appInfo"];
    [dict setValue:_pointCode forKey:@"pointCode"];
    [dict setValue:_pointSubCode forKey:@"pointSubCode"];
    NSMutableDictionary *baseDic = [XLServerBuriedPointHelper baseDictionary];
    [_otherDictionary enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [baseDic setObject:obj forKey:key];
    }];
    [dict setValue:[[baseDic JSONString] urlEncode] forKey:@"pointInfo"];
    return dict;
}

+ (NSMutableDictionary *)baseDictionary
{
    UInt64 time = [[NSDate date] timeIntervalSince1970] * 1000;
    NSString *apply_time = [NSString stringWithFormat:@"%llu",time];
    NSString *mobile_number = [[NSUserDefaults standardUserDefaults] objectForKey:kUserPhoneNumber];
    NSString *version_number = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSString *device_id = [UIDevice currentDevice].uuid;
    NSMutableDictionary *dict = [@{
                           @"channelCode":kChannelId,
                           @"fromApp":kAppSource,
                           @"versionNumber":version_number?:@"",
                           @"deviceId":device_id?:@"",
                           @"deviceType":[ZTMXFPhoneModel iphoneType],
                           @"applyTime":apply_time?:@"",
                           @"mobileNumber":mobile_number?:@""
                           } mutableCopy];
    return dict;
}

- (NSMutableDictionary *)otherDictionary{
    if (!_otherDictionary) {
        _otherDictionary = [[NSMutableDictionary alloc]init];
    }
    return _otherDictionary;
}

+(NSString *)wifiName{
    NSArray *ifs = CFBridgingRelease(CNCopySupportedInterfaces());
    id info = nil;
    for (NSString *ifname in ifs) {
        info = (__bridge_transfer id)CNCopyCurrentNetworkInfo((CFStringRef) ifname);
        if(info && [info count]){
            break;
        }
    }
    NSDictionary *dic = (NSDictionary *)info;
    NSString *ssid = [[dic objectForKey:@"SSID"]lowercaseString];
    NSString *bssid = [dic objectForKey:@"BSSID"];
    NSLog(@"%@------%@",ssid,bssid);
    return ssid;
}
+(NSString *)wifiMac{
    NSArray *ifs = CFBridgingRelease(CNCopySupportedInterfaces());
    id info = nil;
    for (NSString *ifname in ifs) {
        info = (__bridge_transfer id)CNCopyCurrentNetworkInfo((CFStringRef) ifname);
        if(info && [info count]){
            break;
        }
    }
    NSDictionary *dic = (NSDictionary *)info;
    NSString *ssid = [[dic objectForKey:@"SSID"]lowercaseString];
    NSString *bssid = [dic objectForKey:@"BSSID"];
    NSLog(@"%@------%@",ssid,bssid);
    return bssid;
}
+(void)longitudeAndLatitude:(LatitudeAndLongitude )latitudeAndLongitude{
    //    if (![LoginManager appReviewState]) {
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedAlways || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse) {
        [[LSLocationManager shareLocationManager] locationSuccessWithComplish:^(AMapLocationReGeocode *locationGeocode, NSString *latitudeString, NSString *longitudeString) {
            NSLog(@"%@",locationGeocode.formattedAddress); latitudeAndLongitude(@{@"latitude":latitudeString,@"longitude":longitudeString,@"address":locationGeocode.formattedAddress});
        }];
    }else{
        latitudeAndLongitude(@{@"latitude":@"",@"longitude":@"",@"address":@""});
    }
    //    }else{
    //        latitudeAndLongitude(@{@"latitude":@"",@"longitude":@"",@"address":@""});
    //    }
    
}


+ (void)xl_getH5BuriedPointInfo:(PointInfo_H5)pointInfo_H5{
    NSMutableDictionary *pointInfo = [XLServerBuriedPointHelper baseDictionary];
    [pointInfo setObject:[XLServerBuriedPointHelper wifiMac]?:@"" forKey:@"wifiMac"];
    [pointInfo setObject:[XLServerBuriedPointHelper wifiName]?:@"" forKey:@"wifiName"];
    [XLServerBuriedPointHelper longitudeAndLatitude:^(NSDictionary *latitudeAndLongitude) {
        [latitudeAndLongitude enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            [pointInfo setObject:obj forKey:key];
        }];
        pointInfo_H5(pointInfo);
    }];
}


/**
 用单例 保存用户的信息
 */
+(void)saveUserInfo
{
    [XLServerBuriedPointHelper xl_getH5BuriedPointInfo:^(NSDictionary *pointInfo_H5) {
        [XLH5UserInfo sharedXLH5UserInfo].pointInfo_H5 = pointInfo_H5;
        NSLog(@"\n\n在appdelegate中获取到的用户基础数据为:\n%@\n\n",pointInfo_H5);
    }];
}
@end

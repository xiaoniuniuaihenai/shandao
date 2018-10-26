//
//  XLServerBuriedPointHelper.h
//  YWLTMeiQiiOS
//
//  Created by 余金超 on 2018/7/13.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "BaseRequestSerivce.h"

typedef void(^LatitudeAndLongitude)(NSDictionary *latitudeAndLongitude);
typedef void(^PointInfo_H5)(NSDictionary *pointInfo_H5);

@interface XLServerBuriedPointHelper : BaseRequestSerivce

//上传网络层错误
+(void)xl_BuriedPointWithPointCode:(NSString *)pointCode PointSubCode:(NSString *)pointSubCode Request:(YTKBaseRequest *)request;
//埋点
+ (void)xl_BuriedPointWithPointCode:(NSString *)pointCode PointSubCode:(NSString *)pointSubCode OtherDict:(NSMutableDictionary *)otherDictionary;
+(NSString *)wifiName;
+(NSString *)wifiMac;
+(void)longitudeAndLatitude:(LatitudeAndLongitude )latitudeAndLongitude;
//供H5使用的获取打点所需参数方法:因为经纬度的原因可能延时
+ (void)xl_getH5BuriedPointInfo:(PointInfo_H5)pointInfo_H5;
/**
 用单例 保存用户的信息
 */
+(void)saveUserInfo;
@end

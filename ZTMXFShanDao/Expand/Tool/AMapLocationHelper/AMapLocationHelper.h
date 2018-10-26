//
//  AMapLocationHelper.h
//  CoreFrame
//
//  Created by yangpenghua on 2017/8/31.
//  Copyright © 2017年 yangpenghua. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AMapLocationKit/AMapLocationKit.h>

typedef void (^ComplishLoctionBlock)(NSString *latitudeString, NSString *longitudeString);

@interface AMapLocationHelper : NSObject

/** 开始设置定位, 并且放回需要持有 AMapLocationManager 这个对象 */
+ (AMapLocationManager *)startLocationWithComplish:(ComplishLoctionBlock)complishLocation;

/** 获取纬度 */
+ (NSString *)latitudeString;
/** 获取经度 */
+ (NSString *)longitudeString;

@end

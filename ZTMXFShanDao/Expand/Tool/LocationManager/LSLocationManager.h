//
//  LSLocationManager.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2018/1/12.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AMapLocationKit/AMapLocationKit.h>

typedef void (^LoctionComplishBlock)(AMapLocationReGeocode *locationGeocode, NSString *latitudeString, NSString *longitudeString);

@interface LSLocationManager : NSObject

+ (LSLocationManager *)shareLocationManager;

/** 经纬度 */
@property (nonatomic, copy) NSString *latitudeString;
@property (nonatomic, copy) NSString *longitudeString;

/** 获取定位 */
- (void)locationSuccessWithComplish:(LoctionComplishBlock)complishBlock;

@end

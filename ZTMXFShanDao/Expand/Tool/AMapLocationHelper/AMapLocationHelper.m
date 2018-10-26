//
//  AMapLocationHelper.m
//  CoreFrame
//
//  Created by yangpenghua on 2017/8/31.
//  Copyright © 2017年 yangpenghua. All rights reserved.
//

#import "AMapLocationHelper.h"

#define AMAPLocationLatitudeKey               @"AMAPLocationLatitudeKey"
#define AMAPLocationLongitudeKey              @"AMAPLocationLongitudeKey"


@implementation AMapLocationHelper

+ (AMapLocationManager *)startLocationWithComplish:(ComplishLoctionBlock)complishLocation{
    AMapLocationManager *locationManager = [[AMapLocationManager alloc] init];
    [locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
    //   定位超时时间，最低2s，此处设置为2s
    locationManager.locationTimeout = 10;
    [locationManager requestLocationWithReGeocode:NO completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        CLLocationCoordinate2D coordinate = location.coordinate;
        if (coordinate.latitude && coordinate.longitude) {
            
            NSString * latStr = [[NSNumber numberWithDouble:coordinate.latitude] stringValue];
            NSString * longStr = [[NSNumber numberWithDouble:coordinate.longitude] stringValue];
            complishLocation(latStr, longStr);
            [[NSUserDefaults standardUserDefaults] setValue:latStr forKey:AMAPLocationLatitudeKey];
            [[NSUserDefaults standardUserDefaults] setValue:longStr forKey:AMAPLocationLongitudeKey];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
    }];
    return locationManager;
}


/** 获取经度 */
+ (NSString *)longitudeString{
    NSString *longitudeStr = [[NSUserDefaults standardUserDefaults] valueForKey: AMAPLocationLongitudeKey];
    return longitudeStr;
}
/** 获取纬度 */
+ (NSString *)latitudeString{
    NSString *latitudeStr = [[NSUserDefaults standardUserDefaults] valueForKey: AMAPLocationLatitudeKey];
    return latitudeStr;
}

@end

//
//  LSLocationManager.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2018/1/12.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "LSLocationManager.h"

@interface LSLocationManager ()

@property (nonatomic, strong) AMapLocationManager *locationManager;

@end

@implementation LSLocationManager

- (AMapLocationManager*)locationManager{
    if (!_locationManager) {
        _locationManager = [[AMapLocationManager alloc] init];
        [_locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
        //   定位超时时间，最低2s，此处设置为2s
        _locationManager.locationTimeout =2;
        //   逆地理请求超时时间，最低2s，此处设置为2s
        _locationManager.reGeocodeTimeout = 2;
    }
    return _locationManager;
}



+(LSLocationManager *)shareLocationManager{
    static LSLocationManager *instance = nil;
    static dispatch_once_t oneToken;
    dispatch_once(&oneToken,^{
        instance = [[LSLocationManager alloc] init];
    });
    return instance;
}
+ (void)load{
    [self shareLocationManager];
}




/** 获取定位 */
- (void)locationSuccessWithComplish:(LoctionComplishBlock)complishBlock{
    if (([CLLocationManager locationServicesEnabled] && ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedAlways)))
    {
        [self.locationManager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
            if (error){
                if (error.code == AMapLocationErrorLocateFailed){
                    return;
                }
            }
            
            NSString *longitude = [[NSNumber numberWithDouble:location.coordinate.longitude] stringValue];
            NSString *latitude = [[NSNumber numberWithDouble:location.coordinate.latitude] stringValue];
            self.latitudeString = latitude;
            self.longitudeString = longitude;
            
            if (regeocode){
                complishBlock(regeocode, latitude, longitude);
            }
        }];
    }

}

@end

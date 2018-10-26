//
//  GoodsDetailApi.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2018/1/10.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "GoodsDetailApi.h"
#import "LSLocationManager.h"
#import "NSString+verify.h"

@interface GoodsDetailApi ()

@property (nonatomic, copy) NSString *goodsId;

@end

@implementation GoodsDetailApi

- (instancetype)initWithGoodsId:(NSString*)goodsId
{
    self = [super init];
    if (self) {
        _goodsId = goodsId;
    }
    return self;
}

- (NSString * )requestUrl{
    return @"/mall/getGoodsDetail";
}

- (id)requestArgument{
    NSMutableDictionary * paramDict = [[NSMutableDictionary alloc]init];
    [paramDict setValue:self.goodsId forKey:@"goodsId"];
    if (![LoginManager appReviewState]){
        [paramDict setValue:[LSLocationManager shareLocationManager].longitudeString forKey:@"longitude"];
        [paramDict setValue:[LSLocationManager shareLocationManager].latitudeString forKey:@"latitude"];
    }
    [paramDict setValue:[NSString platformName] forKey:@"devOS"];
    NSString* phoneVersion = [[UIDevice currentDevice] systemVersion];
    [paramDict setValue:phoneVersion forKey:@"devOSVersion"];
    return paramDict;
}

@end

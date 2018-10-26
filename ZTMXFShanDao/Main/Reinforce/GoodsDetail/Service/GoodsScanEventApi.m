//
//  GoodsScanEventApi.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2018/1/19.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "GoodsScanEventApi.h"
#import "LSLocationManager.h"
#import "NSString+verify.h"

@interface GoodsScanEventApi ()

@property (nonatomic, copy) NSString *goodsId;
@property (nonatomic, assign) GoodsDetailOutType outType;

@end

@implementation GoodsScanEventApi

- (instancetype)initWithGoodsId:(NSString *)goodsId goodsDetailEvent:(GoodsDetailOutType)outType
{
    self = [super init];
    if (self) {
        _goodsId = goodsId;
        _outType = outType;
    }
    return self;
}

- (NSString * )requestUrl{
    return @"/mall/goodsBrowerEndEvent";
}

- (id)requestArgument{
    NSMutableDictionary * paramDict = [[NSMutableDictionary alloc]init];
    [paramDict setValue:self.goodsId forKey:@"goodsId"];
    if (![LoginManager appReviewState]){
        [paramDict setValue:[LSLocationManager shareLocationManager].longitudeString forKey:@"longitude"];
        [paramDict setValue:[LSLocationManager shareLocationManager].latitudeString forKey:@"latitude"];
    }
    if (_outType == GoodsDetailBuyNow) {
        //  立即购买
        [paramDict setValue:@"1" forKey:@"outType"];
    } else if (_outType == GoodsDetailReturnBack) {
        //  商品详情点击返回
        [paramDict setValue:@"3" forKey:@"outType"];
    }
    [paramDict setValue:[NSString platformName] forKey:@"devOS"];
    NSString* phoneVersion = [[UIDevice currentDevice] systemVersion];
    [paramDict setValue:phoneVersion forKey:@"devOSVersion"];
    return paramDict;
}
@end

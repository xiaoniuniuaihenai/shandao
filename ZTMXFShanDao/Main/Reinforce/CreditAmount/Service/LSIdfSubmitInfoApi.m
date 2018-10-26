//
//  LSIdfSubmitInfoApi.m
//  ZTMXFXunMiaoiOS
//
//  Created by 朱吉达 on 2017/9/22.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "LSIdfSubmitInfoApi.h"
@interface LSIdfSubmitInfoApi()
@property (nonatomic,strong) NSDictionary* rqParameter;
@property (nonatomic,assign) SubmitIdCardInfoType infoType;
@end
@implementation LSIdfSubmitInfoApi
-(instancetype)initWithParameter:(NSDictionary*)rqParameter saveInfoType:(SubmitIdCardInfoType)infoType{
    if (self = [super init]) {
        _rqParameter = rqParameter;
        _infoType = infoType;
    }
    return self;
}




- (NSString *)requestUrl{
    switch (_infoType) {
        case SubmitIdCardInfoTypeYiTu:{
            return @"/auth/submitIdNumberInfoV1";
        }
            break;
        case SubmitIdCardInfoTypeFace:{
            return @"/auth/submitIdNumberInfoForFacePlus";
        }break;
        default:
            break;
    }
}

- (id)requestArgument{
    return _rqParameter;
}
@end

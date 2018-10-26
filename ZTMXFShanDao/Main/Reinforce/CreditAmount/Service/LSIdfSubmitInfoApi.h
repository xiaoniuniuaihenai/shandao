//
//  LSIdfSubmitInfoApi.h
//  ZTMXFXunMiaoiOS
//
//  Created by 朱吉达 on 2017/9/22.
//  Copyright © 2017年 LSCredit. All rights reserved.
//  提交依图识别信息

#import "BaseRequestSerivce.h"
typedef NS_ENUM(NSInteger,SubmitIdCardInfoType) {
    SubmitIdCardInfoTypeYiTu= 0, // 依图
    SubmitIdCardInfoTypeFace,  //  face++
};
@interface LSIdfSubmitInfoApi: BaseRequestSerivce
-(instancetype)initWithParameter:(NSDictionary*)rqParameter saveInfoType:(SubmitIdCardInfoType)infoType;
@end

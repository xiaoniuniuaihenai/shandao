//
//  LogistcsInfoModel.h
//  ZTMXFXunMiaoiOS
//
//  Created by 朱吉达 on 2018/1/14.
//  Copyright © 2018年 LSCredit. All rights reserved.
//  物流信息

#import <Foundation/Foundation.h>

@interface LogistcsInfoModel : NSObject

/**
 商品图片
 */
@property (nonatomic,copy) NSString * goodsIcon;

/**
 收货地址
 */
@property (nonatomic,copy) NSString * address;

/**
 物流单号
 */
@property (nonatomic,copy) NSString * shipperCode;

/**
 物流公司
 */
@property (nonatomic,copy) NSString * shipperName;

/**
 物流状态
 */
@property (nonatomic,copy) NSString * stateDesc;
/**
 配送信息
 */
@property (nonatomic,strong) NSArray * tracesInfo;

@end
@interface LogistcsProgressModel : NSObject
@property (nonatomic,copy) NSString * AcceptStation;
@property (nonatomic,copy) NSString * AcceptTime;
@end

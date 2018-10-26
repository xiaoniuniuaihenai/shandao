//
//  PayChannelModel.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/9/25.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PayChannelModel : NSObject
/** 是否为主卡【1:主卡,0:非主卡】 */
@property (nonatomic, assign) NSInteger isMain;
/** 是否有效【1:有效，0：失效】 */
@property (nonatomic, assign) NSInteger isValid;
/** 无效时文案，以及横幅文案 */
@property (nonatomic, copy) NSString *inValidDesc;
/** 渠道id(银行卡就是银行卡Id, 微信:-1, 支付宝: -3) */
@property (nonatomic, copy) NSString *channelId;
/** 渠道名称，银行卡名称 */
@property (nonatomic, copy) NSString *channelName;
/** 渠道logo */
@property (nonatomic, copy) NSString *channelIcon;
/** 渠道账号(银行卡就是卡号, -微信,支付宝或者其他就是空) */
@property (nonatomic, copy) NSString *channelNumber;
/** 渠道描述 */
@property (nonatomic, copy) NSString *channelDesc;

@property (nonatomic, assign) BOOL alipay;

@end

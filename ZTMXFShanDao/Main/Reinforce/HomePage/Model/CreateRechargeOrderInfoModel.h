//
//  CreateRechargeOrderInfoModel.h
//  ZTMXFXunMiaoiOS
//
//  Created by 朱吉达 on 2018/1/31.
//  Copyright © 2018年 LSCredit. All rights reserved.
//  创建充值订单信息

#import <Foundation/Foundation.h>

@interface CreateRechargeOrderInfoModel : NSObject

/** 充值手机号*/
@property (nonatomic,copy) NSString * mobile;
/**充值金额*/
@property (nonatomic,copy) NSString * amount;
/** 手机号归属地*/
@property (nonatomic,copy) NSString * province;
/**营运商公司*/
@property (nonatomic,copy) NSString * company;
/**订单id*/
@property (nonatomic,copy) NSString * rid;

@end

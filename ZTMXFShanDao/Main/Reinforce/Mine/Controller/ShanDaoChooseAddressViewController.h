//
//  ShanDaoChooseAddressViewController.h
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2017/12/12.
//  Copyright © 2017年 LSCredit. All rights reserved.
// 选择收货地址

#import "BaseViewController.h"
@class LSAddressModel;

@protocol ChooseAddressProtocol <NSObject>

@optional
- (void)chooseAddress:(LSAddressModel *)addressModel;

@end

@interface ShanDaoChooseAddressViewController : BaseViewController

@property (nonatomic, weak) id <ChooseAddressProtocol> delegete;

/** 订单id */
@property (nonatomic, strong) NSString *orderId; // 订单id

@end

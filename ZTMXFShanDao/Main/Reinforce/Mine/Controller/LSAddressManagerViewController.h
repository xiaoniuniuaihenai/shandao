//
//  LSAddressManagerViewController.h
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2017/12/8.
//  Copyright © 2017年 LSCredit. All rights reserved.
// 地址管理

#import "BaseViewController.h"
@class LSAddressModel;
@interface LSAddressManagerViewController : BaseViewController

@property (nonatomic, copy)void (^clickCell)(LSAddressModel * addressModel);

/** 订单id */
@property (nonatomic, strong) NSString *orderId; // 订单id
@end

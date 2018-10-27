//
//  LSLoanAreaViewController.h
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2017/12/7.
//  Copyright © 2017年 LSCredit. All rights reserved.
//  借款结果

#import "ZTMXFTableViewController.h"

typedef NS_ENUM(NSInteger ,LSAddressOperaType) {
    LSAddressAddType,   // 新增地址
    LSAddressUpdateType // 更新地址
};

@interface LSLoanAreaViewController : ZTMXFTableViewController

@property (nonatomic, copy) NSString *orderId;


@end

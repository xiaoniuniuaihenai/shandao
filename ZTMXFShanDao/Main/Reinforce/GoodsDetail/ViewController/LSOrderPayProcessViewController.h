//
//  LSOrderPayProcessViewController.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2018/1/6.
//  Copyright © 2018年 LSCredit. All rights reserved.
//支付中页面

#import "BaseViewController.h"

@interface LSOrderPayProcessViewController : BaseViewController
/** 状态描述 */
@property (nonatomic, copy) NSString *statusDesc;
/** 描述详情 */
@property (nonatomic, copy) NSString *finishDesc;

@end

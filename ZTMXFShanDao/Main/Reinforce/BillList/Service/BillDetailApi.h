//
//  BillDetailApi.h
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2017/12/13.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "BaseRequestSerivce.h"

@interface BillDetailApi : BaseRequestSerivce

- (instancetype)initWithBillId:(long)billId;

@end

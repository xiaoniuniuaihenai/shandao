//
//  MallBillListApi.h
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2018/1/9.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "BaseRequestSerivce.h"

@interface MallBillListApi : BaseRequestSerivce

- (instancetype)initWithBillType:(NSString *)billType;

@end

//
//  WhiteLoanDetailApi.h
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2018/1/12.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "BaseRequestSerivce.h"

@interface WhiteLoanDetailApi : BaseRequestSerivce

- (instancetype)initWithBorrowId:(NSString *)borrowId;

@end

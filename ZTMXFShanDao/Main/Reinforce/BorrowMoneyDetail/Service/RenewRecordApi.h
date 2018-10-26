//
//  RenewRecordApi.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/9/23.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "BaseRequestSerivce.h"

@interface RenewRecordApi : BaseRequestSerivce

- (instancetype)initWithBorrowId:(NSString *)borrowId page:(NSInteger)page;

@end

//
//  LSBrwMoneyGetConfirmInfoApi.h
//  ZTMXFXunMiaoiOS
//
//  Created by 朱吉达 on 2017/9/25.
//  Copyright © 2017年 LSCredit. All rights reserved.
//  获得借钱确认信息

#import "BaseRequestSerivce.h"

@interface LSBrwMoneyGetConfirmInfoApi : BaseRequestSerivce
- (instancetype)initBrwMoneyGetConfirmInfoWithAmount:(NSString *)amount andBorrowDays:(NSString *)borrowDays andBorrowType:(NSString *)borrowType;
@end

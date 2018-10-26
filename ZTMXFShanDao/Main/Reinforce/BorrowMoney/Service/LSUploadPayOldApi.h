//
//  LSUploadPayOldApi.h
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2018/1/3.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "BaseRequestSerivce.h"

@interface LSUploadPayOldApi : BaseRequestSerivce

- (instancetype)initWithBorrowId:(NSString *)borrowId repaymentAmount:(NSString *)repaymentAmount proofUrl:(NSString *)proofUrl;

@end

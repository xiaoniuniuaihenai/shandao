//
//  LSUploadPayProofApi.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/10/23.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "BaseRequestSerivce.h"

@interface LSUploadPayProofApi : BaseRequestSerivce

- (instancetype)initWithBorrowId:(NSString *)borrowId repaymentAmount:(NSString *)repaymentAmount orderNumber:(NSString *)orderNo;

@end

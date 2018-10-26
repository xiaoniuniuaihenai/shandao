//
//  LSGetLoanSPMListByTabApi.h
//  ZTMXFXunMiaoiOS
//
//  Created by 朱吉达 on 2017/9/25.
//  Copyright © 2017年 LSCredit. All rights reserved.
//  根据标签获得贷款超市数据

#import "BaseRequestSerivce.h"

@interface LSGetLoanSPMListByTabApi : BaseRequestSerivce
//-(instancetype)initWithSPMListWithLabel:(NSString*)label;

-(instancetype)initWithSPMListWithLabel:(NSString*)label type:(NSInteger)type;

@end

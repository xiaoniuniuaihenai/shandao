//
//  XLLoanMarketStatisticalApi.h
//  YWLTMeiQiiOS
//
//  Created by 凉 on 2018/7/31.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "BaseRequestSerivce.h"

@interface XLLoanMarketStatisticalApi : BaseRequestSerivce

- (void)loanMarketStatisticalWithRecordsType:(NSString *)recordsType lsmNo:(NSString *)lsmNo;

@end

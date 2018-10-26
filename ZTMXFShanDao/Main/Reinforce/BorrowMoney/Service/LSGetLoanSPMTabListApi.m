//
//  LSGetLoanSPMTabListApi.m
//  ZTMXFXunMiaoiOS
//
//  Created by 朱吉达 on 2017/9/25.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "LSGetLoanSPMTabListApi.h"

@implementation LSGetLoanSPMTabListApi
-(NSString*)requestUrl{
    return @"/borrowCash/getLoanSPMTabList";
}
-(id)requestArgument{
    return @{};
}

@end

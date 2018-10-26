//
//  LSBankCardListTypeApi.m
//  ZTMXFXunMiaoiOS
//
//  Created by 朱吉达 on 2017/9/22.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "LSBankCardListTypeApi.h"

@implementation LSBankCardListTypeApi
-(NSString*)requestUrl{
    return @"/auth/getBankList";
}




-(id)requestArgument{
    return @{};
}
@end

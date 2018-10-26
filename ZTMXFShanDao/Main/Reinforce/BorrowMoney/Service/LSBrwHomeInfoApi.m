//
//  LSBrwHomeInfoApi.m
//  ZTMXFXunMiaoiOS
//
//  Created by 朱吉达 on 2017/9/23.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "LSBrwHomeInfoApi.h"

@implementation LSBrwHomeInfoApi

-(NSString * )requestUrl{
    if ([LoginManager loginState]) {
        return @"/borrowCash/getBorrowCashLogInInfo";
    }
    return @"/borrowCash/getBorrowHomePage";
}
-(id)requestArgument{
    return @{};
}

@end

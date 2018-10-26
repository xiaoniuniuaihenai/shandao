//
//  LSGoodsAccessLoanSPMApi.m
//  ZTMXFXunMiaoiOS
//
//  Created by 朱吉达 on 2017/9/25.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "LSGoodsAccessLoanSPMApi.h"
@interface LSGoodsAccessLoanSPMApi ()
@property (nonatomic,copy) NSString * lsmNo;
@end
@implementation LSGoodsAccessLoanSPMApi
-(instancetype)initWithAccessLoanSPMApiWithLsmNo:(NSString *)lsmNo{
    if (self = [super init]) {
        _lsmNo = lsmNo;
    }
    return self;
}
-(NSString*)requestUrl{
    return @"/loanMarket/accessLoanSPM";
}
-(id)requestArgument{
    NSMutableDictionary * dicRq = [[NSMutableDictionary alloc]init];
    [dicRq setValue:_lsmNo forKey:@"lsmNo"];
    return dicRq;
}

@end

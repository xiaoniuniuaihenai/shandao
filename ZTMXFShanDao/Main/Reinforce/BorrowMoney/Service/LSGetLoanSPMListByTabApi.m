//
//  LSGetLoanSPMListByTabApi.m
//  ZTMXFXunMiaoiOS
//
//  Created by 朱吉达 on 2017/9/25.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "LSGetLoanSPMListByTabApi.h"
@interface LSGetLoanSPMListByTabApi()
@property (nonatomic,copy) NSString * label;
@property (nonatomic,copy) NSString * type;

@end
@implementation LSGetLoanSPMListByTabApi
-(instancetype)initWithSPMListWithLabel:(NSString*)label type:(NSInteger)type
{
    if (self = [super init]) {
        _label = label;
        _type = [@(type) stringValue];
    }
    return self;
}
-(NSString*)requestUrl{
    return @"/borrowCash/getLoanSPMListByTab";
}
-(id)requestArgument{
    NSMutableDictionary * dicRq = [[NSMutableDictionary alloc]init];
    [dicRq setValue:_label forKey:@"label"];
//    [dicRq setValue:_type forKey:@"sort"];

    return dicRq;
}

@end

//
//  XLReplaceMainCard.m
//  YWLTMeiQiiOS
//
//  Created by 余金超 on 2018/7/17.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "ZTMXFReplaceMainCardApi.h"

@interface ZTMXFReplaceMainCardApi ()

@property (nonatomic, strong) NSString *rid;

@end

@implementation ZTMXFReplaceMainCardApi

- (instancetype)initWithCardRid:(NSString *)rid{
    if (self = [super init]) {
        _rid = rid;
    }
    return self;
}

-(NSString*)requestUrl{
    return @"/user/exchangeMainBankCard";
}

-(id)requestArgument{
    NSMutableDictionary * dicArgument = [[NSMutableDictionary alloc]init];
    [dicArgument setValue:_rid forKey:@"mainBankCardId"];
    return dicArgument;
}

@end

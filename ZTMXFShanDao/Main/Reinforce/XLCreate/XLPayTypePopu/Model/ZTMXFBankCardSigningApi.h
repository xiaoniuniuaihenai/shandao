//
//  ZTMXFBankCardSigningApi.h
//  YWLTMeiQiiOS
//
//  Created by 陈传亮 on 2018/6/8.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "BaseRequestSerivce.h"

@interface ZTMXFBankCardSigningApi : BaseRequestSerivce

- (instancetype)initWithBankCardId:(NSString *)bankCardId amount:(NSString *)amount bizCode:(NSString *)bizCode borrowId:(NSString *)borrowId;

@end

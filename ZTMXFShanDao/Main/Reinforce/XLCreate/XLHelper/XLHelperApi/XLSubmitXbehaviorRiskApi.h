//
//  XLSubmitXbehaviorRiskApi.h
//  YWLTMeiQiiOS
//
//  Created by 余金超 on 2018/8/2.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "BaseRequestSerivce.h"

@interface XLSubmitXbehaviorRiskApi : BaseRequestSerivce

- (instancetype)initWithCreditValue:(NSString *)creditValue UserName:(NSString *)userName;

@end

//
//  RenewDetailManager.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/9/24.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "RenewDetailManager.h"
#import "LSRenewDetailModel.h"

@implementation RenewDetailManager

+ (NSArray *)manageWithRenewDetailModel:(LSRenewDetailModel *)renewDetailModel{
    NSMutableArray *resultArray = [NSMutableArray array];
    
    NSMutableDictionary *borrowAmountDict = [NSMutableDictionary dictionary];
    [borrowAmountDict setValue:@"延期还款本金" forKey:kTitleValueCellManagerKey];
    [borrowAmountDict setValue:[NSString stringWithFormat:@"￥%.2f",renewDetailModel.renewalAmount] forKey:kTitleValueCellManagerValue];
    [resultArray addObject:borrowAmountDict];
    
    
    NSMutableDictionary *acountAmountDict = [NSMutableDictionary dictionary];
    [acountAmountDict setValue:@"上期利息" forKey:kTitleValueCellManagerKey];
    [acountAmountDict setValue:[NSString stringWithFormat:@"￥%.2f",renewDetailModel.priorInterest] forKey:kTitleValueCellManagerValue];
    [resultArray addObject:acountAmountDict];
    
    
    NSMutableDictionary *serverAmountDict = [NSMutableDictionary dictionary];
    [serverAmountDict setValue:@"上期滞纳金" forKey:kTitleValueCellManagerKey];
    [serverAmountDict setValue:[NSString stringWithFormat:@"￥%.2f", renewDetailModel.priorOverdue] forKey:kTitleValueCellManagerValue];
    [resultArray addObject:serverAmountDict];
    
    if (renewDetailModel.capital > 0.0) {
        NSMutableDictionary *capitalDict = [NSMutableDictionary dictionary];
        [capitalDict setValue:@"本金还款部分" forKey:kTitleValueCellManagerKey];
        [capitalDict setValue:[NSString stringWithFormat:@"￥%.2f",renewDetailModel.capital] forKey:kTitleValueCellManagerValue];
        [resultArray addObject:capitalDict];
    }
    
    
    NSMutableDictionary *borrowDeadlineDict = [NSMutableDictionary dictionary];
    [borrowDeadlineDict setValue:@"下期手续费" forKey:kTitleValueCellManagerKey];
    [borrowDeadlineDict setValue:[NSString stringWithFormat:@"￥%.2f", renewDetailModel.nextPoundage] forKey:kTitleValueCellManagerValue];
    [resultArray addObject:borrowDeadlineDict];
    

    NSMutableDictionary *overDateDict = [NSMutableDictionary dictionary];
    [overDateDict setValue:@"支付编号" forKey:kTitleValueCellManagerKey];
    [overDateDict setValue:renewDetailModel.tradeNo forKey:kTitleValueCellManagerValue];
    [resultArray addObject:overDateDict];

    
    NSMutableDictionary *overdueDict = [NSMutableDictionary dictionary];
    [overdueDict setValue:@"创建时间" forKey:kTitleValueCellManagerKey];
    [overdueDict setValue:[NSDate dateMMStringFromLongDate:renewDetailModel.gmtCreate] forKey:kTitleValueCellManagerValue];
    [resultArray addObject:overdueDict];

    NSMutableDictionary *renewalNoDict = [NSMutableDictionary dictionary];
    [renewalNoDict setValue:@"延期还款编号" forKey:kTitleValueCellManagerKey];
    [renewalNoDict setValue:renewDetailModel.renewalNo forKey:kTitleValueCellManagerValue];
    [resultArray addObject:renewalNoDict];
    
    if (renewDetailModel.failReason && renewDetailModel.failReason.length > 0) {
        NSMutableDictionary *gmtCreateDict = [NSMutableDictionary dictionary];
        [gmtCreateDict setValue:@"还款失败原因" forKey:kTitleValueCellManagerKey];
        [gmtCreateDict setValue:renewDetailModel.failReason forKey:kTitleValueCellManagerValue];
        [resultArray addObject:gmtCreateDict];
    }
    
    return resultArray;

}


@end

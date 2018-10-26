//
//  ALABorrowDetailManager.m
//  ALAFanBei
//
//  Created by yangpenghua on 17/3/21.
//  Copyright © 2017年 讯秒. All rights reserved.
//

#import "ALABorrowDetailManager.h"
#import "LSLoanDetailModel.h"
#import "WhiteLoanInfoModel.h"

@implementation ALABorrowDetailManager

+ (NSMutableArray *)manageRenewDetailModel:(LSLoanDetailModel *)model{
    
    NSMutableArray *resultArray = [NSMutableArray array];
    NSMutableArray *firstArray = [NSMutableArray array];
    NSMutableArray *secondArray = [NSMutableArray array];
    /**
     134版本 修改为 还款记录
     */
//    if (model.paidAmount > 0) {
        NSMutableDictionary *paidAmountDict = [NSMutableDictionary dictionary];
        [paidAmountDict setValue:@"还款记录" forKey:kTitleValueCellManagerKey];
        CGFloat paidAmount = model.paidAmount;
        [paidAmountDict setValue:[NSString stringWithFormat:@"￥%.2f", paidAmount] forKey:kTitleValueCellManagerValue];
        [firstArray addObject:paidAmountDict];
//    }
    
    NSMutableDictionary *borrowAmountDict = [NSMutableDictionary dictionary];
    [borrowAmountDict setValue:@"借款金额" forKey:kTitleValueCellManagerKey];
    CGFloat amount = model.amount;
    [borrowAmountDict setValue:[NSString stringWithFormat:@"￥%.2f", amount] forKey:kTitleValueCellManagerValue];
    [firstArray addObject:borrowAmountDict];
    
    NSMutableDictionary *acountAmountDict = [NSMutableDictionary dictionary];
    [acountAmountDict setValue:@"到账金额" forKey:kTitleValueCellManagerKey];
    CGFloat arrivalAmount = model.arrivalAmount;
    [acountAmountDict setValue:[NSString stringWithFormat:@"￥%.2f",arrivalAmount] forKey:kTitleValueCellManagerValue];
    [firstArray addObject:acountAmountDict];

    if (model.goodsSaleAmount > 0) {
        NSMutableDictionary *goodsAmountDict = [NSMutableDictionary dictionary];
        [goodsAmountDict setValue:@"商品金额" forKey:kTitleValueCellManagerKey];
        [goodsAmountDict setValue:[NSString stringWithFormat:@"￥%.2f", model.goodsSaleAmount] forKey:kTitleValueCellManagerValue];
        [firstArray addObject:goodsAmountDict];
    }
    
    NSMutableDictionary *serverAmountDict = [NSMutableDictionary dictionary];
    [serverAmountDict setValue:@"服务费" forKey:kTitleValueCellManagerKey];
    CGFloat serviceAmount = model.serviceAmount;
    [serverAmountDict setValue:[NSString stringWithFormat:@"￥%.2f", serviceAmount] forKey:kTitleValueCellManagerValue];
    [firstArray addObject:serverAmountDict];

    NSMutableDictionary *interestDict = [NSMutableDictionary dictionary];
    [interestDict setValue:@"利息" forKey:kTitleValueCellManagerKey];
    [interestDict setValue:[NSString stringWithFormat:@"￥%.2f", model.rateAmount] forKey:kTitleValueCellManagerValue];
    [firstArray addObject:interestDict];
    
    
    NSMutableDictionary *cashBankcardDict = [NSMutableDictionary dictionary];
    [cashBankcardDict setValue:@"收款银行卡" forKey:kTitleValueCellManagerKey];
    NSInteger fromIndex = model.bankCard.length - 4;
    NSString *bankCard = [NSString string];
    if (fromIndex > 0) {
        bankCard = [model.bankCard substringFromIndex:fromIndex];
    }
    [cashBankcardDict setValue:[NSString stringWithFormat:@"%@(尾号%@)",model.bankName, bankCard] forKey:kTitleValueCellManagerValue];
    [firstArray addObject:cashBankcardDict];
    
    NSMutableDictionary *borrowNumberDict = [NSMutableDictionary dictionary];
    [borrowNumberDict setValue:@"借款编号" forKey:kTitleValueCellManagerKey];
    [borrowNumberDict setValue:model.borrowNo forKey:kTitleValueCellManagerValue];
    [firstArray addObject:borrowNumberDict];
    
//    if (model.renewalNum > 0) {
        NSMutableDictionary *renewalNumDict = [NSMutableDictionary dictionary];
        [renewalNumDict setValue:@"延期还款记录" forKey:kTitleValueCellManagerKey];
//        [renewalNumDict setValue:[NSString stringWithFormat:@"%ld", model.renewalNum] forKey:kTitleValueCellManagerValue];
        [renewalNumDict setValue:@"" forKey:kTitleValueCellManagerValue];

        [firstArray addObject:renewalNumDict];
//    }

    
    NSMutableDictionary *borrowDateDict = [NSMutableDictionary dictionary];
    [borrowDateDict setValue:@"申请时间" forKey:kTitleValueCellManagerKey];
    NSString *gmtCreate = [NSDate dateYMDacrossStringFromLongDate:model.gmtCreate];
    [borrowDateDict setValue:gmtCreate forKey:kTitleValueCellManagerValue];
    [secondArray addObject:borrowDateDict];
    
    if (model.gmtArrival > 0) {
        NSMutableDictionary *acountDateDict = [NSMutableDictionary dictionary];
        [acountDateDict setValue:@"打款时间" forKey:kTitleValueCellManagerKey];
        NSString *gmtArrival = [NSDate dateYMDacrossStringFromLongDate:model.gmtArrival];
        [acountDateDict setValue:gmtArrival forKey:kTitleValueCellManagerValue];
        [secondArray addObject:acountDateDict];
    }
    
    NSMutableDictionary *borrowDeadlineDict = [NSMutableDictionary dictionary];
    [borrowDeadlineDict setValue:@"借款期限" forKey:kTitleValueCellManagerKey];
    [borrowDeadlineDict setValue:[NSString stringWithFormat:@"%ld天",model.borrowDays] forKey:kTitleValueCellManagerValue];
    [secondArray addObject:borrowDeadlineDict];
    
    

    [resultArray addObject:firstArray];
    [resultArray addObject:secondArray];
    
    return resultArray;
}



+ (NSMutableArray *)managerPeriodDetailModel:(WhiteLoanInfoModel *)model{
    
    NSMutableArray *resultArray = [NSMutableArray array];
    
    NSMutableDictionary *borrowAmountDict = [NSMutableDictionary dictionary];
    [borrowAmountDict setValue:@"应还总额" forKey:kTitleValueCellManagerKey];
    CGFloat amount = model.amount;
    [borrowAmountDict setValue:[NSString stringWithFormat:@"￥%.2f", amount] forKey:kTitleValueCellManagerValue];
    [resultArray addObject:borrowAmountDict];
    
    NSMutableDictionary *periodDict = [NSMutableDictionary dictionary];
    [periodDict setValue:@"分期期数" forKey:kTitleValueCellManagerKey];
    [periodDict setValue:[NSString stringWithFormat:@"%ld期", model.nper] forKey:kTitleValueCellManagerValue];
    [resultArray addObject:periodDict];
    
    NSMutableDictionary *acountAmountDict = [NSMutableDictionary dictionary];
    [acountAmountDict setValue:@"借款本金" forKey:kTitleValueCellManagerKey];
    CGFloat arrivalAmount = model.borrowAmount;
    [acountAmountDict setValue:[NSString stringWithFormat:@"￥%.2f",arrivalAmount] forKey:kTitleValueCellManagerValue];
    [resultArray addObject:acountAmountDict];
    
    NSMutableDictionary *interestDict = [NSMutableDictionary dictionary];
    [interestDict setValue:@"借款利息" forKey:kTitleValueCellManagerKey];
    [interestDict setValue:[NSString stringWithFormat:@"￥%.2f", model.interest] forKey:kTitleValueCellManagerValue];
    [resultArray addObject:interestDict];
    
    NSMutableDictionary *serverAmountDict = [NSMutableDictionary dictionary];
    [serverAmountDict setValue:@"逾期费用" forKey:kTitleValueCellManagerKey];
    CGFloat overdueAmount = model.overdueAmount;
    [serverAmountDict setValue:[NSString stringWithFormat:@"￥%.2f", overdueAmount] forKey:kTitleValueCellManagerValue];
    [resultArray addObject:serverAmountDict];
    
    NSMutableDictionary *borrowDateDict = [NSMutableDictionary dictionary];
    [borrowDateDict setValue:@"借款时间" forKey:kTitleValueCellManagerKey];
    NSString *gmtCreate = [NSDate dateStringFromLongDate:model.gmtBorrow];
    [borrowDateDict setValue:gmtCreate forKey:kTitleValueCellManagerValue];
    [resultArray addObject:borrowDateDict];
    
    NSMutableDictionary *borrowNumberDict = [NSMutableDictionary dictionary];
    [borrowNumberDict setValue:@"借款编号" forKey:kTitleValueCellManagerKey];
    [borrowNumberDict setValue:model.borrowNo forKey:kTitleValueCellManagerValue];
    [resultArray addObject:borrowNumberDict];
    
    return resultArray;
}

@end

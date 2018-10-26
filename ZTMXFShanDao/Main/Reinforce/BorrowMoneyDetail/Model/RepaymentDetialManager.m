//
//  RepaymentDetialManager.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/9/24.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "RepaymentDetialManager.h"
#import "LSRepaymentDetailModel.h"
#import "LSBillListModel.h"

@implementation RepaymentDetialManager

+ (NSArray *)manageWithRenewDetailModel:(LSRepaymentDetailModel *)repaymentDetailModel{
    NSMutableArray *resultArray = [NSMutableArray array];
    
    NSMutableDictionary *borrowAmountDict = [NSMutableDictionary dictionary];
    [borrowAmountDict setValue:@"还款金额" forKey:kTitleValueCellManagerKey];
    [borrowAmountDict setValue:[NSString stringWithFormat:@"￥%.2f",repaymentDetailModel.amount] forKey:kTitleValueCellManagerValue];
    [resultArray addObject:borrowAmountDict];

    NSMutableDictionary *cashAmountDict = [NSMutableDictionary dictionary];
    [cashAmountDict setValue:@"实际支付" forKey:kTitleValueCellManagerKey];
    [cashAmountDict setValue:[NSString stringWithFormat:@"￥%.2f",repaymentDetailModel.cashAmount] forKey:kTitleValueCellManagerValue];
    [resultArray addObject:cashAmountDict];


    if (repaymentDetailModel.userAmount > 0.0) {
        NSMutableDictionary *userAmountDict = [NSMutableDictionary dictionary];
        [userAmountDict setValue:@"余额支付" forKey:kTitleValueCellManagerKey];
        [userAmountDict setValue:[NSString stringWithFormat:@"￥%.2f",repaymentDetailModel.userAmount] forKey:kTitleValueCellManagerValue];
        [resultArray addObject:userAmountDict];
    }


    if (repaymentDetailModel.couponAmount > 0) {
        NSMutableDictionary *couponAmountDict = [NSMutableDictionary dictionary];
        [couponAmountDict setValue:@"优惠金额" forKey:kTitleValueCellManagerKey];
        [couponAmountDict setValue:[NSString stringWithFormat:@"￥%.2f",repaymentDetailModel.couponAmount] forKey:kTitleValueCellManagerValue];
        [resultArray addObject:couponAmountDict];
    }

    
    NSMutableDictionary *cardNameDict = [NSMutableDictionary dictionary];
    [cardNameDict setValue:@"还款方式" forKey:kTitleValueCellManagerKey];
    [cardNameDict setValue:repaymentDetailModel.cardName forKey:kTitleValueCellManagerValue];
    [resultArray addObject:cardNameDict];
    
    if (repaymentDetailModel.cardNumber.length > 0) {
        NSMutableDictionary *cardNumberDict = [NSMutableDictionary dictionary];
        [cardNumberDict setValue:@"还款账号" forKey:kTitleValueCellManagerKey];
        [cardNumberDict setValue:repaymentDetailModel.cardNumber forKey:kTitleValueCellManagerValue];
        [resultArray addObject:cardNumberDict];
    }

    NSMutableDictionary *repayNoDict = [NSMutableDictionary dictionary];
    [repayNoDict setValue:@"还款编号" forKey:kTitleValueCellManagerKey];
    [repayNoDict setValue:repaymentDetailModel.repayNo forKey:kTitleValueCellManagerValue];
    [resultArray addObject:repayNoDict];
    
    NSMutableDictionary *gmtCreateDict = [NSMutableDictionary dictionary];
    [gmtCreateDict setValue:@"还款时间" forKey:kTitleValueCellManagerKey];
    [gmtCreateDict setValue:[NSDate dateYMDHMStringFromLongDate:repaymentDetailModel.gmtCreate] forKey:kTitleValueCellManagerValue];
    [resultArray addObject:gmtCreateDict];
    
    if (repaymentDetailModel.status == -1 && repaymentDetailModel.failReason) {
        NSMutableDictionary *gmtCreateDict = [NSMutableDictionary dictionary];
        [gmtCreateDict setValue:@"还款失败原因" forKey:kTitleValueCellManagerKey];
        [gmtCreateDict setValue:repaymentDetailModel.failReason forKey:kTitleValueCellManagerValue];
        [resultArray addObject:gmtCreateDict];
    }
    return resultArray;
    
}

+ (NSArray *)managerWithBillDetailModel:(LSBillDetailModel *)billDetailModel{
    NSMutableArray *returnarray = [NSMutableArray array];
    
    NSMutableArray *firstArray = [NSMutableArray array];
    NSMutableArray *secondArray = [NSMutableArray array];
    
    NSMutableDictionary *returnAmountDict = [NSMutableDictionary dictionary];
    [returnAmountDict setValue:@"应还金额" forKey:kTitleValueCellManagerKey];
    [returnAmountDict setValue:[NSString stringWithFormat:@"￥%.2f",billDetailModel.billAmount] forKey:kTitleValueCellManagerValue];
    [firstArray addObject:returnAmountDict];
    
    NSMutableDictionary *returnPeriodDict = [NSMutableDictionary dictionary];
    [returnPeriodDict setValue:@"还款期数" forKey:kTitleValueCellManagerKey];
    [returnPeriodDict setValue:[NSString stringWithFormat:@"%ld/%ld期",billDetailModel.billNper,billDetailModel.nper] forKey:kTitleValueCellManagerValue];
    [firstArray addObject:returnPeriodDict];
    
    NSMutableDictionary *returnDateDict = [NSMutableDictionary dictionary];
    [returnDateDict setValue:@"应还日期" forKey:kTitleValueCellManagerKey];
    [returnDateDict setValue:[NSDate dateYMDacrossStringFromLongDate:billDetailModel.gmtPlanRepayment] forKey:kTitleValueCellManagerValue];
    [firstArray addObject:returnDateDict];
    
    NSMutableDictionary *overdueDaysDict = [NSMutableDictionary dictionary];
    [overdueDaysDict setValue:@"逾期天数" forKey:kTitleValueCellManagerKey];
    [overdueDaysDict setValue:[NSString stringWithFormat:@"%ld天",billDetailModel.overdueDays] forKey:kTitleValueCellManagerValue];
    [firstArray addObject:overdueDaysDict];
    
    NSMutableDictionary *overdueAmountDict = [NSMutableDictionary dictionary];
    [overdueAmountDict setValue:@"逾期金额" forKey:kTitleValueCellManagerKey];
    [overdueAmountDict setValue:[NSString stringWithFormat:@"￥%.2f",billDetailModel.overdueAmount] forKey:kTitleValueCellManagerValue];
    [firstArray addObject:overdueAmountDict];
    
    NSMutableDictionary *borrowDateDict = [NSMutableDictionary dictionary];
    [borrowDateDict setValue:@"借款日期" forKey:kTitleValueCellManagerKey];
    [borrowDateDict setValue:[NSDate dateYMDacrossStringFromLongDate:billDetailModel.gmtBorrow] forKey:kTitleValueCellManagerValue];
    [secondArray addObject:borrowDateDict];
    
    if (billDetailModel.cardNumber.length > 0) {
        NSMutableDictionary *receivingbBankDict = [NSMutableDictionary dictionary];
        [receivingbBankDict setValue:@"收款银行" forKey:kTitleValueCellManagerKey];
        [receivingbBankDict setValue:billDetailModel.cardName forKey:kTitleValueCellManagerValue];
        [secondArray addObject:receivingbBankDict];
    }
    
    if (billDetailModel.borrowNo.length > 0) {
        NSMutableDictionary *renewNoDict = [NSMutableDictionary dictionary];
        [renewNoDict setValue:@"借款编号" forKey:kTitleValueCellManagerKey];
        [renewNoDict setValue:billDetailModel.borrowNo forKey:kTitleValueCellManagerValue];
        [secondArray addObject:renewNoDict];
    }
    
    [returnarray addObject:firstArray];
    [returnarray addObject:secondArray];
    
    return returnarray;
}

@end

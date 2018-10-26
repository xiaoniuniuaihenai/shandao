//
//  MyBillViewModel.h
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2017/12/13.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LSBillDetailModel;
@class LSPeriodBillModel;
@class MallBillInfoModel;
@class WhiteLoanInfoModel;

@protocol MyBillViewModelDelegete <NSObject>

@optional

/**
 返回未还款账单列表
 */
- (void)requestNoPaidBillListSuccess:(NSArray *)noPaidListArray allAmount:(NSString *)amount;

/**
 返回历史账单列表
 */
- (void)requestHistoryBillListSuccess:(NSArray *)historyListArray;

/**
 返回账单详情
 */
- (void)requestBillDetailSuccess:(LSBillDetailModel *)billDetailModel;

/**
 获取还款列表失败
 */
- (void)requestNoPaidBillListFailure;

/**
 返回分期账单列表
 */
- (void)requestPeriodBillListSuccess:(LSPeriodBillModel *)periodBillModel;

/**
 返回分期历史账单列表
 */
- (void)requestPeriodHistoryBillListSuccess:(NSArray *)periodHistoryListArray;

/**
 返回消费分期账单详情
 */
- (void)requestMallBillDetailInfoSuccess:(MallBillInfoModel *)mallBillInfoModel;

/**
 返回白领贷账单详情
 */
- (void)requestWhiteLoanDetailInfoSuccess:(WhiteLoanInfoModel *)whiteLoanInfoModel;

@end

@interface MyBillViewModel : NSObject

@property (nonatomic, weak) id <MyBillViewModelDelegete> delegete;

- (void)requestNoPaidBillListDataWithPageNum:(NSInteger)page;

- (void)requestHistoryBillListDataWithPageNum:(NSInteger)page;

- (void)requestBillDetailWithBillId:(long) billId;
// 请求分期账单列表
- (void)reuestPeriodBillListWithBillType:(NSString *)billType;
// 请求分期商城历史账单列表
- (void)reuestPeriodHistoryBillListWithPageNum:(NSInteger)page;
// 请求消费分期账单详情
- (void)reuestMallBillDetailInfoWithOrderId:(NSString *)orderId;
// 请求白领贷分期账单详情
- (void)reuestWhiteLoanDetailInfoWithBorrowId:(NSString *)borrowId;

@end

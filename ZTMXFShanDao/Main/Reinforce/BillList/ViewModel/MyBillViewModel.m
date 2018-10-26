//
//  MyBillViewModel.m
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2017/12/13.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "MyBillViewModel.h"
#import "UnpaidBillListApi.h"
#import "HistoryBillListApi.h"
#import "BillDetailApi.h"
#import "LSBillListModel.h"
#import "MallBillListApi.h"
#import "LSPeriodBillModel.h"
#import "MallHistoryBillApi.h"
#import "MallBorrowInfoApi.h"
#import "MallBillInfoModel.h"
#import "WhiteLoanDetailApi.h"
#import "WhiteLoanInfoModel.h"

@implementation MyBillViewModel



#pragma mark - 请求历史账单列表
- (void)requestHistoryBillListDataWithPageNum:(NSInteger)page{
    
    HistoryBillListApi *historyBillListApi = [[HistoryBillListApi alloc] initWithPageNum:page];
    [historyBillListApi requestWithSuccess:^(NSDictionary *responseDict) {
        NSString *codeStr = [responseDict[@"code"] description];
        if ([codeStr isEqualToString:@"1000"]) {
            
            NSArray *histotyBillArray = responseDict[@"data"][@"bills"];
            
            NSArray *historyModelArray = [LSBillListModel mj_objectArrayWithKeyValuesArray:histotyBillArray];
            if (self.delegete && [self.delegete respondsToSelector:@selector(requestHistoryBillListSuccess:)]) {
                [self.delegete requestHistoryBillListSuccess:historyModelArray];
            }
        }
    } failure:^(__kindof YTKBaseRequest *request) {
        if (self.delegete && [self.delegete respondsToSelector:@selector(requestNoPaidBillListFailure)]) {
            [self.delegete requestNoPaidBillListFailure];
        }
    }];
}

#pragma mark - 请求账单详情
- (void)requestBillDetailWithBillId:(long)billId{
    
    BillDetailApi *billDetailApi = [[BillDetailApi alloc] initWithBillId:billId];
    [billDetailApi requestWithSuccess:^(NSDictionary *responseDict) {
        NSString *codeStr = [responseDict[@"code"] description];
        if ([codeStr isEqualToString:@"1000"]) {
            
            NSDictionary *billDetailDict = responseDict[@"data"];
            
            LSBillDetailModel *billModel = [LSBillDetailModel mj_objectWithKeyValues:billDetailDict];
           
            if (self.delegete && [self.delegete respondsToSelector:@selector(requestBillDetailSuccess:)]) {
                [self.delegete requestBillDetailSuccess:billModel];
            }
        }
    } failure:^(__kindof YTKBaseRequest *request) {
        if (self.delegete && [self.delegete respondsToSelector:@selector(requestNoPaidBillListFailure)]) {
            [self.delegete requestNoPaidBillListFailure];
        }
    }];
}

#pragma mark - 请求分期账单列表
- (void)reuestPeriodBillListWithBillType:(NSString *)billType
{
    [SVProgressHUD showLoading];
    MallBillListApi *mallBillApi = [[MallBillListApi alloc] initWithBillType:billType];
    [mallBillApi requestWithSuccess:^(NSDictionary *responseDict) {
        [SVProgressHUD dismiss];
        NSString *codeStr = [responseDict[@"code"] description];
        if ([codeStr isEqualToString:@"1000"]) {
            
            NSDictionary *billDetailDict = responseDict[@"data"];
            
            LSPeriodBillModel *billModel = [LSPeriodBillModel mj_objectWithKeyValues:billDetailDict];
            
            if (self.delegete && [self.delegete respondsToSelector:@selector(requestPeriodBillListSuccess:)]) {
                [self.delegete requestPeriodBillListSuccess:billModel];
            }
        }
    } failure:^(__kindof YTKBaseRequest *request) {
        [SVProgressHUD dismiss];
        if (self.delegete && [self.delegete respondsToSelector:@selector(requestNoPaidBillListFailure)]) {
            [self.delegete requestNoPaidBillListFailure];
        }
    }];
}
#pragma mark - 请求未还款账单列表
- (void)requestNoPaidBillListDataWithPageNum:(NSInteger)page{
    
    UnpaidBillListApi *unBillListApi = [[UnpaidBillListApi alloc] initWithPageNum:page];
    [unBillListApi requestWithSuccess:^(NSDictionary *responseDict) {
        NSString *codeStr = [responseDict[@"code"] description];
        if ([codeStr isEqualToString:@"1000"]) {
            // unpaidTotal 总金额
            NSString *totalAmount = [responseDict[@"data"][@"unpaidTotal"] description];
            NSArray *unPaidBillArray = responseDict[@"data"][@"bills"];
            NSArray *unPaidModelArray = [LSBillListModel mj_objectArrayWithKeyValuesArray:unPaidBillArray];
            if (self.delegete && [self.delegete respondsToSelector:@selector(requestNoPaidBillListSuccess:allAmount:)]) {
                [self.delegete requestNoPaidBillListSuccess:unPaidModelArray allAmount:totalAmount];
            }
        }
    } failure:^(__kindof YTKBaseRequest *request) {
        if (self.delegete && [self.delegete respondsToSelector:@selector(requestNoPaidBillListFailure)]) {
            [self.delegete requestNoPaidBillListFailure];
        }
    }];
}
#pragma mark - 请求分期历史账单列表
- (void)reuestPeriodHistoryBillListWithPageNum:(NSInteger)page
{
    [SVProgressHUD showLoading];
    MallHistoryBillApi *mallHistoryApi = [[MallHistoryBillApi alloc] initWithPageNum:page];
    [mallHistoryApi requestWithSuccess:^(NSDictionary *responseDict) {
        [SVProgressHUD dismiss];
        NSString *codeStr = [responseDict[@"code"] description];
        if ([codeStr isEqualToString:@"1000"]) {
            
            NSArray *histotyBillArray = responseDict[@"data"][@"billList"];
            
            NSArray *historyModelArray = [PeriodBillListModel mj_objectArrayWithKeyValuesArray:histotyBillArray];
            if (self.delegete && [self.delegete respondsToSelector:@selector(requestPeriodHistoryBillListSuccess:)]) {
                [self.delegete requestPeriodHistoryBillListSuccess:historyModelArray];
            }
        }
    } failure:^(__kindof YTKBaseRequest *request) {
        [SVProgressHUD dismiss];
    }];
}

#pragma mark - 请求消费分期账单详情
- (void)reuestMallBillDetailInfoWithOrderId:(NSString *)orderId
{
    [SVProgressHUD showLoading];
    MallBorrowInfoApi *borrowInfoApi = [[MallBorrowInfoApi alloc] initWithOrderId:orderId];
    [borrowInfoApi requestWithSuccess:^(NSDictionary *responseDict) {
        [SVProgressHUD dismiss];
        NSString *codeStr = [responseDict[@"code"] description];
        if ([codeStr isEqualToString:@"1000"]) {
            
            NSDictionary *billDetailDict = responseDict[@"data"];
            
            MallBillInfoModel *mallInfoModel = [MallBillInfoModel mj_objectWithKeyValues:billDetailDict];
            
            if (self.delegete && [self.delegete respondsToSelector:@selector(requestMallBillDetailInfoSuccess:)]) {
                [self.delegete requestMallBillDetailInfoSuccess:mallInfoModel];
            }
        }
    } failure:^(__kindof YTKBaseRequest *request) {
        [SVProgressHUD dismiss];
    }];
}



#pragma mark - 请求白领贷分期账单详情
- (void)reuestWhiteLoanDetailInfoWithBorrowId:(NSString *)borrowId
{
    [SVProgressHUD showLoading];
    WhiteLoanDetailApi *whiteLoanApi = [[WhiteLoanDetailApi alloc] initWithBorrowId:borrowId];
    [whiteLoanApi requestWithSuccess:^(NSDictionary *responseDict) {
        [SVProgressHUD dismiss];
        NSString *codeStr = [responseDict[@"code"] description];
        if ([codeStr isEqualToString:@"1000"]) {
            
            NSDictionary *billDetailDict = responseDict[@"data"];
            WhiteLoanInfoModel *whiteLoanInfoModel = [WhiteLoanInfoModel mj_objectWithKeyValues:billDetailDict];
            
            if (self.delegete && [self.delegete respondsToSelector:@selector(requestWhiteLoanDetailInfoSuccess:)]) {
                [self.delegete requestWhiteLoanDetailInfoSuccess:whiteLoanInfoModel];
            }
        }
    } failure:^(__kindof YTKBaseRequest *request) {
        [SVProgressHUD dismiss];
    }];
}

@end

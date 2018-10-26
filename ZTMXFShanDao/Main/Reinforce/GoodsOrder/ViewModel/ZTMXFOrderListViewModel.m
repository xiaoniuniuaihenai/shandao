//
//  OrderListViewModel.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2018/1/11.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "ZTMXFOrderListViewModel.h"
#import "OrderListApi.h"
#import "OrderListModel.h"
#import "CancelOrderApi.h"
#import "ConfirmReceiveApi.h"

@implementation ZTMXFOrderListViewModel

/** 根据页面获取订单列表 */
- (void)requestOrderListWithPageNumber:(NSInteger)pageNumber showLoading:(BOOL)showLoad{
    if (showLoad) {
        [SVProgressHUD showLoading];
    }
    OrderListApi *orderListApi = [[OrderListApi alloc] initWithPageNumber:pageNumber];
    [orderListApi requestWithSuccess:^(NSDictionary *responseDict) {
        [SVProgressHUD dismiss];
        NSString * codeStr = [responseDict[@"code"]description];
        if ([codeStr isEqualToString:@"1000"]) {
            NSArray *orderArray = [OrderListModel mj_objectArrayWithKeyValuesArray:responseDict[@"data"][@"orderList"]];
            if (self.delegate && [self.delegate respondsToSelector:@selector(requestOrderListSuccessWithPageNumber:orderArray:)]) {
                [self.delegate requestOrderListSuccessWithPageNumber:pageNumber orderArray:orderArray];
                return ;
            }
        }
        
        //   失败处理
        if (self.delegate && [self.delegate respondsToSelector:@selector(requestOrderListFailure)]) {
            [self.delegate requestOrderListFailure];
        }
    } failure:^(__kindof YTKBaseRequest *request) {
        [SVProgressHUD dismiss];
        if (self.delegate && [self.delegate respondsToSelector:@selector(requestOrderListFailure)]) {
            [self.delegate requestOrderListFailure];
        }
    }];
}


/** 确认收货 */
- (void)requestOrderConfirmReceiveWithOrderId:(NSString *)orderId{
    [SVProgressHUD showLoading];
    ConfirmReceiveApi *confirmReceiveApi = [[ConfirmReceiveApi alloc] initWithOrderId:orderId];
    [confirmReceiveApi requestWithSuccess:^(NSDictionary *responseDict) {
        [SVProgressHUD dismiss];
        NSString * codeStr = [responseDict[@"code"]description];
        if ([codeStr isEqualToString:@"1000"]) {
            if (self.delegate && [self.delegate respondsToSelector:@selector(requestOrderConfirmReceiveSuccess)]) {
                [self.delegate requestOrderConfirmReceiveSuccess];
            }
        }
    } failure:^(__kindof YTKBaseRequest *request) {
        [SVProgressHUD dismiss];
    }];
}
/** 取消订单 */
- (void)requestCancelOrderWithOrderId:(NSString *)orderId{
    [SVProgressHUD showLoading];
    CancelOrderApi *cancelOrderApi = [[CancelOrderApi alloc] initWithOrderId:orderId];
    [cancelOrderApi requestWithSuccess:^(NSDictionary *responseDict) {
        [SVProgressHUD dismiss];
        NSString * codeStr = [responseDict[@"code"]description];
        if ([codeStr isEqualToString:@"1000"]) {
            if (self.delegate && [self.delegate respondsToSelector:@selector(requestCancelOrderSuccess)]) {
                [self.delegate requestCancelOrderSuccess];
            }
        }
    } failure:^(__kindof YTKBaseRequest *request) {
        [SVProgressHUD dismiss];
    }];
}
@end

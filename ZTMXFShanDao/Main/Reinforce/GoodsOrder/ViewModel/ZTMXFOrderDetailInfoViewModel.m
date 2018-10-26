//
//  OrderDetailInfoViewModel.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2018/1/11.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "ZTMXFOrderDetailInfoViewModel.h"
#import "OrderDetailInfoApi.h"
#import "OrderDetailInfoModel.h"
#import "LSOrderDetailApi.h"
#import "MyOrderModel.h"

@implementation ZTMXFOrderDetailInfoViewModel

/** 获取商城订单详情信息 */
- (void)requestMallOrderDetailInfoWithOrderId:(NSString *)orderId showLoading:(BOOL)showLoad{
    if (showLoad) {
        [SVProgressHUD showLoading];
    }
    OrderDetailInfoApi *orderDetailInfoApi = [[OrderDetailInfoApi alloc] initWithOrderId:orderId];
    [orderDetailInfoApi requestWithSuccess:^(NSDictionary *responseDict) {
        NSString * codeStr = [responseDict[@"code"]description];
        if ([codeStr isEqualToString:@"1000"]) {
            OrderDetailInfoModel *orderDetailInfoModel = [OrderDetailInfoModel mj_objectWithKeyValues:responseDict[@"data"][@"orderInfo"]];
            if (self.delegate && [self.delegate respondsToSelector:@selector(requestMallOrderDetailInfoSuccess:)]) {
                [self.delegate requestMallOrderDetailInfoSuccess:orderDetailInfoModel];
            }
        }
        [SVProgressHUD dismiss];
    } failure:^(__kindof YTKBaseRequest *request) {
        [SVProgressHUD dismiss];
    }];
}



/** 获取消费贷订单详情信息 */
- (void)requestConsumeLoanOrderDetailInfoWithOrderId:(NSString *)orderId showLoading:(BOOL)showLoad{
    if (showLoad) {
        [SVProgressHUD showLoading];
    }
    LSOrderDetailApi *orderDetailApi = [[LSOrderDetailApi alloc] initWithOrderId:orderId];
    [orderDetailApi requestWithSuccess:^(NSDictionary *responseDict) {
        [SVProgressHUD dismiss];
        NSString *codeStr = [responseDict[@"code"] description];
        if ([codeStr isEqualToString:@"1000"]) {
            NSDictionary *orderDict = responseDict[@"data"][@"consumOrder"];
            MyOrderDetailModel *orderDetailModel = [MyOrderDetailModel mj_objectWithKeyValues:orderDict];
            if (self.delegate && [self.delegate respondsToSelector:@selector(requestConsumeLoanOrderDetailInfoSuccess:)]) {
                [self.delegate requestConsumeLoanOrderDetailInfoSuccess:orderDetailModel];
            }
        }
    } failure:^(__kindof YTKBaseRequest *request) {
        [SVProgressHUD dismiss];
    }];
}

@end

//
//  PaymentOrderViewModel.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2018/1/11.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "PaymentOrderViewModel.h"
#import "ZTMXFOrderPayDetailApi.h"
#import "OrderPayDetailModel.h"

@implementation PaymentOrderViewModel





/** 获取支付订单页面信息 */
- (void)requestPaymentOrderViewInfoWithOrderId:(NSString *)orderId{
    [SVProgressHUD showLoading];
    ZTMXFOrderPayDetailApi *orderPayDetailApi = [[ZTMXFOrderPayDetailApi alloc] initWithOrderId:orderId];
    [orderPayDetailApi requestWithSuccess:^(NSDictionary *responseDict) {
        NSString * codeStr = [responseDict[@"code"]description];
        if ([codeStr isEqualToString:@"1000"]) {
            OrderPayDetailModel *orderPayDetailModel = [OrderPayDetailModel mj_objectWithKeyValues:responseDict[@"data"]];
            if (self.delegate && [self.delegate respondsToSelector:@selector(requestPaymentOrderViewInfoSuccess:)]) {
                [self.delegate requestPaymentOrderViewInfoSuccess:orderPayDetailModel];
            }
        }
        [SVProgressHUD dismiss];
    } failure:^(__kindof YTKBaseRequest *request) {
        [SVProgressHUD dismiss];
    }];

    
}

@end

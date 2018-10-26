//
//  LSOrderViewModel.m
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2017/12/12.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "LSOrderViewModel.h"
#import "LSMyOrderApi.h"
#import "MyOrderModel.h"
#import "LSOrderDetailApi.h"

@implementation LSOrderViewModel

- (void)requestOrderListDataWithPageNum:(NSInteger)page{
    
    LSMyOrderApi *myorderApi = [[LSMyOrderApi alloc] initWithPageNum:page];
    [myorderApi requestWithSuccess:^(NSDictionary *responseDict) {
        
        NSString *codeStr = [responseDict[@"code"] description];
        if ([codeStr isEqualToString:@"1000"]) {
            NSArray *orderArray = responseDict[@"data"][@"list"];
            NSArray *orderModelArray = [MyOrderModel mj_objectArrayWithKeyValuesArray:orderArray];
            
            if (self.delegete && [self.delegete respondsToSelector:@selector(requestOrderListDataSuccess:)]) {
                [self.delegete requestOrderListDataSuccess:orderModelArray];
            }
        }
        
    } failure:^(__kindof YTKBaseRequest *request) {
        if (self.delegete && [self.delegete respondsToSelector:@selector(requestOrderDataFailure)]) {
            [self.delegete requestOrderDataFailure];
        }
    }];
}

- (void)requestOrderDetailWithOrderId:(NSString *)orderId{
    
    LSOrderDetailApi *orderDetailApi = [[LSOrderDetailApi alloc] initWithOrderId:orderId];
    [orderDetailApi requestWithSuccess:^(NSDictionary *responseDict) {
        
        NSString *codeStr = [responseDict[@"code"] description];
        if ([codeStr isEqualToString:@"1000"]) {
            NSDictionary *orderDict = responseDict[@"data"][@"consumOrder"];
            MyOrderDetailModel *orderDetailModel = [MyOrderDetailModel mj_objectWithKeyValues:orderDict];
            
            if (self.delegete && [self.delegete respondsToSelector:@selector(requestOrderDetailSuccess:)]) {
                [self.delegete requestOrderDetailSuccess:orderDetailModel];
            }
        }
        
    } failure:^(__kindof YTKBaseRequest *request) {
        if (self.delegete && [self.delegete respondsToSelector:@selector(requestOrderDataFailure)]) {
            [self.delegete requestOrderDataFailure];
        }
    }];
}

@end

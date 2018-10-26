//
//  LogisticsInfoViewModel.m
//  ZTMXFXunMiaoiOS
//
//  Created by 朱吉达 on 2018/1/14.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "ZTMXFLogisticsInfoViewModel.h"
#import "LogistcsInfoModel.h"
#import "LogisticsInfoApi.h"
@implementation ZTMXFLogisticsInfoViewModel
-(void)requestLogistcsInfoDataWithOrderId:(NSString*)orderId type:(NSString *)type
{
    [SVProgressHUD showLoadingWithOutMask];
    LogisticsInfoApi * infoApi = [[LogisticsInfoApi alloc]initWithOrderId:orderId type:type];
    [infoApi requestWithSuccess:^(NSDictionary *responseDict) {
        NSString * codeStr = [responseDict[@"code"]description];
        if ([codeStr isEqualToString:@"1000"]) {
            NSDictionary * dicData = responseDict[@"data"];
            LogistcsInfoModel * infoModel = [LogistcsInfoModel mj_objectWithKeyValues:dicData];
            if ([_delegate respondsToSelector:@selector(requestLogistcsInfoSuccess:)]) {
                [_delegate requestLogistcsInfoSuccess:infoModel];
            }
        }
        [SVProgressHUD dismiss];
    } failure:^(__kindof YTKBaseRequest *request) {
        [SVProgressHUD dismiss];
    }];
}

@end

//
//  LSLoanRenewalViewModel.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/11/17.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "LSLoanRenewalViewModel.h"
#import "LSBrwGetConfirmRenewalApi.h"
#import "LSBrwRenewalaInfoModel.h"

@implementation LSLoanRenewalViewModel

#pragma mark - 请求延期还款页面信息接口
- (void)requestLoanRenewalViewInfoWithBorrowId:(NSString *)borrowId loanType:(LoanType)loanType{
    [SVProgressHUD showLoading];
    LSBrwGetConfirmRenewalApi *renewalApi = [[LSBrwGetConfirmRenewalApi alloc] initWithBorrowId:borrowId loanType:loanType];
    [renewalApi requestWithSuccess:^(NSDictionary *responseDict) {
        NSString * codeStr = [responseDict[@"code"]description];
        NSLog(@"\n%s\n%@",__func__,responseDict);
        if ([codeStr isEqualToString:@"1000"]) {
            LSBrwRenewalaInfoModel *renewalModel = [LSBrwRenewalaInfoModel mj_objectWithKeyValues:responseDict[@"data"]];
            if (self.delegate && [self.delegate respondsToSelector:@selector(requestLoanRenewalViewInfoSuccess:)]) {
                [self.delegate requestLoanRenewalViewInfoSuccess:renewalModel];
            }
        }
        [SVProgressHUD dismiss];
    } failure:^(__kindof YTKBaseRequest *request) {
        [SVProgressHUD dismiss];
    }];
}



@end

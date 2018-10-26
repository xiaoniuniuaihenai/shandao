//
//  LSLoanRenewalViewModel.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/11/17.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LSBrwRenewalaInfoModel;

@protocol LSLoanRenewalViewModelDelegate<NSObject>

/** 成功获取借钱首页数据 */
- (void)requestLoanRenewalViewInfoSuccess:(LSBrwRenewalaInfoModel *)renewalInfoModel;

@end


@interface LSLoanRenewalViewModel : NSObject

@property (nonatomic, weak) id<LSLoanRenewalViewModelDelegate> delegate;

//  请求延期还款页面信息接口
- (void)requestLoanRenewalViewInfoWithBorrowId:(NSString *)borrowId loanType:(LoanType)loanType;

@end

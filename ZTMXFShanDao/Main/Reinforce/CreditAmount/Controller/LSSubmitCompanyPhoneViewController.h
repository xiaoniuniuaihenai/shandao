//
//  LSSubmitCompanyPhoneViewController.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/12/13.
//  Copyright © 2017年 LSCredit. All rights reserved.
//  填写单位电话

#import "BaseViewController.h"

@protocol SubmitCompanyPhoneViewDelegate <NSObject>

/** 提交公司号码成功 */
- (void)submitCompanyPhoneViewSuccess:(NSString *)companyPhone;

@end

@interface LSSubmitCompanyPhoneViewController : BaseViewController

/** 公司电话 */
@property (nonatomic, copy) NSString *companyPhone;
@property (nonatomic, weak) id<SubmitCompanyPhoneViewDelegate> delegate;

@end

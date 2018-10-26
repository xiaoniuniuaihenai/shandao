//
//  LSPhoneOperationAuthViewController.h
//  ALAFanBei
//
//  Created by yangpenghua on 17/2/15.
//  Copyright © 2017年 讯秒. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LSPhoneOperationAuthViewDelegate <NSObject>
/** 手机运营商认证成功 */
- (void)phoneOperationAuthViewSuccessAuth;

@end
#import "BaseViewController.h"
@interface LSPhoneOperationAuthViewController : BaseViewController

@property (nonatomic, weak) id<LSPhoneOperationAuthViewDelegate> delegate;

/** 是否认证流程进入 */
@property (nonatomic, assign) BOOL isJumpFromAuthVC;

/** 借款类型 */
@property (nonatomic, assign) LoanType loanType;

@end

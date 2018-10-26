//
//  LSCreditAuthWebViewController.h
//  ALAFanBei
//
//  Created by yangpenghua on 17/2/23.
//  Copyright © 2017年 讯秒. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZhiMaCreditModel;

typedef void(^ZhiMaPopBlock)(void);

@protocol LSCreditAuthWebViewDelegate <NSObject>

@optional
//  获取芝麻信用分
- (void)creditAuthWebViewCreditScore:(ZhiMaCreditModel *)creditModel;

@end
#import "BaseViewController.h"
@interface LSCreditAuthWebViewController : BaseViewController
/** 芝麻信用验证URL */
@property (nonatomic, copy) NSString *webUrl;

/** 芝麻信用认证完成代理 */
@property (nonatomic, weak) id<LSCreditAuthWebViewDelegate> delegate;

/** 是否认证流程进入 */
@property (nonatomic, assign) BOOL isJumpFromAuthVC;

/** 借款类型 */
@property (nonatomic, assign) LoanType loanType;

@property (nonatomic, copy) ZhiMaPopBlock zhiMaPopBlock;

@end

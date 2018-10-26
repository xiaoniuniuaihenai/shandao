//
//  MallAuthManager.h
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2018/1/13.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LSAuthInfoModel;
@class OrderPayDetailModel;

typedef void(^MallAuthPassHandle)(NSInteger authStatus);

typedef void(^MallAuthStatusInfo)(LSAuthInfoModel *mallAuthInfo);

@interface ZTMXFMallAuthManager : NSObject

/** 是否跳转到消费分期认证流程 */
+ (BOOL)jumpToMallAuthVCWithOrderDetail:(OrderPayDetailModel *)orderDetailModel;

/** 获取消费分期认证状态 */
+ (void)getMallAuthStatus:(MallAuthStatusInfo)mallAuthInfo;

/** 消费分期去认证状态跳转 */
+ (void)mallAuthStatusWithWithAuthType:(LoanType)loanType AuthPass:(MallAuthPassHandle)mallAuthPass;

@end

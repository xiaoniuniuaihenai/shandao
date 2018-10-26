//
//  LSCreditAuthViewModel.h
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2017/12/28.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LSCompanyInfoModel;
@class LSCreditAuthModel;
@class LSMallCreditInfoModel;
@class LSAuthInfoModel;

@protocol LSCreditAuthViewModelDelegete <NSObject>

@optional

/** 获取公司认证信息成功 */
- (void)getCompanyAuthInfoSuccess:(LSCompanyInfoModel *)companyInfoModel;

/** 提交公司认证成功 */
- (void)sumitCompanyAuthSuccess;

/** 获取认证状态信息成功 */
- (void)requestCreditAuthStatusSuccess:(LSCreditAuthModel *)creditAuthModel;

/** 获取分期商城认证状态信息成功 */
- (void)requestMallCreditAuthInfoSuccess:(LSMallCreditInfoModel *)mallCreditAuthInfoModel;

/** 获取风控认证状态信息成功 */
- (void)requestCreditAuthInfoSuccess:(LSAuthInfoModel *)authInfoModel;

@end

@interface LSCreditAuthViewModel : NSObject

@property (nonatomic, weak) id <LSCreditAuthViewModelDelegete> delegete;

/** 获取公司认证信息 */
- (void)getCompanyAuthInfo;

/** 提交公司认证信息 */
- (void)sumitCompanyAuthInfoWithDict:(NSDictionary *)params;

/** 获取未登录认证信息 */
- (void)requestCreditAuthInfoWithOutLogin;

/** 获取认证状态信息 */
- (void)requestCreditAuthStatus;

/** 获取分期商城认证状态信息 */
- (void)requestMallCreditAuthInfoStatus;

/** 获取风控认证状态信息 */
- (void)requestCreditAuthInfoStatusWithType:(NSString *)authType;

@end

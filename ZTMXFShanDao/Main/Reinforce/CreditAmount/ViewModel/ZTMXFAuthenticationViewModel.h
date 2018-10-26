//
//  AuthenticationViewModel.h
//  JiBeiCreditConsume
//
//  Created by yangpenghua on 2017/11/22.
//  Copyright © 2017年 jibei. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LSPromoteCreditInfoModel;
@class LSAuthSupplyCertifyModel;
@class LSMallCreditInfoModel;
@class LSAuthInfoModel;

@protocol AuthenticationViewModelDelegate<NSObject>

@optional
/** 获取消费贷认证信息成功 */
- (void)requestBaseAuthSuccess:(LSPromoteCreditInfoModel *)baseAuthInfoModel;
/** 获取白领贷认证信息成功 */
- (void)requestPromoteAuthSuccess:(LSAuthSupplyCertifyModel *)promoteAuthInfoModel;
/** 获取分期商城认证状态信息成功 */
- (void)requestMallCreditAuthInfoSuccess:(LSMallCreditInfoModel *)mallCreditAuthInfoModel;
/** 获取风控认证状态信息成功 */
- (void)requestCreditAuthInfoSuccess:(LSAuthInfoModel *)authInfoModel;
/** 补充认证（认证中）设置完成成功 */
- (void)requestAuthSupplyVerifyingSuccess;

/** 提交强分控成功 */
- (void)requestSubmitStrongRiskSuccess:(NSDictionary *)successDict;

@end

@interface ZTMXFAuthenticationViewModel : NSObject

/** 获取去基础认证信息 */
- (void)requestBaseAuthInfoApi;
/** 获取去提升额度认证信息 */
- (void)requestPromoteAuthInfoApi;
/** 获取分期商城认证状态信息 */
- (void)requestMallCreditAuthInfoStatus;
/** 获取风控认证状态信息 */
- (void)requestCreditAuthInfoStatusWithType:(NSString *)authType;
/** 补充认证（认证中）设置完成 */
- (void)requestAuthSupplyVerifyingType:(AuthSupplyType)verfyingType;

/** 提交风控认证获取额度 */
- (void)requestSubmitStrongRiskApiWithAuthType:(LoanType)authType entranceType:(NSString *)entrance Latitude:(NSString *)latitude Longitude:(NSString *)longitude;

@property (nonatomic, weak) id<AuthenticationViewModelDelegate> delegate;

@end

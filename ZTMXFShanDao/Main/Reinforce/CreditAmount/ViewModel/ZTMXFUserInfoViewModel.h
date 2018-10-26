//
//  UserInfoViewModel.h
//  JiBeiCreditConsume
//
//  Created by yangpenghua on 2017/11/23.
//  Copyright © 2017年 jibei. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UserInfoModel;

typedef void(^ requestSuccess)(UserInfoModel *userInfoModel);

@protocol UserInfoViewModelDelegate <NSObject>

@optional
/** 获取验证码成功 */
- (void)bindingCardGainVerityCodeSuccess:(NSString *)bankId;
/** 获取验证码失败 */
- (void)bindingCardGainVerityCodeFailure;

/** 绑定银行卡成功 */
- (void)bindingCardSuccess;

/** 支付密码设置成功 */
- (void)requestSetupPayPasswordSuccess;

/** 获取实名认证类型成功 */
- (void)requestRealNameAuthSuccessAuthType:(RealNameAuthenticationType)authType nameEdit:(BOOL)edit;

/** 获取芝麻信用url成功 */
- (void)requestZhiMaUrlSuccess:(NSDictionary *)zhiMaUrlDic;


@end

@interface ZTMXFUserInfoViewModel : NSObject

@property (nonatomic, weak) id<UserInfoViewModelDelegate> delegate;

/** 获取用户个人信息 */
- (void)requestUserInfoSuccess:(requestSuccess)complete;

/** 获取绑卡验证码 */
- (void)requestBindingCardVerifyCode:(NSString *)idNumber phoneNumber:(NSString *)phoneNumber bandCode:(NSString *)code bankName:(NSString *)name;

/** 绑定银行卡 */
- (void)requestBindingCardSubmitCardId:(NSString *)cardId verityCode:(NSString *)code;

/** 设置支付密码 */
- (void)requestSetupPayPassword:(NSString *)password idNumber:(NSString *)idNumber;

/** 获取实名认证类型 */
- (void)requestRealNameAuthType;

/** 获取芝麻信用url */
- (void)requestZhiMaAuthUrl;

@end

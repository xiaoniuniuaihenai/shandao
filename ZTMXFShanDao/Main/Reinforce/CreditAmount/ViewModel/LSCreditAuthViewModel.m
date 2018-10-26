//
//  LSCreditAuthViewModel.m
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2017/12/28.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "LSCreditAuthViewModel.h"
#import "LSCompanyAuthApi.h"
#import "LSCompanyInfoApi.h"
#import "LSCompanyInfoModel.h"
#import "LSCreditAuthApi.h"
#import "LSCreditAuthModel.h"
#import "LSMallAuthInfoApi.h"
#import "LSMallCreditInfoModel.h"
#import "LSGetAuthInfoApi.h"
#import "LSAuthInfoModel.h"
#import "LSCreditWithOutLoginApi.h"

@implementation LSCreditAuthViewModel



/** 提交公司认证信息 */
- (void)sumitCompanyAuthInfoWithDict:(NSDictionary *)params{
    [SVProgressHUD showLoading];
    LSCompanyAuthApi *companyApi = [[LSCompanyAuthApi alloc] initWithCompanyAuthParams:params];
    [companyApi requestWithSuccess:^(NSDictionary *responseDict) {
        [SVProgressHUD dismiss];
        NSString * codeStr = [responseDict[@"code"]description];
        if ([codeStr isEqualToString:@"1000"]) {
            if (self.delegete && [self.delegete respondsToSelector:@selector(sumitCompanyAuthSuccess)]) {
                [self.delegete sumitCompanyAuthSuccess];
            }
        }
        
    } failure:^(__kindof YTKBaseRequest *request) {
        [SVProgressHUD dismiss];
    }];
}

/** 获取未登录认证信息 */
- (void)requestCreditAuthInfoWithOutLogin
{
    LSCreditWithOutLoginApi *creditWithOutLoginApi = [[LSCreditWithOutLoginApi alloc] init];
    [creditWithOutLoginApi requestWithSuccess:^(NSDictionary *responseDict) {
        NSString * codeStr = [responseDict[@"code"]description];
        if ([codeStr isEqualToString:@"1000"]) {
            LSCreditAuthModel *creditAuthModel = [LSCreditAuthModel mj_objectWithKeyValues:responseDict[@"data"]];
            creditAuthModel.ballAllNum = creditAuthModel.ballNum;//  未登录状态可用和总额保持一致
            if (self.delegete && [self.delegete respondsToSelector:@selector(requestCreditAuthStatusSuccess:)]) {
                [self.delegete requestCreditAuthStatusSuccess:creditAuthModel];
            }
        }
    } failure:^(__kindof YTKBaseRequest *request) {
        
    }];
}

/** 获取认证状态信息 */
- (void)requestCreditAuthStatus
{
    LSCreditAuthApi *creditAuthApi = [[LSCreditAuthApi alloc] init];
    [creditAuthApi requestWithSuccess:^(NSDictionary *responseDict) {
        NSString * codeStr = [responseDict[@"code"]description];
        if ([codeStr isEqualToString:@"1000"]) {
            LSCreditAuthModel *creditAuthModel = [LSCreditAuthModel mj_objectWithKeyValues:responseDict[@"data"]];
            if (self.delegete && [self.delegete respondsToSelector:@selector(requestCreditAuthStatusSuccess:)]) {
                [self.delegete requestCreditAuthStatusSuccess:creditAuthModel];
            }
        }
    } failure:^(__kindof YTKBaseRequest *request) {
        
    }];
}

/** 获取分期商城认证状态信息 */
- (void)requestMallCreditAuthInfoStatus
{
    LSMallAuthInfoApi *mallAuthInfoApi = [[LSMallAuthInfoApi alloc] init];
    [mallAuthInfoApi requestWithSuccess:^(NSDictionary *responseDict) {
        NSString * codeStr = [responseDict[@"code"]description];
        if ([codeStr isEqualToString:@"1000"]) {
            LSMallCreditInfoModel *creditAuthModel = [LSMallCreditInfoModel mj_objectWithKeyValues:responseDict[@"data"]];
            if (self.delegete && [self.delegete respondsToSelector:@selector(requestMallCreditAuthInfoSuccess:)]) {
                [self.delegete requestMallCreditAuthInfoSuccess:creditAuthModel];
            }
        }
    } failure:^(__kindof YTKBaseRequest *request) {
        
    }];
}

/** 获取风控认证状态信息 */
- (void)requestCreditAuthInfoStatusWithType:(NSString *)authType
{
    LSGetAuthInfoApi *getAuthInfoApi = [[LSGetAuthInfoApi alloc] initWithAuthType:authType];
    [getAuthInfoApi requestWithSuccess:^(NSDictionary *responseDict) {
        NSString * codeStr = [responseDict[@"code"] description];
        if ([codeStr isEqualToString:@"1000"]) {
            LSAuthInfoModel *authInfoModel = [LSAuthInfoModel mj_objectWithKeyValues:responseDict[@"data"]];
            if (self.delegete && [self.delegete respondsToSelector:@selector(requestCreditAuthInfoSuccess:)]) {
                [self.delegete requestCreditAuthInfoSuccess:authInfoModel];
            }
        }
    } failure:^(__kindof YTKBaseRequest *request) {
        
    }];
}
/** 获取公司认证信息 */
- (void)getCompanyAuthInfo{
    [SVProgressHUD showLoading];
    LSCompanyInfoApi *companyInfoApi = [[LSCompanyInfoApi alloc] init];
    [companyInfoApi requestWithSuccess:^(NSDictionary *responseDict) {
        [SVProgressHUD dismiss];
        NSString * codeStr = [responseDict[@"code"]description];
        if ([codeStr isEqualToString:@"1000"]) {
            LSCompanyInfoModel *companyInfoModel = [LSCompanyInfoModel mj_objectWithKeyValues:responseDict[@"data"]];
            if (self.delegete && [self.delegete respondsToSelector:@selector(getCompanyAuthInfoSuccess:)]) {
                [self.delegete getCompanyAuthInfoSuccess:companyInfoModel];
            }
        }
        
    } failure:^(__kindof YTKBaseRequest *request) {
        [SVProgressHUD dismiss];
    }];
}
@end

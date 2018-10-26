//
//  AuthenticationViewModel.m
//  JiBeiCreditConsume
//
//  Created by yangpenghua on 2017/11/22.
//  Copyright © 2017年 jibei. All rights reserved.
//

#import "ZTMXFAuthenticationViewModel.h"
#import "WJYAlertView.h"

#import "LSPromoteCreditInfoModel.h"
#import "LSAuthSupplyCertifyModel.h"
#import "AddressBookManager.h"

#import "LSAuthStrongRiskApi.h"
#import "LSCreditPromoteInfoApi.h"
#import "LSAuthSupplyCertifyInfoApi.h"

#import "LSMallAuthInfoApi.h"
#import "LSMallCreditInfoModel.h"

#import "LSGetAuthInfoApi.h"
#import "LSAuthInfoModel.h"

#import "LSAuthSupplyVerifyingApi.h"

@implementation ZTMXFAuthenticationViewModel



/** 获取去提升额度认证信息 */
- (void)requestPromoteAuthInfoApi{
    if (![LoginManager loginState]) {
        return;
    }

    LSAuthSupplyCertifyInfoApi * promoteAuthInfoApi =  [[LSAuthSupplyCertifyInfoApi alloc] init];
    [promoteAuthInfoApi requestWithSuccess:^(NSDictionary *responseDict) {
        NSString * codeStr = [responseDict[@"code"]description];
        if ([codeStr isEqualToString:@"1000"]) {
            LSAuthSupplyCertifyModel *promoteAuthInfoModel = [LSAuthSupplyCertifyModel mj_objectWithKeyValues:responseDict[@"data"]];
            if (self.delegate && [self.delegate respondsToSelector:@selector(requestPromoteAuthSuccess:)]) {
                [self.delegate requestPromoteAuthSuccess:promoteAuthInfoModel];
            }
        }
    } failure:^(__kindof YTKBaseRequest *request) {
    }];
}

/** 提交强分控成功 */
- (void)requestSubmitStrongRiskApiWithAuthType:(LoanType)authType entranceType:(NSString *)entrance Latitude:(NSString *)latitude Longitude:(NSString *)longitude{
    [SVProgressHUD showLoading];
    LSAuthStrongRiskApi * riskApi = [[LSAuthStrongRiskApi alloc] initWithAuthType:authType entranceType:entrance Latitude:latitude Longitude:longitude];
    [riskApi requestWithSuccess:^(NSDictionary *responseDict) {
        NSString * codeStr = [responseDict[@"code"]description];
        if ([codeStr isEqualToString:@"1000"]) {
            //    友盟统计提交强风控
            if (self.delegate && [self.delegate respondsToSelector:@selector(requestSubmitStrongRiskSuccess:)]) {
                [self.delegate requestSubmitStrongRiskSuccess:responseDict[@"data"]];
            }
        } else if ([codeStr isEqualToString:@"1315"]) {
            [WJYAlertView showTwoButtonsWithTitle:@"" Message:@"需要重新认证通讯录, 是否进行重新认证" ButtonType:WJYAlertViewButtonTypeDefault ButtonTitle:@"取消" Click:^{
            } ButtonType:WJYAlertViewButtonTypeNone ButtonTitle:@"重新认证" Click:^{
                //  通讯录认证
                AddressBookManager *addressBook = [[AddressBookManager alloc] init];
                [addressBook addressBookAuthWithContact];
            }];
        }
        [SVProgressHUD dismiss];
    } failure:^(__kindof YTKBaseRequest *request) {
        [SVProgressHUD dismiss];
    }];
}
/** 获取去基础认证信息 */
- (void)requestBaseAuthInfoApi{
    if (![LoginManager loginState]) {
        return;
    }
    
    LSCreditPromoteInfoApi * baseAuthInfoApi = [[LSCreditPromoteInfoApi alloc] init];
    [baseAuthInfoApi requestWithSuccess:^(NSDictionary *responseDict) {
        NSString * codeStr = [responseDict[@"code"]description];
        if ([codeStr isEqualToString:@"1000"]) {
            NSDictionary *dataDict = responseDict[@"data"];
            LSPromoteCreditInfoModel *baseAuthInfoModel = [LSPromoteCreditInfoModel mj_objectWithKeyValues:dataDict];
            if (self.delegate && [self.delegate respondsToSelector:@selector(requestBaseAuthSuccess:)]) {
                [self.delegate requestBaseAuthSuccess:baseAuthInfoModel];
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
            if (self.delegate && [self.delegate respondsToSelector:@selector(requestMallCreditAuthInfoSuccess:)]) {
                [self.delegate requestMallCreditAuthInfoSuccess:creditAuthModel];
            }
        }
    } failure:^(__kindof YTKBaseRequest *request) {
        
    }];
}



/** 补充认证（认证中）设置完成 */
- (void)requestAuthSupplyVerifyingType:(AuthSupplyType)verfyingType
{
    LSAuthSupplyVerifyingApi *supplyVerifyApi = [[LSAuthSupplyVerifyingApi alloc] initWithVerifyingType:verfyingType];
    [supplyVerifyApi requestWithSuccess:^(NSDictionary *responseDict) {
        NSString * codeStr = [responseDict[@"code"]description];
        if ([codeStr isEqualToString:@"1000"]) {
            
            if (self.delegate && [self.delegate respondsToSelector:@selector(requestAuthSupplyVerifyingSuccess)]) {
                [self.delegate requestAuthSupplyVerifyingSuccess];
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
        NSString * codeStr = [responseDict[@"code"]description];
        if ([codeStr isEqualToString:@"1000"]) {
            LSAuthInfoModel *authInfoModel = [LSAuthInfoModel mj_objectWithKeyValues:responseDict[@"data"]];
            if (self.delegate && [self.delegate respondsToSelector:@selector(requestCreditAuthInfoSuccess:)]) {
                [self.delegate requestCreditAuthInfoSuccess:authInfoModel];
            }
        }
    } failure:^(__kindof YTKBaseRequest *request) {
        
    }];
}
@end

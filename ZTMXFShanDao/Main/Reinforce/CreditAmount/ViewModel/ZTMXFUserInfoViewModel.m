//
//  UserInfoViewModel.m
//  JiBeiCreditConsume
//
//  Created by yangpenghua on 2017/11/23.
//  Copyright © 2017年 jibei. All rights reserved.
//

#import "ZTMXFUserInfoViewModel.h"
#import "UserInfoModel.h"
#import "GetUserInfoApi.h"
#import "LSGainBankCodeApi.h"
#import "LSBindBankCardApi.h"
#import "LSBindCardSetPayPawApi.h"
#import "LSGetFaceType.h"
#import "LSZhiMaAuthApi.h"

@implementation ZTMXFUserInfoViewModel



/** 获取绑卡验证码 */
- (void)requestBindingCardVerifyCode:(NSString *)idNumber phoneNumber:(NSString *)phoneNumber bandCode:(NSString *)code bankName:(NSString *)name{
    [SVProgressHUD showLoading];
    LSGainBankCodeApi * codeApi = [[LSGainBankCodeApi alloc] initWithCardNumber:idNumber andMobile:phoneNumber andBankCode:code andBankName:name];
    [codeApi requestWithSuccess:^(NSDictionary *responseDict) {
        [SVProgressHUD dismiss];
        NSString * codeStr = [responseDict[@"code"] description];
        if ([codeStr isEqualToString:@"1000"]) {
            NSDictionary * dicData = responseDict[@"data"];
            NSString *bankId = [dicData[@"bankId"] description];
            if (self.delegate && [self.delegate respondsToSelector:@selector(bindingCardGainVerityCodeSuccess:)]) {
                [self.delegate bindingCardGainVerityCodeSuccess:bankId];
            }
            NSLog(@"获取验证码成功");
        } else{
            if (self.delegate && [self.delegate respondsToSelector:@selector(bindingCardGainVerityCodeFailure)]) {
                [self.delegate bindingCardGainVerityCodeFailure];
            }
        }
    } failure:^(__kindof YTKBaseRequest *request) {
        [SVProgressHUD dismiss];
        if (self.delegate && [self.delegate respondsToSelector:@selector(bindingCardGainVerityCodeFailure)]) {
            [self.delegate bindingCardGainVerityCodeFailure];
        }
    }];

}

/** 绑定银行卡 */
- (void)requestBindingCardSubmitCardId:(NSString *)cardId verityCode:(NSString *)code{
    [SVProgressHUD showLoading];
    LSBindBankCardApi * binkApi = [[LSBindBankCardApi alloc] initWithBankId:cardId andVerifyCode:code];
    [binkApi requestWithSuccess:^(NSDictionary *responseDict) {
        [SVProgressHUD dismiss];
        NSString * codeStr = [responseDict[@"code"]description];
        if ([codeStr isEqualToString:@"1000"]) {
            //    友盟统计  绑定银行卡成功
            if (self.delegate && [self.delegate respondsToSelector:@selector(bindingCardSuccess)]) {
                [self.delegate bindingCardSuccess];
            }
        }
    } failure:^(__kindof YTKBaseRequest *request) {
        [SVProgressHUD dismiss];
    }];
}


/** 设置支付密码 */
- (void)requestSetupPayPassword:(NSString *)password idNumber:(NSString *)idNumber{
    [SVProgressHUD showLoading];
    LSBindCardSetPayPawApi * setPawApi = [[LSBindCardSetPayPawApi alloc] initWithIdNumber:idNumber andPaw:password];
    [setPawApi requestWithSuccess:^(NSDictionary *responseDict) {
        [SVProgressHUD dismiss];
        NSString * codeStr = [responseDict[@"code"]description];
        if ([codeStr isEqualToString:@"1000"]) {
            if (self.delegate && [self.delegate respondsToSelector:@selector(requestSetupPayPasswordSuccess)]) {
                [self.delegate requestSetupPayPasswordSuccess];
            }
        }
    } failure:^(__kindof YTKBaseRequest *request) {
        [SVProgressHUD dismiss];
    }];
}


/** 获取实名认证类型 */
- (void)requestRealNameAuthType{
    [SVProgressHUD showLoading];
    LSGetFaceType * faceTypeApi = [[LSGetFaceType alloc]init];
    [faceTypeApi requestWithSuccess:^(NSDictionary *responseDict) {
        [SVProgressHUD dismiss];
        NSString * codeStr = [responseDict[@"code"]description];
        if ([codeStr isEqualToString:@"1000"]) {
            NSDictionary * dicData = responseDict[@"data"];
            //   真实姓名是否可修改
            BOOL nameEdit = YES;
            NSInteger nameEditValue = [[dicData[@"nameEdit"] description] integerValue];
            if (nameEditValue == 1) {
                //  名字可编辑'
                nameEdit = YES;
            } else {
                //  名字不可编辑
                nameEdit = NO;
            }
            //  认证类型
            RealNameAuthenticationType authType = YiTuAuthentication;
            NSString * type = [dicData[@"type"]description];
            if ([type isEqualToString:@"YITU"]) {
                authType = YiTuAuthentication;
            } else {
                authType = FacePlusAuthentication;
            }
            
            if (self.delegate && [self.delegate respondsToSelector:@selector(requestRealNameAuthSuccessAuthType:nameEdit:)]) {
                [self.delegate requestRealNameAuthSuccessAuthType:authType nameEdit:nameEdit];
            }
        }
    } failure:^(__kindof YTKBaseRequest *request) {
        [SVProgressHUD dismiss];
    }];
}

/** 获取芝麻信用url */
- (void)requestZhiMaAuthUrl{
    [SVProgressHUD showLoading];
    LSZhiMaAuthApi *zhiMaAuthApi = [[LSZhiMaAuthApi alloc] init];
    [zhiMaAuthApi requestWithSuccess:^(NSDictionary *responseDict) {
        [SVProgressHUD dismiss];
        NSString * codeStr = [responseDict[@"code"] description];
        if ([codeStr isEqualToString:@"1000"]) {
            NSDictionary *zhiMaUrl = responseDict[@"data"];
            if (self.delegate && [self.delegate respondsToSelector:@selector(requestZhiMaUrlSuccess:)]) {
                [self.delegate requestZhiMaUrlSuccess:zhiMaUrl];
            }
        }
        
    } failure:^(__kindof YTKBaseRequest *request) {
        [SVProgressHUD dismiss];
    }];
}
/** 获取用户个人信息 */
- (void)requestUserInfoSuccess:(requestSuccess)complete{
    GetUserInfoApi * userInfoApi = [[GetUserInfoApi alloc] init];
    [userInfoApi requestWithSuccess:^(NSDictionary *responseDict) {
        [SVProgressHUD dismiss];
        NSString * codeStr = [responseDict[@"code"]description];
        if ([codeStr isEqualToString:@"1000"]) {
            UserInfoModel * userInfoModel = [UserInfoModel mj_objectWithKeyValues:responseDict[@"data"]];
            if (userInfoModel) {
                complete(userInfoModel);
            }
        }
    } failure:^(__kindof YTKBaseRequest *request) {
        [SVProgressHUD dismiss];
    }];
}
@end

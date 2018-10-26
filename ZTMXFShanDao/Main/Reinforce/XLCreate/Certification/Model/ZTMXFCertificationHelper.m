//
//  ZTMXFCertificationHelper.m
//  ZTMXFXunMiaoiOS
//
//  Created by 陈传亮 on 2018/3/9.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "ZTMXFCertificationHelper.h"
#import "LSGetAuthInfoApi.h"
#import "LSAuthInfoModel.h"
#import "RealNameManager.h"
#import "LSAuthResultViewController.h"
#import "ZTMXFCertificationListViewController.h"
@implementation ZTMXFCertificationHelper

+(void)certificationPageJumpWithVC:(UIViewController *)VC
                    periodAuthType:(LoanType)periodAuthType
{
    [SVProgressHUD showLoading];
    NSString * authType = @"";
    if (periodAuthType == ConsumeLoanType) {
        authType = @"2";
    }else if (periodAuthType == MallLoanType){
        authType = @"3";
    }
    LSGetAuthInfoApi *getAuthInfoApi = [[LSGetAuthInfoApi alloc] initWithAuthType:authType];
    [getAuthInfoApi requestWithSuccess:^(NSDictionary *responseDict) {
        [SVProgressHUD dismiss];
        NSString * codeStr = [responseDict[@"code"] description];
        if ([codeStr isEqualToString:@"1000"]) {
            LSAuthInfoModel *authInfoModel = [LSAuthInfoModel mj_objectWithKeyValues:responseDict[@"data"]];
            [ZTMXFCertificationHelper certificationJump:authInfoModel VC:VC periodAuthType:periodAuthType];
        }
    } failure:^(__kindof YTKBaseRequest *request) {
        [SVProgressHUD dismiss];

    }];
}



#pragma mark - 获取认证状态信息
+ (void)certificationJump:(LSAuthInfoModel *)authInfoModel VC:(UIViewController *)VC                     periodAuthType:(LoanType)periodAuthType

{
        if (authInfoModel.currentAuthStatus != -1) {
            ZTMXFCertificationListViewController * certificationListVC = [[ZTMXFCertificationListViewController alloc] init];
            if (periodAuthType == MallLoanType) {
                certificationListVC.title = @"消费分期认证";
            }else{
                certificationListVC.title = @"消费贷认证";
            }
            certificationListVC.loanType = periodAuthType;
            [VC.navigationController pushViewController:certificationListVC animated:YES];
        }else{
            LSAuthResultViewController *authResultVC = [[LSAuthResultViewController alloc] init];
            authResultVC.loanType = periodAuthType;
            authResultVC.authInfoModel = authInfoModel;
            [VC.navigationController pushViewController:authResultVC animated:YES];
        }
    
    
    
    
    
//    if (authInfoModel.currentAuthStatus == 0) {
//        // 未认证
//        if (authInfoModel.facesStatus != 1) {
//            // 跳转到实名认证
//            [RealNameManager realNameWithCurrentVc:VC andRealNameProgress:RealNameProgressIdf isSaveBackVcName:YES loanType:periodAuthType];
//        } else if (authInfoModel.bindCard != 1) {
//            // 跳转到绑卡认证
//            [RealNameManager realNameWithCurrentVc:VC andRealNameProgress:RealNameProgressBindCardMian isSaveBackVcName:YES loanType:periodAuthType];
//        }  else {
//            // 跳转到认证表单页
//            if (periodAuthType == ConsumeLoanType) {
//                // 消费贷认证
//                [RealNameManager realNameWithCurrentVc:VC andRealNameProgress:RealNameProgressConsumeLoan isSaveBackVcName:NO loanType:ConsumeLoanType];
//            } else if (periodAuthType == WhiteLoanType) {
//                // 白领贷认证
//                [RealNameManager realNameWithCurrentVc:VC andRealNameProgress:RealNameProgressWhiteLoan isSaveBackVcName:NO loanType:WhiteLoanType];
//            } else if (periodAuthType == MallLoanType) {
//                // 分期商城认证
//                [RealNameManager realNameWithCurrentVc:VC andRealNameProgress:RealNameProgressMallLoan isSaveBackVcName:NO loanType:MallLoanType];
//            }
//        }
//    } else {
//        // 跳转到认证结果页:-1 认证失败 1 认证通过 2 审核中
//        LSAuthResultViewController *authResultVC = [[LSAuthResultViewController alloc] init];
//        authResultVC.loanType = periodAuthType;
//        authResultVC.authInfoModel = authInfoModel;
//        [VC.navigationController pushViewController:authResultVC animated:YES];
//    }
}








@end

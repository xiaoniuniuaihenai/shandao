//
//  MallAuthManager.m
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2018/1/13.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "ZTMXFMallAuthManager.h"
#import "LSCreditAuthViewModel.h"
#import "LSGetAuthInfoApi.h"
#import "LSAuthInfoModel.h"
#import "RealNameManager.h"
#import "OrderPayDetailModel.h"
#import "ZTMXFCertificationListViewController.h"
@interface ZTMXFMallAuthManager () <LSCreditAuthViewModelDelegete>

@end

@implementation ZTMXFMallAuthManager

#pragma mark - 是否跳转到消费分期认证流程
+ (BOOL)jumpToMallAuthVCWithOrderDetail:(OrderPayDetailModel *)orderDetailModel
{
    UIViewController *currentVc = [self currentViewController];
    if (orderDetailModel.mallStatus != 1) {
        ZTMXFCertificationListViewController * certificationListVC = [[ZTMXFCertificationListViewController alloc] init];
        certificationListVC.title = @"消费分期认证";
        
        certificationListVC.loanType = MallLoanType;
        [currentVc.navigationController pushViewController:certificationListVC animated:YES];
//        }else{
//            LSAuthResultViewController *authResultVC = [[LSAuthResultViewController alloc] init];
//            authResultVC.loanType = periodAuthType;
//            authResultVC.authInfoModel = authInfoModel;
//            [VC.navigationController pushViewController:authResultVC animated:YES];
//        }
        
        // 未认证
//        if (orderDetailModel.faceStatus != 1) {
//            // 跳转到实名认证
//            [RealNameManager realNameWithCurrentVc:currentVc andRealNameProgress:RealNameProgressIdf isSaveBackVcName:YES loanType:MallLoanType];
//        } else if (orderDetailModel.bankStatus != 1) {
//            // 跳转到绑卡认证
//            [RealNameManager realNameWithCurrentVc:currentVc andRealNameProgress:RealNameProgressBindCardMian isSaveBackVcName:YES loanType:MallLoanType];
//        }  else if (orderDetailModel.zmStatus != 1) {
//            // 跳转到芝麻认证
//            [RealNameManager realNameWithCurrentVc:currentVc andRealNameProgress:RealNameProgressZhiMaAuth isSaveBackVcName:YES loanType:MallLoanType];
//        }  else {
//            // 跳转到认证表单页
//            [RealNameManager realNameWithCurrentVc:currentVc andRealNameProgress:RealNameProgressMallLoan isSaveBackVcName:YES loanType:MallLoanType];
//        }
        return NO;
    }
    return YES;
}

#pragma mark - 获取消费分期认证状态
+ (void)getMallAuthStatus:(MallAuthStatusInfo)mallAuthInfo
{
    LSGetAuthInfoApi *getAuthInfoApi = [[LSGetAuthInfoApi alloc] initWithAuthType:@"3"];
    [getAuthInfoApi requestWithSuccess:^(NSDictionary *responseDict) {
        NSString * codeStr = [responseDict[@"code"]description];
        if ([codeStr isEqualToString:@"1000"]) {
            LSAuthInfoModel *authInfoModel = [LSAuthInfoModel mj_objectWithKeyValues:responseDict[@"data"]];
            mallAuthInfo(authInfoModel);
        }
    } failure:^(__kindof YTKBaseRequest *request) {
        
    }];
}

#pragma mark - 消费分期去认证状态跳转
+ (void)mallAuthStatusWithWithAuthType:(LoanType)loanType AuthPass:(MallAuthPassHandle)mallAuthPass
{
    UIViewController *currentVc = [self currentViewController];
    NSString *authType = @"1";
    if (loanType == WhiteLoanType) {
        // 白领贷
        authType = @"1";
    } else if (loanType == ConsumeLoanType) {
        // 消费贷
        authType = @"2";
    } else if (loanType == MallLoanType) {
        // 消费分期
        authType = @"3";
    }
    LSGetAuthInfoApi *getAuthInfoApi = [[LSGetAuthInfoApi alloc] initWithAuthType:authType];
    [getAuthInfoApi requestWithSuccess:^(NSDictionary *responseDict) {
        NSString * codeStr = [responseDict[@"code"]description];
        if ([codeStr isEqualToString:@"1000"]) {
            LSAuthInfoModel *authInfoModel = [LSAuthInfoModel mj_objectWithKeyValues:responseDict[@"data"]];
            if (authInfoModel.currentAuthStatus == 0) {
                // 未认证
                if (authInfoModel.facesStatus != 1) {
                    // 跳转到实名认证
                    [RealNameManager realNameWithCurrentVc:currentVc andRealNameProgress:RealNameProgressIdf isSaveBackVcName:YES loanType:loanType];
                } else if (authInfoModel.bindCard != 1) {
                    // 跳转到绑卡认证
                    [RealNameManager realNameWithCurrentVc:currentVc andRealNameProgress:RealNameProgressBindCardMian isSaveBackVcName:YES loanType:loanType];
                }  else if (authInfoModel.zmStatus != 1) {
                    // 跳转到芝麻认证
                    [RealNameManager realNameWithCurrentVc:currentVc andRealNameProgress:RealNameProgressZhiMaAuth isSaveBackVcName:YES loanType:loanType];
                }  else {
                    // 跳转到认证表单页
                    [RealNameManager realNameWithCurrentVc:currentVc andRealNameProgress:RealNameProgressConsumeLoan isSaveBackVcName:YES loanType:loanType];
                }
            } else {
                // 跳转到认证结果页:-1 认证失败 1 认证通过 2 审核中
                mallAuthPass(authInfoModel.currentAuthStatus);
            }
        }
    } failure:^(__kindof YTKBaseRequest *request) {
        
    }];
}


/** 获取当前控制器 */
+ (UIViewController *)currentViewController{
    //获得当前活动窗口的根视图
    UIViewController* vc = [UIApplication sharedApplication].keyWindow.rootViewController;
    while (1)
    {
        //根据不同的页面切换方式，逐步取得最上层的viewController
        if ([vc isKindOfClass:[UITabBarController class]]) {
            vc = ((UITabBarController*)vc).selectedViewController;
        }
        if ([vc isKindOfClass:[UINavigationController class]]) {
            vc = ((UINavigationController*)vc).visibleViewController;
        }
        if (vc.presentedViewController) {
            vc = vc.presentedViewController;
        }else{
            break;
        }
    }
    return vc;
}

@end

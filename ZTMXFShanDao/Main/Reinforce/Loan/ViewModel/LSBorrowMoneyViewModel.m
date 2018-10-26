//
//  LSBorrowMoneyViewModel.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/11/15.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "LSBorrowMoneyViewModel.h"
#import "LSBorrowHomeInfoModel.h"
#import "LSLoanSupermarketModel.h"
#import "LSLoanSupermarketLabelModel.h"
#import "LSBrwHomeInfoApi.h"
#import "VersionUpdateApi.h"
#import "LSGetLoanSPMListByTabApi.h"
#import "LSGetLoanSPMTabListApi.h"
#import "LSGoodsAccessLoanSPMApi.h"
#import "LSBrwMoneyGetConfirmInfoApi.h"
#import "ZTMXFALAUpgradeAlert.h"
#import "NSString+version.h"
#import "LSBorrwingCashInfoModel.h"
#import "RealNameManager.h"
#import "ZTMXFLSShareViewLaunchImageApi.h"
#import "TabBarControllerConfig.h"
#import "LSBorrowConfirmViewController.h"
#import "ZTMXFCertificationListViewController.h"
#import "ZTMXFSetPasswordAlertView.h"
#import "ShanDaoConfirmLoanViewController.h"
@implementation LSBorrowMoneyViewModel




#pragma mark - 升级接口
- (void)requestUpdateVersionApi{
    VersionUpdateApi *api = [[VersionUpdateApi alloc] init];
    [api requestWithSuccess:^(NSDictionary *responseDict) {
        NSString *codeStr = [responseDict[@"code"] description];
        if ([codeStr isEqualToString:@"1000"]) {
            NSDictionary *dataDict = responseDict[@"data"];
            NSString *description = [dataDict[@"description"] description];
            NSString *appUrl = [dataDict[@"appUrl"] description];
            NSString *versionName = [dataDict[@"versionName"] description];
            NSInteger isForce = [dataDict[@"isForce"] integerValue];
            long version = [dataDict[@"version"] longLongValue];
            long appVersion = [NSString appVersionLongValue];
            if (version > appVersion) {
                NSArray *desc = [description componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
                
                void(^goToAppStore)() = ^{
                    NSString * appUrlStr = [appUrl encodingStringUsingURLEscape];
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:appUrlStr]];
                };
                
                if (isForce == 1) {
                    [ZTMXFALAUpgradeAlert showForceUpgradeAlertWithMessage:desc version:versionName confirmBlock:^{
                        goToAppStore();
                    }];
                } else {
                    [ZTMXFALAUpgradeAlert showNormalUpgradeAlertWithMessage:desc version:versionName confirmBlock:^{
                        goToAppStore();
                    } cancelBlock:^{
                    }];
                }
            }
        }
    } failure:^(__kindof YTKBaseRequest *request) {
        
    }];
}



#pragma mark - 获取借钱首页页面数据
- (void)requestBorrowMoneyViewData{
    LSBrwHomeInfoApi * brwHomeInfoApi = [[LSBrwHomeInfoApi alloc]init];
    [brwHomeInfoApi requestWithSuccess:^(NSDictionary *responseDict) {
        NSString * codeStr = [responseDict[@"code"]description];
        if ([codeStr isEqualToString:@"1000"]) {
            LSBorrowHomeInfoModel *borrowHomeInfoModel = [LSBorrowHomeInfoModel mj_objectWithKeyValues:responseDict[@"data"]];
            if (self.delegate && [self.delegate respondsToSelector:@selector(requestBorrowMoneyViewSuccess:)]) {
                [self.delegate requestBorrowMoneyViewSuccess:borrowHomeInfoModel];
            } else {
                if (self.delegate && [self.delegate respondsToSelector:@selector(requestBorrowMoneyViewFailure)]) {
                    [self.delegate requestBorrowMoneyViewFailure];
                }
            }
        } else {
            if (self.delegate && [self.delegate respondsToSelector:@selector(requestBorrowMoneyViewFailure)]) {
                [self.delegate requestBorrowMoneyViewFailure];
            }
        }
    } failure:^(__kindof YTKBaseRequest *request) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(requestBorrowMoneyViewFailure)]) {
            [self.delegate requestBorrowMoneyViewFailure];
        }
    }];
}

#pragma mark - 获取骨头状态接口
- (void)requestAppReviewState
{
//    LaunchImageApi *api = [[LaunchImageApi alloc] init];
//    [api requestWithSuccess:^(NSDictionary *responseDict) {
//        NSLog(@"%@", responseDict);
//        NSString *codeStr = [responseDict[@"code"] description];
//        if ([codeStr isEqualToString:@"1000"]) {
//            NSDictionary *dataDict = responseDict[@"data"];
//            NSInteger check = [dataDict[@"check"] integerValue];
//            if (check == 1) {
//                //  骨头中
//                [LoginManager saveAppReviewState:YES];
//            } else {
//                //  非骨头状态
//                [LoginManager saveAppReviewState:NO];
//            }
//            [TabBarControllerConfig changeTabBar];
//
//
//        } else {
//            //  骨头中
//            [LoginManager saveAppReviewState:YES];
//
//        }
//    } failure:^(__kindof YTKBaseRequest *request) {
//        //  骨头中
//        [LoginManager saveAppReviewState:YES];
//
//    }];
}

#pragma mark - 根据审核状态修改借-钱tabBar

+ (void)changeTabBarTextAndImage
{
    if (![LoginManager appReviewState]) {
        return;
    }
    ZTMXFLSShareViewLaunchImageApi *api = [[ZTMXFLSShareViewLaunchImageApi alloc] init];
    [api requestWithSuccess:^(NSDictionary *responseDict) {
        NSString *codeStr = [responseDict[@"code"] description];
        if ([codeStr isEqualToString:@"1000"]) {
            NSDictionary *dataDict = responseDict[@"data"];
            NSInteger check = [dataDict[@"check"] integerValue];
            if (check != 1) {
                //  非骨头状态
                [LoginManager saveAppReviewState:NO];
                [TabBarControllerConfig changeTabBar];
            }
        }
    } failure:^(__kindof YTKBaseRequest *request) {
      
    }];
}


#pragma mark - 获取借贷超市类别列表
- (void)requestBorrowMoneyRecommendAliasList{
    LSGetLoanSPMTabListApi * labelListApi = [[LSGetLoanSPMTabListApi alloc]init];
    [labelListApi requestWithSuccess:^(NSDictionary *responseDict) {
        NSString * codeStr = [responseDict[@"code"]description];
        if ([codeStr isEqualToString:@"1000"]) {
            NSArray * aliasListArray = [LSLoanSupermarketLabelModel mj_objectArrayWithKeyValuesArray:responseDict[@"data"][@"tabList"]];
            NSString *findUrl = responseDict[@"data"][@"findUrl"];
            if (self.delegate && [self.delegate respondsToSelector:@selector(requestBorrowMoneyRecommendAliasSuccess:findUrl:)]) {

                [self.delegate requestBorrowMoneyRecommendAliasSuccess:aliasListArray findUrl:findUrl];
                [self requestBorrowMoneyAllMarketsDataWithAlias:aliasListArray];
                return ;
            }
        }
        if (self.delegate && [self.delegate respondsToSelector:@selector(requestBorrowMoneyViewFailure)]) {
            [self.delegate requestBorrowMoneyViewFailure];
        }
    } failure:^(__kindof YTKBaseRequest *request) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(requestBorrowMoneyViewFailure)]) {
            [self.delegate requestBorrowMoneyViewFailure];
        }
    }];
}

#pragma mark - 获得所有的借贷超市列表
- (void)requestBorrowMoneyAllMarketsDataWithAlias:(NSArray *)aliasList{
    
    NSMutableDictionary *dicMoneyGoodsData = [NSMutableDictionary dictionary];
    
    dispatch_group_t group = dispatch_group_create();
    for (int i=0; i<aliasList.count; i++) {
        LSLoanSupermarketLabelModel *goodsModel = aliasList[i];
        LSGetLoanSPMListByTabApi * listByTabApi = [[LSGetLoanSPMListByTabApi alloc] initWithSPMListWithLabel:goodsModel.alias type:_sortingType];
        dispatch_group_enter(group);
        dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            //请求
            [listByTabApi requestWithSuccess:^(NSDictionary *responseDict) {
                NSString * codeStr = [responseDict[@"code"]description];
                if ([codeStr isEqualToString:@"1000"]) {
                    NSArray * arrData = [LSLoanSupermarketModel mj_objectArrayWithKeyValuesArray:responseDict[@"data"][@"supermarketList"]];
                    [dicMoneyGoodsData setValue:arrData forKey:goodsModel.alias];
                }
                dispatch_group_leave(group);
                
            } failure:^(__kindof YTKBaseRequest *request) {
                
                dispatch_group_leave(group);
            }];
            
        });
    }
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        // 返回借贷超市列表的字典
        if (self.delegate && [self.delegate respondsToSelector:@selector(requestBorrowMoneyMarketListsSuccess:)]) {
            [self.delegate requestBorrowMoneyMarketListsSuccess:dicMoneyGoodsData];
        }else{
            if (self.delegate && [self.delegate respondsToSelector:@selector(requestBorrowMoneyViewFailure)]) {
                [self.delegate requestBorrowMoneyViewFailure];
            }
        }
    });
}

#pragma mark - 进入点击进入借贷超市埋点
- (void)requestBorrowMoneyRecommendListEnterWithNumber:(NSString *)number{
    LSGoodsAccessLoanSPMApi * loanSpmApi = [[LSGoodsAccessLoanSPMApi alloc] initWithAccessLoanSPMApiWithLsmNo:number];
    [loanSpmApi requestWithSuccess:^(NSDictionary *responseDict) {
        NSString * codeStr = [responseDict[@"code"]description];
        if ([codeStr isEqualToString:@"1000"]) {
        
        }
    } failure:^(__kindof YTKBaseRequest *request) {
        
    }];
}

#pragma mark - 点击获取确认借钱页面信息跳转到借钱页面
- (void)requestConfirmBorrowMoneyInfoWithBorrowDays:(NSString *)borrowDays amount:(NSString *)amount borrowType:(NSString *)borrowType currentController:(UIViewController *)controller{
    [SVProgressHUD showLoading];
    LSBrwMoneyGetConfirmInfoApi * confirmInfoApi = [[LSBrwMoneyGetConfirmInfoApi alloc] initBrwMoneyGetConfirmInfoWithAmount:amount andBorrowDays:borrowDays andBorrowType:borrowType];
    [confirmInfoApi requestWithSuccess:^(NSDictionary *responseDict) {
        NSString * codeStr = [responseDict[@"code"]description];
        NSMutableDictionary *pointInfo = [[NSMutableDictionary alloc]init];
        [pointInfo setObject:[XLServerBuriedPointHelper wifiMac]?:@"" forKey:@"wifiMac"];
        [pointInfo setObject:[XLServerBuriedPointHelper wifiName]?:@"" forKey:@"wifiName"];
        [(NSDictionary *)[controller valueForKeyPath:@"latitudeAndLongitude"] enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            [pointInfo setObject:obj forKey:key];
        }];
        if ([codeStr isEqualToString:@"1000"]) {
            NSDictionary * dicData = responseDict[@"data"];
            LSBorrwingCashInfoModel * cashInfoModel = [LSBorrwingCashInfoModel mj_objectWithKeyValues:dicData];
            //  当前借钱类型(3表示白领贷 2表示消费贷)
            LoanType loanType = ConsumeLoanType;
            if ([borrowType isEqualToString:kWhiteLoanType]) {
                loanType = WhiteLoanType;
            } else if ([borrowType isEqualToString:kConsumeLoanType]) {
                loanType = ConsumeLoanType;
            }            
            if (loanType == ConsumeLoanType) {
                [ZTMXFUMengHelper mqEvent:k_do_loan parameter:@{@"isLogin":@"YES",@"authStatus":@(cashInfoModel.authStatus).stringValue}];

                if (cashInfoModel.authStatus == 0) {
                    
                    [pointInfo setObject:@(responseDict[@"data"][@"authStatus"]?YES:NO) forKey:@"authStatus"];
                    //后台打点
                    [XLServerBuriedPointHelper xl_BuriedPointWithPointCode:@"jq" PointSubCode:@"submit.jq_qjq" OtherDict:pointInfo];
                    ZTMXFCertificationListViewController * certificationListVC = [[ZTMXFCertificationListViewController alloc] init];
                    certificationListVC.title = @"消费贷认证";
                    certificationListVC.loanType = ConsumeLoanType;
                    [controller.navigationController pushViewController:certificationListVC animated:YES];

                }else if (cashInfoModel.authStatus == 1){
                    
                    [pointInfo setObject:@(responseDict[@"data"][@"hasBorrowed"]?YES:NO) forKey:@"isNewApplicant"];
                    //后台打点
                    [XLServerBuriedPointHelper xl_BuriedPointWithPointCode:@"jq" PointSubCode:@"submit.jq_qjq" OtherDict:pointInfo];

                    ShanDaoConfirmLoanViewController *confirmVc = [[ShanDaoConfirmLoanViewController alloc] init];
                    confirmVc.cashInfoModel = cashInfoModel;
                    [controller.navigationController pushViewController:confirmVc animated:YES];

                }else if (cashInfoModel.authStatus == -1){

                }
        
            } else if (loanType == WhiteLoanType) {
                //  白领贷
                if (cashInfoModel.whiteStatus == 0) {
                    //  未认证跳转到白领贷推广H5页面
                    LSWebViewController *webVC = [[LSWebViewController alloc] init];
                    webVC.webUrlStr = DefineUrlString(kWhiteLoanPromotion);
                    [controller.navigationController pushViewController:webVC animated:YES];
                } else {
                    if (cashInfoModel.faceStatus != 1){
                        //   实名认证
                        [RealNameManager realNameWithCurrentVc:controller andRealNameProgress:RealNameProgressIdf isSaveBackVcName:YES loanType:loanType];
                    } else if (cashInfoModel.isBind != 1){
                        //   跳转绑卡页面
                        [RealNameManager realNameWithCurrentVc:controller andRealNameProgress:RealNameProgressBindCardMian isSaveBackVcName:YES loanType:loanType];
                    }  else if (cashInfoModel.zmStatus != 1) {
                        //  跳转到芝麻认证
                        [RealNameManager realNameWithCurrentVc:controller andRealNameProgress:RealNameProgressZhiMaAuth isSaveBackVcName:YES loanType:loanType];
                    }  else if (cashInfoModel.whiteStatus == 0) {
                        //  未认证跳转到白领贷推广H5页面
                        LSWebViewController *webVC = [[LSWebViewController alloc] init];
                        webVC.webUrlStr = DefineUrlString(kWhiteLoanPromotion);
                        [controller.navigationController pushViewController:webVC animated:YES];
                    } else if (cashInfoModel.whiteStatus == -1 || cashInfoModel.whiteStatus == 2){
                        //  白领贷认证
                        [RealNameManager realNameWithCurrentVc:controller andRealNameProgress:RealNameProgressWhiteLoan isSaveBackVcName:YES];
                    } else if (cashInfoModel.isSetPwd == 0){
                        //   未设置支付密码
                        [RealNameManager realNameWithCurrentVc:controller andRealNameProgress:RealNameProgressSetPayPaw isSaveBackVcName:YES];
                    } else if (cashInfoModel.whiteStatus == 1){
                        //   白领贷借款
                        LSBorrowConfirmViewController *confirmVc = [[LSBorrowConfirmViewController alloc] init];
                        confirmVc.cashInfoModel = cashInfoModel;
                        confirmVc.borrowMoneyType = LSWhiteCollarLoanType;
                        [controller.navigationController pushViewController:confirmVc animated:YES];
                    } else {
                        //  未认证跳转到白领贷推广H5页面
                        LSWebViewController *webVC = [[LSWebViewController alloc] init];
                        webVC.webUrlStr = DefineUrlString(kWhiteLoanPromotion);
                        [controller.navigationController pushViewController:webVC animated:YES];
                    }
                }
            }
        }
        [SVProgressHUD dismiss];
    } failure:^(__kindof YTKBaseRequest *request) {
        [SVProgressHUD dismiss];
    }];
}

@end

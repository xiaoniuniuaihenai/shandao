//
//  HomePageViewModel.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2018/1/3.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "ZTMXFHomePageViewModel.h"
#import "VersionUpdateApi.h"
#import "NSString+version.h"

#import "ZTMXFALAUpgradeAlert.h"
#import "HomePageMallApi.h"
#import "HomePageMallModel.h"
#import "ZTMXFUpgradeAlertView.h"
@implementation ZTMXFHomePageViewModel

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
            if (![LoginManager appReviewState]) {
                long version = [dataDict[@"version"] longLongValue];
                long appVersion = [NSString appVersionLongValue];
                if (version > appVersion) {
                    NSArray *desc = [description componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
                    
                    NSString * appUrlStr = [appUrl encodingStringUsingURLEscape];
//                    void(^goToAppStore)() = ^{
//                        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:appUrlStr]];
//                    };
                    
                    if (isForce == 1) {
                        [ZTMXFUpgradeAlertView showWithMessageArr:desc version:versionName upgradeAlertType:XLPermissionsForce appUrlStr:appUrlStr];
//                        [ALAUpgradeAlert showForceUpgradeAlertWithMessage:desc version:versionName confirmBlock:^{
//                            goToAppStore();
//                        }];
                    } else {
                        [ZTMXFUpgradeAlertView showWithMessageArr:desc version:versionName upgradeAlertType:XLUpgradeAlertDefault appUrlStr:appUrlStr];

//                        [ALAUpgradeAlert showNormalUpgradeAlertWithMessage:desc version:versionName confirmBlock:^{
//                            goToAppStore();
//                        } cancelBlock:^{
//                        }];
                    }
                }
            }
        }
    } failure:^(__kindof YTKBaseRequest *request) {
        
    }];
}




/** 获取首页数据 */
- (void)requestHomePageData{
    HomePageMallApi *homePageMallApi = [[HomePageMallApi alloc] init];
    [homePageMallApi requestWithSuccess:^(NSDictionary *responseDict) {
        NSString * codeStr = [responseDict[@"code"]description];
        if ([codeStr isEqualToString:@"1000"]) {
            HomePageMallModel *homePageMallModel = [HomePageMallModel mj_objectWithKeyValues:responseDict[@"data"]];
            if (self.delegate && [self.delegate respondsToSelector:@selector(requestHomePageSuccess:)]) {
                [self.delegate requestHomePageSuccess:homePageMallModel];
            }
        } else {
            if (self.delegate && [self.delegate respondsToSelector:@selector(requestHomePageFailure)]) {
                [self.delegate requestHomePageFailure];
            }
        }
    } failure:^(__kindof YTKBaseRequest *request) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(requestHomePageFailure)]) {
            [self.delegate requestHomePageFailure];
        }
    }];
}


@end

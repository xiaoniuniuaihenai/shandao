//
//  ZTMXFServerStatisticalHelper.m
//  ZTMXFXunMiaoiOS
//
//  Created by 陈传亮 on 2018/5/23.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "ZTMXFServerStatisticalHelper.h"
#import "UIDevice+FCUUID.h"
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CommonCrypto/CommonDigest.h>
#import "NSDictionary+Additions.h"
#import "ZTMXFPhoneModel.h"
#import "NSString+verify.h"
#import "NSString+Trims.h"
#import "ZTMXFLoginStatisticalApi.h"
#import "HttpTool.h"
#import "NSDictionary+JSONString.h"
#import "ZTMXFServerStatisticalHelper.h"
#import "NSString+md5.h"
#import "UIViewController+Visible.h"
#import "BaseViewController.h"
#import "ZTMXFServerStatisticalApi.h"

#define lastPageType @"lastPageType"


@implementation ZTMXFServerStatisticalHelper


+ (void)loanStatisticalApiWithIntoTime:(NSDate *)date CurrentClassName:(NSString *)className PageName:(NSString *)pageName{
    //当前页面code
    NSString *currentPageCode = [pageName isEqualToString:@""] || !pageName ? [ZTMXFServerStatisticalHelper stepTypeDic][className] : pageName;
    NSString *key_lastPageCode = [USER_DEFAULT stringForKey:lastPageType];
    if (![currentPageCode isKindOfClass:[NSString class]] || !currentPageCode || [currentPageCode isEqualToString:@""]) {
        [USER_DEFAULT setObject:currentPageCode forKey:lastPageType];
        [USER_DEFAULT synchronize];
        return;
    }
    ZTMXFServerStatisticalApi *api = [[ZTMXFServerStatisticalApi alloc]initWithClassName:className PointSubCode:currentPageCode Time:date lastPageCode:key_lastPageCode type:YES];
    api.isHideToast = YES;
    [api requestWithSuccess:^(NSDictionary *responseDict) {
        
    } failure:^(__kindof YTKBaseRequest *request) {
        
    }];
    
}

+ (void)loanStatisticalApiWithIoutTime:(NSDate *)date CurrentClassName:(NSString *)className PageName:(NSString *)pageName{
    //当前页面code
    NSString *currentPageCode = [pageName isEqualToString:@""] || !pageName ? [ZTMXFServerStatisticalHelper stepTypeDic][className] : pageName;
    NSString *key_lastPageCode = [USER_DEFAULT stringForKey:lastPageType];
    [USER_DEFAULT setObject:currentPageCode forKey:lastPageType];
    [USER_DEFAULT synchronize];
    if (![currentPageCode isKindOfClass:[NSString class]] || !currentPageCode || [currentPageCode isEqualToString:@""]) {
        return;
    }
    ZTMXFServerStatisticalApi *api = [[ZTMXFServerStatisticalApi alloc]initWithClassName:className PointSubCode:currentPageCode Time:date lastPageCode:key_lastPageCode type:NO];
    api.isHideToast = YES;
    [api requestWithSuccess:^(NSDictionary *responseDict) {
        
    } failure:^(__kindof YTKBaseRequest *request) {
        
    }];
}

//需要打点的类
+ (NSDictionary *)stepTypeDic{
    return @{
             @"ShanDaoH5ChangePageViewController"           :@"bs_ym_jqzy",
             @"ZTMXFCertificationListViewController"  :@"bs_ym_xfd",
             @"JBScanIdentityCardViewController"      :@"bs_ym_smrz",
             @"LSIdfBindCardViewController"           :@"bs_ym_yhkrz",
             @"LSCreditAuthWebViewController"         :@"bs_ym_zmrz",
             @"LSPhoneOperationAuthViewController"    :@"bs_ym_yysrz",
             @"LSCreditCheckViewController"           :@"bs_ym_shddy",
             @"ShanDaoConfirmLoanViewController"        :@"bs_ym_qrjk",
             @"ShanDaoChooseGoodsViewController"        :@"bs_ym_spxz",
             
             @"LSLoanSuccessViewController"           :@"bs_ym_jkcg",
             @"LSLoanAreaViewController"              :@"bs_ym_jkcg",
             @"ZTMXFCertificationResultViewController":@"bs_ym_qfktg",
             @"LSConsumeLoanAuthReviewViewController" :@"bs_ym_qfkwjg",
             @"LSLoanRepayViewController"             :@"bs_ym_ljhk",
             @"LSPayFailureViewController"            :@"bs_ym_yhkhk",
             @"LSPaySuccessViewController"            :@"bs_ym_yhkhk",
             
             @"ZTMXFChooseBankViewController"         :@"bs_ym_zftk",
             @"ZTMXFPayPWDViewController"             :@"bs_ym_hqzfmm",
             @"ZTMXFHomePageViewController"           :@"bs_ym_sczy",
             @"XLMineViewController"                  :@"bs_ym_wdzy"
             };
};
//不需要打点的类
+ (NSArray *)needDeleteClassName{
    return @[
             @"ZTMXFJBFaceRecognitionViewController"
             ];
}

//  设置基础参数
+ (NSDictionary *)baseDictionary
{
    //    dic = [dic removeForeAndAftWhitespace];
    NSString *idfv = [UIDevice currentDevice].uuid;
    UInt64 time = [[NSDate date] timeIntervalSince1970] * 1000;
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSString *appVersion =[version stringByReplacingOccurrencesOfString:@"." withString:@""];
    NSString *userPhone =[[NSUserDefaults standardUserDefaults] objectForKey:kUserPhoneNumber];
    
    //用来区分渠道
    NSString * bundleName =  [[[NSBundle mainBundle]infoDictionary]objectForKey:@"CFBundleIdentifier"];
    bundleName = [bundleName componentsSeparatedByString:@"."].lastObject;
    NSString *userName =[userPhone length] > 0 ? userPhone : idfv;
    NSString *timeString =[NSString stringWithFormat:@"%llu",time] ;
    NSString *onlyId = [NSString stringWithFormat:@"i_%@_%llu_%@",idfv,time,bundleName];
    NSString *netType =[NSString getNetWorkType];
    NSMutableDictionary *headDict =[[NSMutableDictionary alloc] initWithObjectsAndKeys:appVersion,@"appVersion",userName,@"userName",timeString,@"time",  onlyId,@"id",netType,@"netType",kChannelId,@"channel",kAppSource,@"appSource", nil];
    return headDict;
}

@end

//
//  ThirdSDKConfig.m
//  YuCaiShi
//
//  Created by 陈传亮 on 2017/5/8.
//  Copyright © 2017年 陈传亮. All rights reserved.
//

#import "ThirdSDKConfig.h"
#import "LaunchIntroductionView.h"
#import "ZTMXFLSShareViewLaunchImageApi.h"
#import "TabBarControllerConfig.h"
#import "UIViewController+Visible.h"
#import "SVProgressHUD+XLHelper.h"
#import <UMShare/UMShare.h>
#import "XLGetBizUserIdApi.h"
#import "XLSubmitXbehaviorRiskApi.h"


static NSString *const kAppVersionMeiQi = @"appVersionShanDao";


@implementation ThirdSDKConfig

+ (void)configSDK
{
    [ThirdSDKConfig startCheck];
    //氪信SDK
    [ThirdSDKConfig initCreditXAgent];
    
    // U-Share 平台设置
    [ThirdSDKConfig configUSharePlatforms];
    [ThirdSDKConfig confitUShareSettings];
    [XLServerBuriedPointHelper saveUserInfo];

//    [SVProgressHUD showXLHelperHUD];
}
#pragma mark - 判断是不是首次登录或者版本更新
+(BOOL )isFirstLauch{
    //获取当前版本号
    //    return YES;
    
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString *currentAppVersion = infoDic[@"CFBundleShortVersionString"];
    //获取上次启动应用保存的appVersion
    NSString *version = [[NSUserDefaults standardUserDefaults] objectForKey:kAppVersionMeiQi];
    //版本升级或首次登录
    [[NSUserDefaults standardUserDefaults] synchronize];
    if (version == nil || ![version isEqualToString:currentAppVersion]) {
        return YES;
    }else{
        return NO;
    }
}

+ (void)initCreditXAgent{
    [CreditXAgent initWithAppKey:KCreditXAgentKey];
    [CreditXAgent setAutoRequestContactsAuth:NO];
    [CreditXAgent setAutoRequestLocationAuth:NO];
    
    CXDeviceID *cxDid = [CreditXAgent getCreditXDeviceID];
    
    if ([ThirdSDKConfig isFirstLauch]) {
        [LoginManager loginState] == YES ? ({
            dispatch_group_t group = dispatch_group_create();
            dispatch_group_enter(group);
            
            XLGetBizUserIdApi *api = [[XLGetBizUserIdApi alloc]initWithUserName:[[NSUserDefaults standardUserDefaults] objectForKey:kUserPhoneNumber]];
            api.isHideToast = YES;
            [api requestWithSuccess:^(NSDictionary *responseDict) {
                [CreditXAgent onUserLoginSuccessWithUserID:responseDict[@"data"][@"userId"]?[responseDict[@"data"][@"userId"] description]:@"" loginMethod:CXLoginMethodVerificationCode];
                NSLog(@"第一个接口");
                dispatch_group_leave(group);
                
            } failure:^(__kindof YTKBaseRequest *request) {
                dispatch_group_notify(group, dispatch_get_main_queue(), ^{
                    
                });
            }];
            
            dispatch_group_enter(group);
            
            XLSubmitXbehaviorRiskApi *riskApi = [[XLSubmitXbehaviorRiskApi alloc]initWithCreditValue:CreditXAgent.getCreditXDeviceID.value?:@"" UserName:[[NSUserDefaults standardUserDefaults] objectForKey:kUserPhoneNumber]];
            riskApi.isHideToast = YES;
            [riskApi requestWithSuccess:^(NSDictionary *responseDict) {
                NSLog(@"第二个接口");
                dispatch_group_leave(group);
                
            } failure:^(__kindof YTKBaseRequest *request) {
                dispatch_group_notify(group, dispatch_get_main_queue(), ^{
                    
                });
            }];
            dispatch_group_notify(group, dispatch_get_main_queue(), ^{
                NSLog(@"第三个接口");
                [[NSUserDefaults standardUserDefaults] setObject:[[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"] forKey:kAppVersionMeiQi];
                [[NSUserDefaults standardUserDefaults] synchronize];
            });
            
        }):nil;
    }
    NSLog(@"CreditX Device ID: \n{\n\tValue: %@;\n\tType: %@(%ld)\n}", cxDid.value, [cxDid getTypeName], cxDid.type);

}
+ (void)configUSharePlatforms
{
    /* 设置微信的appKey和appSecret */ //5dec33f0a41ac6b033347726c3d014bd
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wxee4900e5264f7a24" appSecret:@"5dec33f0a41ac6b033347726c3d014bd" redirectURL:@"http://letto8.com"];
    /*
     * 移除相应平台的分享，如微信收藏
     */
    //[[UMSocialManager defaultManager] removePlatformProviderWithPlatformTypes:@[@(UMSocialPlatformType_WechatFavorite)]];
    
    /* 设置分享到QQ互联的appID
     * U-Share SDK为了兼容大部分平台命名，统一用appKey和appSecret进行参数设置，而QQ平台仅需将appID作为U-Share的appKey参数传进即可。
     */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"1107465544"/*设置QQ平台的appID*/  appSecret:@"xLs4jtTiUeKNJGJ5" redirectURL:@"http://letto8.com"];
    
    /* 设置新浪的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:@"3117898992"  appSecret:@"7cf6aa309e19eb1a62f22459c552a1d1" redirectURL:@"http://letto8.com"];
    
    
    
}
+ (void)confitUShareSettings
{
    /*
     * 打开图片水印
     */
    //[UMSocialGlobal shareInstance].isUsingWaterMark = YES;
    
    /*
     * 关闭强制验证https，可允许http图片分享，但需要在info.plist设置安全域名
     <key>NSAppTransportSecurity</key>
     <dict>
     <key>NSAllowsArbitraryLoads</key>
     <true/>
     </dict>
     */
    [UMSocialGlobal shareInstance].isUsingHttpsWhenShareContent = NO;
    
}

+ (void)judgeNotificationStatus
{
    //获取上次启动应用保存的appVersion
    NSString *version = [[NSUserDefaults standardUserDefaults] objectForKey:@"appVersion"];
    //版本升级或首次登录
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    if (version == nil) {
        return;
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        NSDate *date = [NSDate date];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"YYYY-MM-dd"];
        //[dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];设置格式
        NSString *dateStr = [dateFormatter stringFromDate:date];
        if ([[UIApplication sharedApplication] currentUserNotificationSettings].types  == UIRemoteNotificationTypeNone) {//此时用户未开启通知
            NSString *lastTime = [[NSUserDefaults standardUserDefaults]stringForKey:@"judgeNotificationStatusTime"];
            if (![lastTime isEqualToString:dateStr]) {//用户上次打开的时间不是今天
                //弹框
                UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"" message:@"\n\n您还没有为闪到开启通知权限,无法及时接收到优惠活动通知,赶快开通权限吧!\n\n" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction * action1 = [UIAlertAction actionWithTitle:@"我知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [[NSUserDefaults standardUserDefaults]setValue:dateStr forKey:@"judgeNotificationStatusTime"];
                    [[NSUserDefaults standardUserDefaults]synchronize];
                }];
                UIAlertAction * action2 = [UIAlertAction actionWithTitle:@"去开启" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [[NSUserDefaults standardUserDefaults]setValue:dateStr forKey:@"judgeNotificationStatusTime"];
                    [[NSUserDefaults standardUserDefaults]synchronize];
                    
                    NSURL *settingURL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                    [[UIApplication sharedApplication] openURL:settingURL];
                }];
                [alert addAction:action1];
                [action1 setValue:[UIColor lightGrayColor] forKey:@"titleTextColor"];
                
                [alert addAction:action2];
                [action2 setValue:K_MainColor forKey:@"titleTextColor"];
                [[UIViewController currentViewController] presentViewController:alert animated:YES completion:nil];
        }
    }
    });
}

+ (void)startCheck
{
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
                [ThirdSDKConfig judgeNotificationStatus];
                LaunchIntroductionView *launchIntroductionView;
                if (IS_IPHONEX) {
                    launchIntroductionView = [LaunchIntroductionView sharedWithImages:@[@"XL_XianShangYinDao1_X.png",@"XL_XianShangYinDao2_X.png",@"XL_XianShangYinDao3_X.png"] buttonImage:@"" buttonFrame:CGRectMake(0, 0, KW, KH)];
                    
                } else {
                    launchIntroductionView = [LaunchIntroductionView sharedWithImages:@[@"XL_XianShangYinDao1.png",@"XL_XianShangYinDao2.png",@"XL_XianShangYinDao3.png"] buttonImage:@"" buttonFrame:CGRectMake(0, 0, KW, KH)];
                }
                launchIntroductionView.currentColor = [UIColor clearColor];
                launchIntroductionView.nomalColor = [UIColor clearColor];

            }else{
                LaunchIntroductionView *launchIntroductionView;
                if (IS_IPHONEX) {
                    launchIntroductionView = [LaunchIntroductionView sharedWithImages:@[@"XL_YinDao1_X.png",@"XL_YinDao2_X.png",@"XL_YinDao3_X.png"] buttonImage:@"" buttonFrame:CGRectMake(0, 0, KW, KH)];
                    
                }else{
                    launchIntroductionView = [LaunchIntroductionView sharedWithImages:@[@"XL_YinDao1.png",@"XL_YinDao2.png",@"XL_YinDao3.png"] buttonImage:@"" buttonFrame:CGRectMake(0, 0, KW, KH)];
                    
                }
                launchIntroductionView.currentColor = [UIColor clearColor];
                launchIntroductionView.nomalColor = [UIColor clearColor];
                
            }
        }
    } failure:^(__kindof YTKBaseRequest *request) {
        LaunchIntroductionView *launchIntroductionView;
        
        if (IS_IPHONEX) {
            launchIntroductionView = [LaunchIntroductionView sharedWithImages:@[@"XL_YinDao1_X.png",@"XL_YinDao2_X.png",@"XL_YinDao3_X.png"] buttonImage:@"" buttonFrame:CGRectMake(0, 0, KW, KH)];
            
        }else{
            launchIntroductionView = [LaunchIntroductionView sharedWithImages:@[@"XL_YinDao1.png",@"XL_YinDao2.png",@"XL_YinDao3.png"] buttonImage:@"" buttonFrame:CGRectMake(0, 0, KW, KH)];
          
        }
        launchIntroductionView.currentColor = [UIColor clearColor];
        launchIntroductionView.nomalColor = [UIColor clearColor];
    }];
    
}



@end

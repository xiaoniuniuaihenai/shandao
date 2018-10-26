//
//  AppDelegate.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/9/15.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#define XN_LastUserInfo_ForXPush @"XN_LastUserInfo_ForXPush"

#import "AppDelegate.h"
#import "TabBarControllerConfig.h"
#import "HWNewfeatureViewController.h"
#import "AvoidCrash.h"
#import "DisplayInfoView.h"
#import <AMapFoundationKit/AMapServices.h>
#import <IQKeyboardManager/IQKeyboardManager.h>
#import "NSString+DictionaryValue.h"
#import "UIViewController+Visible.h"
#import <MGLivenessDetection/MGLivenessDetection.h>
#import "JPUSHService.h"
// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

#import <YPCashierPay/YPCashierPay.h>
#import "CYLTabBarController.h"

#import "NTalker.h"
#import "XNPushTipView.h"
#import "XNSDKCore.h"
//震动音效
#import <AudioToolbox/AudioToolbox.h>

/** 1.4版本*/
#import "LSCreditCheckViewController.h"

#import "LSMessageManager.h"

#import <UMCommon/UMCommon.h>           // 公共组件是所有友盟产品的基础组件，必选
#import <UMAnalytics/MobClick.h>
#import "ZTMXFPushHelper.h"
#import "LSBorrowMoneyViewModel.h"
#import "ThirdSDKConfig.h"
#import <UMShare/UMShare.h>
@interface AppDelegate ()<UITabBarControllerDelegate, CYLTabBarControllerDelegate, JPUSHRegisterDelegate>

@property (nonatomic, strong) CYLBaseNavigationController *reviewViewController;

//  小能客服
@property (nonatomic ,strong) NSDictionary         * NTalkerNotificationInfo;
@property (nonatomic ,strong) NSMutableDictionary  *unreadMsgDict;//未读消息容器 演示用
@property (nonatomic ,strong) XNPushTipView        *topView;//自定义推送提示
@property (nonatomic ,assign) BOOL                 isChatView;  //*后台进入前台的时候是否为聊天界面key*//

@end



@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //  配置网络请求基础参数
    [[NSUserDefaults standardUserDefaults] setValue:@(YES) forKey:kAppReviewStateNotification];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self configNetworkBaseParam];
    
    self.window = [[UIWindow alloc] init];
    self.window.frame = [UIScreen mainScreen].bounds;

    //  配置极光推送
    [self addJpushConfigueWithOptions:launchOptions];
    //  初始化同盾
    [self initializeTonDuan];
    //  配置rootViewController
    [self configRootViewController];
    
    [self.window makeKeyAndVisible];
    //  设置导航栏样式
    [self setUpNavigationBarAppearance];
    //  配置避免奔溃
    [self configAvoidCrash];
    //设置高德地图key
    [AMapServices sharedServices].apiKey = kGaoDeMapKey;
    
    [[IQKeyboardManager sharedManager] setEnable:YES];
    //  点击空白页取消键盘
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    //  禁用指定页面
    [[IQKeyboardManager sharedManager].disabledDistanceHandlingClasses addObject:NSClassFromString(@"NTalkerChatViewController")];
    
    //  添加数据库
    [FMDBHelper setDataBaseName:@"letupush.db"];
    
    //  添加友盟
    [self umsocialManager];
    
    //  小能客服
    [[NTalker standardIntegration] initSDKWithSiteid:kXNSiteId andSDKKey:kXNSDKKey];
    [[NTalker standardIntegration] setUserIconImage:[UIImage imageNamed:@"XN_customer_service"]];
    [[NTalker standardIntegration] setHeadIconCircle:YES];
    
    self.unreadMsgDict = [[NSMutableDictionary alloc] init];

    /** 点击推送通知代码1（APP 未启动状态 系统弹出默认推送通知提示框）*/
    NSDictionary* remoteNotificatInfo = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    //小能
    if (remoteNotificatInfo) {
        self.NTalkerNotificationInfo = remoteNotificatInfo;
        //接待组ID
        NSString *settingId = [remoteNotificatInfo objectForKey:@"settingid"];
        if (settingId) {
            //打开聊窗
            [self openChatByXpush:settingId];
        }
    }
    //初始化自定义推送提示框，供后面使用（可选）
    [self addXPushTipView];
    //配置引导页
    [ThirdSDKConfig configSDK];

    return YES;
}




#pragma mark - 小能客服 开始
/**
 *  点击xpush消息，打开聊窗
 *  settingId:接待组ID
 */
-(void)openChatByXpush:(NSString *)settingId{
    
    if (settingId.length) {
        //获取最后一次用户信息
        NSDictionary *userDic = [[NSUserDefaults standardUserDefaults] objectForKey:XN_LastUserInfo_ForXPush];
        [[NTalker standardIntegration] loginWithUserid:userDic[@"uid"] andUsername:userDic[@"uname"] andUserLevel:[NSString stringWithFormat:@"%@",userDic[@"ulevel"]]];
        NTalkerChatViewController *ctrl = [[NTalker standardIntegration] startChatWithSettingId:settingId];
        ctrl.pushOrPresent = NO;
        ctrl.isHaveVoice = NO;
        if (ctrl.pushOrPresent == YES) {
        } else {
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:ctrl];
            ctrl.pushOrPresent = NO;
            [self.window.rootViewController presentViewController:nav animated:YES completion:nil];
        }
    }
}


//添加自定义推送提示View
-(void)addXPushTipView{
    XNPushTipView*topView = [XNPushTipView shareInstance];
    topView.frame = CGRectMake(leftMargin, -pushViewHeight,pushViewWidth, pushViewHeight);
    [_window addSubview:topView];
    self.topView = topView;
    topView.hidden = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hudClick)];
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [topView addGestureRecognizer:tap];
    [tap requireGestureRecognizerToFail:pan];
    topView.gestureRecognizers = @[tap,pan];
}

#pragma mark  addPushView相关事件


- (void)hudClickOperation
{
    //  [self push:nil];
    [self openChatByXpush:self.unreadMsgDict[@"settingId"]];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.topView.userInteractionEnabled = YES;
    });
}


- (void)pan:(UIPanGestureRecognizer*)pan
{
    CGFloat distance = pushViewHeight-(pushViewHeight-[pan translationInView:self.window].y);
    if (distance<-20) {
        [UIView animateWithDuration:0.25 animations:^{
            self.topView.frame = CGRectMake(leftMargin, -pushViewHeight, pushViewWidth, pushViewHeight);
        }completion:^(BOOL finished) {
            [UIApplication sharedApplication].statusBarHidden = NO;
        }];
    }
}
- (void)hudClick
{
    self.topView.userInteractionEnabled = NO;
    
    [UIView animateWithDuration:0.25 animations:^{
        self.topView.frame = CGRectMake(leftMargin, -pushViewHeight, pushViewWidth, pushViewHeight);
    }completion:^(BOOL finished) {
        [UIApplication sharedApplication].statusBarHidden = NO;
        [self hudClickOperation];
        
    }];
}
//显示pushView
- (void)displayPushView
{
    [XNPushTipView show];
}

#pragma mark - 小能客服结束

-(void)umsocialManager{
    // 友盟统计
    [UMConfigure initWithAppkey:kUmengKey channel:kUMengChannelId];
    [MobClick setScenarioType:E_UM_NORMAL];
    
}


//  同盾初始化
- (void)initializeTonDuan
{
    FMDeviceManager_t *AAAmanager= [FMDeviceManager sharedManager];
    NSMutableDictionary *options = [NSMutableDictionary dictionary];
    // 指定线上环境的url  其值设置为@"product"即可切换为生产环境
    NSString * isProduction = @"sandbox";
    [options setValue:@"lqms" forKey:@"partner"];
#if DEBUG // 判断是否在测试环境下
    // 上线Appstore的版本，请记得删除此行，否则将失去防调试防护功能！
    [options setValue:@"allowd" forKey:@"allowd"];
#else
    isProduction = @"product";
#endif
    [options setValue:isProduction forKey:@"env"]; // TODO
    AAAmanager->initWithOptions(options);
}


////  同盾初始化
//- (void)initializeTonDuan{
//
//    FMDeviceManager_t *AAAmanager= [FMDeviceManager sharedManager];
//    NSMutableDictionary *options = [NSMutableDictionary dictionary];
//    [options setValue:@"letunet" forKey:@"partner"];
//    [options setValue:@"allowd" forKey:@"allowd"];
//    AAAmanager->initWithOptions(options);
//}


//  配置请求基础参数
- (void)configNetworkBaseParam
{
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    YTKNetworkConfig *config = [YTKNetworkConfig sharedConfig];
    config.baseUrl = BaseUrl;
    
    //  配置证书
//    NSString *certFilePath = [[NSBundle mainBundle] pathForResource:CertificateName ofType:@"cer"];
//    NSData *certData = [NSData dataWithContentsOfFile:certFilePath];
//    NSSet *certSet = [NSSet setWithObject:certData];
//    AFSecurityPolicy *policy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate withPinnedCertificates:certSet];
//    policy.allowInvalidCertificates = YES;
//    policy.validatesDomainName = NO;
//    [config setSecurityPolicy:policy];
}
//  设置主页面
- (void)configRootViewController
{
    TabBarControllerConfig *tabBarControllerConfig = [[TabBarControllerConfig alloc] init];
    self.tabBarController = tabBarControllerConfig.tabBarController;
    self.window.rootViewController = self.tabBarController;
}

//  设置navigationBar样式
- (void)setUpNavigationBarAppearance
{

}


#pragma mark - delegate
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    [[self cyl_tabBarController] updateSelectionStatusIfNeededForTabBarController:tabBarController shouldSelectViewController:viewController];
    return YES;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectControl:(UIControl *)control {
}



#pragma mark - 极光推送配置
//  极光推送配置
- (void)addJpushConfigueWithOptions:(NSDictionary *)launchOptions{
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        // 可以添加自定义categories
        // NSSet<UNNotificationCategory *> *categories for iOS10 or later
        // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
    }
    BOOL isProduction = NO;
    #if DEBUG // 判断是否在测试环境下
    // TODO
    #else
    isProduction = true;
    #endif
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    [JPUSHService setupWithOption:launchOptions appKey:kJPushAppKey
                          channel:kJPushChannel
                 apsForProduction:isProduction
            advertisingIdentifier:nil];
    //    NSLog(@"%@", Iphone_Uuid);
//    自定义消息
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter addObserver:self selector:@selector(networkDidReceiveMessage:) name:kJPFNetworkDidReceiveMessageNotification object:nil];
}
#pragma mark -- 极光推送  自定义消息
- (void)networkDidReceiveMessage:(NSNotification *)notification
{
    [ZTMXFPushHelper networkDidReceiveMessage:notification];
}

- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    [application registerForRemoteNotifications];
}

- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    //    极光推送
    [JPUSHService registerDeviceToken:deviceToken];
    [LoginManager addPushAlias];
    if (isAppOnline == 1 || isAppOnline == 2) {
        [[NTalker standardIntegration] developEnviroment:YES];
    } else {
        [[NTalker standardIntegration] developEnviroment:NO];
    }
    [[NTalker standardIntegration] regiestPushService:deviceToken];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //Optional
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}


#pragma mark- JPUSHRegisterDelegate

// iOS 10 Support 前台收到通知栏推送
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    // Required
    
    if (![USER_DEFAULT boolForKey:k_VoiceSwitch]) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"mqPush" ofType:@"caf"];
        //组装并播放音效
        SystemSoundID soundID;
        NSURL *filePath = [NSURL fileURLWithPath:path isDirectory:NO];
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)filePath, &soundID);
        AudioServicesPlaySystemSound(soundID);
        
    }else{
        AudioServicesPlaySystemSound(1007);

    }
    
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler(UNNotificationPresentationOptionAlert);
    // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
    //    NSLog(@"userInfo4=%@" ,userInfo);
     [self handlePushMessage:userInfo click:NO];
}

// iOS 10 Support 点击通知栏消息
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler();  // 系统要求执行这个方法
    [ZTMXFPushHelper pushDetailsPageWithUserInfo:userInfo];
    
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    // Required, iOS 7 Support
    
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
    [self handlePushMessage:userInfo click:YES];
    //  处理小能推送
    [self handleXNtalkerPushMessageWithApplication:application userInfo:userInfo];

}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [JPUSHService handleRemoteNotification:userInfo];
    [self handlePushMessage:userInfo click:YES];
    //  处理小能推送
    [self handleXNtalkerPushMessageWithApplication:application userInfo:userInfo];
}

//  处理小能推送的内容
- (void)handleXNtalkerPushMessageWithApplication:(UIApplication *)application userInfo:(NSDictionary *)userInfo{
    //  小能操作
    [application cancelAllLocalNotifications];
    application.applicationIconBadgeNumber = 0;
    ////在此处理接收到的消息（添加自己的处理代码）.
    /**
     *  点击推送通知示例代码2（APP在前台、后台运行）
     */
    if (userInfo) {
        self.NTalkerNotificationInfo = userInfo;
    }
    //    NSLog(@"Receive remote notification : %@",userInfo);
    //demo示例代码
    //获取接待组ID
    NSString *settingId = [userInfo objectForKey:@"settingid"];
    NSString *contentString = [userInfo objectForKey:@"aps"][@"alert"];
    //*检查当前界面是否为聊窗界面key*//
    BOOL ifchatViewAccure = NO;
    if (_isChatView) {
        NTalkerChatViewController * currentViewController = (NTalkerChatViewController*)[self getCurrentViewController];
        currentViewController.isHaveVoice = NO;

        //当前聊天界面与通知是否为同一个接待组聊天界面
        ifchatViewAccure = [self checkCurrentView:currentViewController WithPushSettingid:settingId];
    }
    
    //APP 处于前台（系统默认不会弹出推送提醒，因此我们自定义了一个消息提示框）
    if (application.applicationState == UIApplicationStateActive &&settingId) {
        UIViewController * currentViewController = [UIViewController currentViewController];
        //当前界面非聊天界面（将xpush信息作为本地未读消息处理，加入未读消息通知）
        if (![currentViewController isKindOfClass:[NTalkerChatViewController class]]) {
            
            //将XPush通道消息纳入未读消息通知阵列
            NSDictionary * dict = @{@"settingId":settingId?:@"",@"content":contentString?:@"",@"userName":@""};
            [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFINAME_XN_UNREADMESSAGE object:dict];
            
            self.unreadMsgDict = (NSMutableDictionary*)dict;
            
            //调用震动、音效
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
            AudioServicesPlaySystemSound(1007);
        } else{
            //当前处于聊天界面（暂不做处理）
        }
        //APP处于后台（系统默认会弹出推送提醒，添加点击通知打开聊窗功能）
    } else if (application.applicationState == UIApplicationStateInactive&&settingId) {
        //*当前页面不是聊窗才会调用重新打开聊窗key*//
        if (ifchatViewAccure == NO) {
            [self openChatByXpush:settingId];
        }
        
    }else if (application.applicationState == UIApplicationStateBackground && settingId) {
        NSDictionary * dict = @{@"settingId":settingId?:@"",@"content":contentString?:@"",@"userName":@""};
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFINAME_XN_UNREADMESSAGE object:dict];
    }

}

/*检查点击通知后后台恢复前台的页面是否为聊天页面
 settingid :通知传进的settingid
 return:YES：是两天页面  NO 不是聊天页面
 */
-(BOOL)checkCurrentView:(NTalkerChatViewController *)curentChat WithPushSettingid:(NSString*)settingid{
    if ([curentChat.settingid isEqualToString:settingid]) {
        return YES;
    }else{
        return  NO;
    }
}

//  根据收到的推送做相应的处理
- (void)handlePushMessage:(NSDictionary *)userInfo click:(BOOL)isClick
{
    [ZTMXFPushHelper handlePushMessage:userInfo click:isClick];
}
/**
 *  推送处理本地数据以及通知页面刷新页面
 *
 */
-(void)newsUpadateNotificationModel:(LSNotificationModel *)model{
    
    [LSNotificationModel notification_insertArray:@[model]];
//    消息中心刷新页面
    [[NSNotificationCenter defaultCenter] postNotificationName:newsUpadateNotificationResult object:nil];
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    [application setApplicationIconBadgeNumber:0];
    [application cancelAllLocalNotifications];
    //获取当前界面
    UIViewController * currentViewController = [self getCurrentViewController];
    //当前界面非聊天界面
    if ([currentViewController isKindOfClass:[NTalkerChatViewController class]]) {
        self.isChatView = YES;
    }else{
        self.isChatView = NO;
    }
}

//*获取当前控制器key*//
- (UIViewController *)getCurrentViewController
{
    UIWindow *keyWindow  = [UIApplication sharedApplication].keyWindow;
    UIViewController *vc = keyWindow.rootViewController;
    while (vc.presentedViewController)
    {
        vc = vc.presentedViewController;
        
        if ([vc isKindOfClass:[UINavigationController class]])
        {
            vc = [(UINavigationController *)vc visibleViewController];
        }
        else if ([vc isKindOfClass:[UITabBarController class]])
        {
            vc = [(UITabBarController *)vc selectedViewController];
        }
    }
    //当前界面非聊天界面
    if ([vc isKindOfClass:[UINavigationController class]] == YES) {
        UINavigationController *nav = (UINavigationController *)vc;
        if (nav.viewControllers.count>0) {
            vc = [nav.viewControllers objectAtIndex:nav.viewControllers.count-1];
        }
    }
    return vc;
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
//    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

//  配置避免配置避免Crash
- (void)configAvoidCrash{
    [AvoidCrash makeAllEffective];
    //监听通知:AvoidCrashNotification, 获取AvoidCrash捕获的崩溃日志的详细信息
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dealwithCrashMessage:) name:AvoidCrashNotification object:nil];
}

#pragma mark - 通知监听事件
- (void)dealwithCrashMessage:(NSNotification *)note{
    NSLog(@"---%@", note.userInfo);
}

#pragma mark -- url  回调

// iOS>9
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options {
    
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
    BOOL result = [[UMSocialManager defaultManager]  handleOpenURL:url options:options];
    if (!result) {
//        if (![YPCashierPay handleOpenURL:url withCompletion:nil]) {
//            // 其他如支付等SDK的回调
//            return YES;
//        }
    }
    return YES;

}
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
//        if (![YPCashierPay handleOpenURL:url withCompletion:nil]) {
//            // 其他如支付等SDK的回调
//
//            return YES;
//        }
    }
    return NO;
}


// iOS 低于 9
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
    if (!result) {
        //        易宝付
//        if (![YPCashierPay handleOpenURL:url withCompletion:nil]) {
//            return YES;
//        }
    }
    return YES;
}


@end

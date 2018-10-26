//
//  LoginManager.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/9/21.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "LoginManager.h"
#import "LoginApi.h"
#import "ShanDaoLoginViewController.h"
#import "NTalker.h"

#import "NSString+version.h"
#import "UIViewController+Visible.h"
#import "TabBarControllerConfig.h"

//版本1.2
#import "ShanDaoVerificationCodeLoginController.h"
@implementation LoginManager

+ (BOOL)loginState{
    NSString *accessToken = [[NSUserDefaults standardUserDefaults] valueForKey:kUserAccessToken];
    if (accessToken.length > 0) {
        return YES;
    } else {
        return NO;
    }
}

//  保存用户手机号
+ (void)saveUserPhone:(NSString *)userPhone{
    if (userPhone.length > 0) {
        [[NSUserDefaults standardUserDefaults] setValue:userPhone forKey:kUserPhoneNumber];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}
//  保存用户id
+ (void)saveUserID:(NSString *)userID{
    if (userID.length > 0) {
        [[NSUserDefaults standardUserDefaults] setValue:userID forKey:kUserID];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}
//  保存用户Token
+ (void)saveUserAccessToken:(NSString *)token{
    if (token.length > 0) {
        [[NSUserDefaults standardUserDefaults] setValue:token forKey:kUserAccessToken];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}
//  保存用户手机号和Token
+ (void)saveUserPhone:(NSString *)userPhone userPasw:(NSString *)userPasw userToken:(NSString *)token{
//    记录登录 账号
    [LoginManager saveLoginMobile:userPhone];
    
    if (token.length > 0) {
        [[NSUserDefaults standardUserDefaults] setValue:token forKey:kUserAccessToken];
    }
    if (userPhone.length > 0) {
        [[NSUserDefaults standardUserDefaults] setValue:userPhone forKey:kUserPhoneNumber];
    }
    if (userPasw.length>0) {
        [[NSUserDefaults standardUserDefaults]setValue:userPasw forKey:kUserPassword];
    }
//   保存 版本号
    long newVersion =  [NSString appVersionLongValue];
    [[NSUserDefaults standardUserDefaults] setFloat:newVersion forKey:KAppVersionOld];
    
    if (userPhone.length > 0 || token.length > 0) {
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    //  友盟统计
    //  添加极光推送别名注册
    [LoginManager addPushAlias];
    //  登陆小能客服账号
    [[NTalker standardIntegration] loginWithUserid:userPhone andUsername:userPhone andUserLevel:0];
    
    //    重新生成 weexSign
    [LoginManager saveWeexSign];

}

//  清除用户信息
+ (void)clearUserInfo{

    //  极光推送清除别名
    [JPUSHService deleteAlias:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
    } seq:kJPushSequence];
    
    [[NSUserDefaults standardUserDefaults] setValue:nil forKey:kUserAccessToken];
    [[NSUserDefaults standardUserDefaults] setValue:nil forKey:kUserPhoneNumber];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kUserPassword];
    [[NSUserDefaults standardUserDefaults] synchronize];
    //    友盟统计 清除
    [ZTMXFUMengHelper UMFileSignOff];
    //  小能客服系统登出
    [[NTalker standardIntegration] logout];
    
    //    重新生成 weexSign
    [LoginManager saveWeexSign];

}

//  获取用户手机号
+ (NSString *)userPhone{
    NSString *phoneNumber = [[NSUserDefaults standardUserDefaults] valueForKey:kUserPhoneNumber];
    return phoneNumber;
}
// 获取用户的userid
+ (NSString *)userID{
    NSString *userIDStr = [[NSUserDefaults standardUserDefaults] valueForKey:kUserID];
    return userIDStr;
}
/**
 更新版本信息
 */
+(void)updateVersion
{
//    CGFloat oldV = [[NSUserDefaults standardUserDefaults]floatForKey:KAppVersionOld];
//    CGFloat new = [NSString appVersionLongValue];
//    if (oldV<new&&[LoginManager loginState]&&oldV>0) {
////        新版本需要更新
////        静默登录 删除久的token
//        [[NSUserDefaults standardUserDefaults] setValue:nil forKey:kUserAccessToken];
//        [[NSUserDefaults standardUserDefaults] synchronize];
////        重新登录
//        NSString * passowrd = [[NSUserDefaults standardUserDefaults] objectForKey:kUserPassword];
//        LoginApi *loginApi = [[LoginApi alloc] initWithLoginType:@"L" password:passowrd securityCode:nil];
//        loginApi.isHideToast = YES;
//        [loginApi requestWithSuccess:^(NSDictionary *responseDict) {
//            NSString *codeStr = [responseDict[@"code"] description];
//            NSString * msgStr = [responseDict[@"msg"]description];
//            NSLog(@"----------- %@",msgStr);
//            if ([codeStr isEqualToString:@"1000"]) {
//                //  登录成功
//                NSString *needVerify = [responseDict[@"data"][@"needVerify"] description];
//
//                if ([needVerify isEqualToString:@"Y"]) {
//                    //  登录成功
//                    NSString *token = [responseDict[@"data"][@"token"] description];
//                    NSString * userPhone = [LoginManager userPhone];
//                    [LoginManager saveUserPhone:userPhone userPasw:passowrd userToken:token];
//                }
//            }
//        } failure:^(__kindof YTKBaseRequest *request) {
//
//        }];
//
//    }
}

//  极光推送添加推送别名
+ (void)addPushAlias{
    NSString *userName = [LoginManager userPhone];
    if (userName) {
        [JPUSHService setAlias:userName completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
        } seq:kJPushSequence];
    }
}

//  弹出登录页面
+ (void)presentLoginVCWithController:(UIViewController *)controller{
    if ([controller isKindOfClass:[UIViewController class]]) {
        UIViewController * rootVc = [UIViewController currentViewController];
        UIViewController * firstVc = rootVc.navigationController.viewControllers.firstObject;
        BOOL isStop = [firstVc isMemberOfClass:NSClassFromString(@"ShanDaoVerificationCodeLoginController")];
        if (!isStop) {
            ShanDaoVerificationCodeLoginController *loginVC = [[ShanDaoVerificationCodeLoginController alloc] initWithType:XL_LOGINVC_VERIFICATION_CODE];
            UINavigationController *loginNav = [[CYLBaseNavigationController alloc] initWithRootViewController:loginVC];
            [controller presentViewController:loginNav animated:YES completion:nil];
        }
    }
}

//  保存用户骨头状态
+ (void)saveAppReviewState:(BOOL)state{
    if (state) {
        [[NSUserDefaults standardUserDefaults] setValue:@(YES) forKey:kAppReviewStateNotification];
    } else {
        [[NSUserDefaults standardUserDefaults] setValue:@(NO) forKey:kAppReviewStateNotification];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
}

//  获取用户骨头状态
+ (BOOL)appReviewState{
//    return YES;
    NSNumber *reviewState = [[NSUserDefaults standardUserDefaults] objectForKey:kAppReviewStateNotification];
    if ([reviewState boolValue]) {
        return YES;
    } else {
        return NO;
    }
}

/**
 保存登录过得账号
  @param mobile 登录账号
 */
+(void)saveLoginMobile:(NSString*)mobile{
    NSArray * arrOld = [[NSUserDefaults standardUserDefaults] valueForKey:LSOldMobileKey];
    NSMutableArray * arrOldMobile = [NSMutableArray arrayWithArray:arrOld];
    [arrOldMobile removeObject:mobile];
    [arrOldMobile insertObject:mobile atIndex:0];
    if ([arrOldMobile count]>3)
    {
        NSArray * arrOld = [arrOldMobile subarrayWithRange:NSMakeRange(0, 3)];
        arrOldMobile = [NSMutableArray arrayWithArray:arrOld];
    }
    if ([arrOldMobile count])
    {
        [[NSUserDefaults standardUserDefaults]setValue:arrOldMobile forKey:LSOldMobileKey];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
}

/**
 获得 登录过得账号

 @return 登录过得账号
 */
+(NSArray*)gainOldLoginMobileArr{
    return [[NSUserDefaults standardUserDefaults] valueForKey:LSOldMobileKey];
}

//生成 weexSign
+(void)saveWeexSign{
    UInt64 time = [[NSDate date] timeIntervalSince1970] * 1000;
    NSString *timeString =[NSString stringWithFormat:@"%llu",time];
    NSString * tokenUser = [[[NSUserDefaults standardUserDefaults] objectForKey:kUserAccessToken]sha256];
    if (tokenUser.length>0) {
        tokenUser = [NSString stringWithFormat:@"app%@",tokenUser];
    }else{
        tokenUser = @"";
    }
    NSString * weexSign = [NSString stringWithFormat:@"%@%@",timeString,tokenUser];
    [[NSUserDefaults standardUserDefaults]setValue:weexSign forKey:@"weexSign"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
//获得 WeexSign
+(NSString*)gainWeexSign{
    return [[NSUserDefaults standardUserDefaults]objectForKey:@"weexSign"];
}
@end

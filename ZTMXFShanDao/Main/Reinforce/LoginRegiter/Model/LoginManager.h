//
//  LoginManager.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/9/21.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginManager : NSObject

//  是否登录
+ (BOOL)loginState;

//  保存用户手机号
+ (void)saveUserPhone:(NSString *)userPhone;
//保存用户id
+ (void)saveUserID:(NSString *)userID;

//  保存用户Token
+ (void)saveUserAccessToken:(NSString *)token;

//  保存用户手机号和Token
+ (void)saveUserPhone:(NSString *)userPhone userPasw:(NSString *)userPasw userToken:(NSString *)token;

//  清除用户信息
+ (void)clearUserInfo;

//  获取用户手机号
+ (NSString *)userPhone;
// 获取用户的userid
+ (NSString *)userID;

/**
 更新版本信息
 */
+(void)updateVersion;

//  极光推送添加推送别名
+ (void)addPushAlias;


//  弹出登录页面
+ (void)presentLoginVCWithController:(UIViewController *)controller;


//  保存骨头状态
+ (void)saveAppReviewState:(BOOL)state;
//  获取当前骨头状态
+ (BOOL)appReviewState;

/**
 保存登录过得账号

 @param mobile 登录账号
 */
+(void)saveLoginMobile:(NSString*)mobile;
/**
 获得 登录过得账号
 
 @return 登录过得账号
 */
+(NSArray*)gainOldLoginMobileArr;

//生成 weexSign
+(void)saveWeexSign;
//获得 WeexSign
+(NSString*)gainWeexSign;
@end

//
//  BaseRequestSerivce.m
//  CoreFrame
//
//  Created by yangpenghua on 2017/8/28.
//  Copyright © 2017年 yangpenghua. All rights reserved.
//

#import "BaseRequestSerivce.h"
#import "UIDevice+FCUUID.h"
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CommonCrypto/CommonDigest.h>
#import "NSDictionary+Additions.h"
#import "ZTMXFPhoneModel.h"
#import "NSString+verify.h"
#import "NSString+Trims.h"
@implementation BaseRequestSerivce

- (YTKRequestMethod)requestMethod{
    return YTKRequestMethodPOST;
}

//  设置json数据格式请求
- (YTKRequestSerializerType)requestSerializerType{
    return YTKRequestSerializerTypeJSON;
}

//  设置请求header
- (NSDictionary<NSString *,NSString *> *)requestHeaderFieldValueDictionary{
    return [BaseRequestSerivce baseDictionaryWithBaseParameters:[self requestArgument] method:[self requestUrl]];
}

//  设置基础参数
+ (NSDictionary *)baseDictionaryWithBaseParameters:(NSDictionary *)dic method:(NSString *)method{
    dic = [dic removeForeAndAftWhitespace];
    NSString *idfv = [UIDevice currentDevice].uuid;
    UInt64 time = [[NSDate date] timeIntervalSince1970] * 1000;
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSString *appVersion = [version stringByReplacingOccurrencesOfString:@"." withString:@""];
    NSString *userPhone = [[NSUserDefaults standardUserDefaults] objectForKey:kUserPhoneNumber];
    
    //用来区分渠道
    NSString *bundleName = [[[NSBundle mainBundle]infoDictionary]objectForKey:@"CFBundleIdentifier"];
    bundleName = [bundleName componentsSeparatedByString:@"."].lastObject;
    
    NSString *userName = [userPhone length] > 0 ? userPhone : idfv;
    NSString *timeString = [NSString stringWithFormat:@"%llu",time] ;
    NSString *onlyId = [NSString stringWithFormat:@"i_%@_%llu_%@",idfv,time,bundleName];
    NSString *netType = [NSString getNetWorkType];
    
    NSString *tokenUser = [[NSUserDefaults standardUserDefaults] objectForKey:kUserAccessToken];
    BOOL isLogin = [tokenUser length] ? YES : NO;
    
    NSMutableString *sign = [[NSMutableString alloc] initWithFormat:@"netType=%@&userName=%@&time=%@&appVersion=%@", netType, userName, timeString, appVersion];
    
    if ([BaseRequestSerivce addTokenCheckMethod:method] && isLogin) {
        [sign appendString:tokenUser];
    }
    
    if ([BaseRequestSerivce addSinaParameterMethod:method]) {
        NSArray *keyTemArray = [dic allKeys];
        NSArray *keyArray = [keyTemArray sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            return [obj1 compare:obj2 options:NSLiteralSearch];
        }];
//        NSLog(@"dic=%@",dic);
        
        for (int i = 0; i < keyArray.count; i++) {
            id vluale = [dic objectForKey:keyArray[i]];
            
            NSString *vlualeS =[NSString stringWithFormat:@"%@",vluale];
            if ([vluale isKindOfClass:[NSDictionary class]]) {
                vlualeS = [BaseRequestSerivce jsonString:vluale];
            } else if ([vluale isKindOfClass:[NSArray class]]) {
                NSArray *array = vluale;
                vlualeS = [BaseRequestSerivce jsonArrayFromArray:array];
            }
            if (i < keyArray.count) {
                [sign appendString:@"&"];
            }
            [sign appendString:keyArray[i]];
            [sign appendString:@"="];
            [sign appendString:vlualeS];
        }
    }
    NSString *sha256 = [BaseRequestSerivce sha256:sign];

    NSMutableDictionary *headDict =[[NSMutableDictionary alloc] initWithObjectsAndKeys:appVersion,@"appVersion",userName,@"userName",timeString,@"time",  onlyId,@"id",netType,@"netType",sha256, @"sign",kChannelId,@"channel", nil];
    
//    NSString * deviceType = [[NSString platformName] trimmingWhitespace]?[[NSString platformName] trimmingWhitespace]:@"未知";
//    [headDict setObject:deviceType forKey:@"deviceType"];

    return headDict;
}

// 哈希256
+ (NSString*)sha256:(NSString *)string
{
    NSData *data =[string dataUsingEncoding:NSUTF8StringEncoding];
    uint8_t digest[CC_SHA256_DIGEST_LENGTH];
    int lengthData = (int)data.length ;
    CC_SHA256(data.bytes, lengthData, digest);
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA256_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_SHA256_DIGEST_LENGTH; i++)
    {
        [output appendFormat:@"%02x", digest[i]];
    }
    return output;
}
//  这个借口是否添加签名
+ (BOOL)addTokenCheckMethod:(NSString *)method
{
    NSArray *notArray = [[NSArray alloc] initWithObjects:@"/user/getVerifyCode",@"/user/register",@"/user/checkVerifyCode",@"/user/resetPwd",@"/system/appUpgrade",@"/auth/getQuotaPageInfo",@"/auth/getCreditPromoteInfo",@"/borrowCash/getBorrowHomePage",@"/system/appLaunchImage",@"/hidden/getBrandList", @"/system/getServeAndFinanc", @"/mall/getGoodsDetail", @"/mall/getGoodsSkuPrice", @"/mall/getConfirmOrderInfo", @"/mall/getGoodsPartition", @"/mall/getMallHomePage",@"/user/getImgCode",@"/mall/getMobileRechargeList",@"/user/login",@"/auth/getCreditQuotaInfoWithoutLogin",@"/mall/getConsumdebtGoodsDetail", nil];
    return [notArray containsObject:method] ? NO:YES;
}
// 不需要加参数 签名
+(BOOL)addSinaParameterMethod:(NSString*)method{
    NSArray * notArr = @[@"/file/uploadFace.htm",@"/file/uploadIdNumberCard.htm",@"/file/uploadFaceForFacePlus.htm",@"/file/uploadIdNumberCardForFacePlus.htm"];
    return [notArr containsObject:method] ? NO : YES;
}
#pragma mark - 字典 转 JSON字符串
+ (NSString *)jsonString:(NSDictionary *)dict
{
    NSData *infoJsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
    NSString *json = [[NSString alloc] initWithData:infoJsonData encoding:NSUTF8StringEncoding];
    return json;
}

+ (NSString *)jsonArrayFromArray:(NSArray *)array{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:array options:NSJSONWritingPrettyPrinted error:&error];
    NSString *json = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSString *jsonString = [[json stringByReplacingOccurrencesOfString:@" " withString:@""] stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    NSLog(@"%@",jsonString);
    return jsonString;
}

//  发起网络请求
- (void)requestWithSuccess:(successBlock)success failure:(failureBlock)failure{
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    });

    [self startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        });
        NSDictionary *responseDict = request.responseJSONObject;
        NSDictionary *dataDict = responseDict[@"result"];
        if (![dataDict isKindOfClass:[NSDictionary class]]) {
            dataDict = nil;
        }
        //lis网络请求
        
//        if (DEBUG && isAppOnline == 0) {
//            //NSLog(@"responseKeyValues: %@",request.response.keyValues);
////            NSLog(@"URL: %@\nParameters: %@\nArgument: %@\nResponseDict: %@",request.response.URL,[BaseRequestSerivce baseDictionaryWithBaseParameters:[self requestArgument] method:@"POST"],[self requestArgument], responseDict);
//
//        }
        NSString *codeStr = [dataDict[@"code"] description];
        
        if ([codeStr isEqualToString:@"1005"]) {
            //  登录失效, 需要重新登录 1005
            [[NSNotificationCenter defaultCenter] postNotificationName:NotTokenInvalidNotification object:nil];
            //  退出登陆
            [[NSNotificationCenter defaultCenter] postNotificationName:kLogoutSuccess object:nil];
            [LoginManager clearUserInfo];
        } else if ([codeStr isEqualToString:@"1100"]) {
            // 1100 用户未登录
            [LoginManager clearUserInfo]; // 清除用户信息
            
        } else if ([codeStr isEqualToString:@"8888"]){
//            直接弹出登录页面  token失效
            [[NSNotificationCenter defaultCenter] postNotificationName:NotTokenInvalidLoginPushNotification object:nil];
//            退出登陆  我的页面UI更新
            [[NSNotificationCenter defaultCenter] postNotificationName:kLogoutSuccess object:nil];
//            清空用户信息
            [LoginManager clearUserInfo];

        }else if ([codeStr isEqualToString:@"6005"] ||[codeStr isEqualToString:@"6001"] || [codeStr isEqualToString:@"6002"] || [codeStr isEqualToString:@"6003"] || [codeStr isEqualToString:@"6004"] || [codeStr isEqualToString:@"5001"] || [codeStr isEqualToString:@"1307"] || [codeStr isEqualToString:@"4040"] || [codeStr isEqualToString:@"7001"] || [codeStr isEqualToString:@"7002 "] || [codeStr isEqualToString:@"1310"]) {
            
        } else if(![codeStr isEqualToString:@"1000"]) {
            //  如果没有成功弹出toast提示
            NSString *messageStr = [dataDict[@"msg"] description];
            if (!_isHideToast) {
                [kKeyWindow makeCenterToast:messageStr];
            }
        }
        success(dataDict);

    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        if (!_isHideToast) {
            [kKeyWindow makeCenterToast:kNetworkConnectFailure];
        }
//        //lis网络请求
//        if (DEBUG && isAppOnline == 0) {
//            
//            //NSLog(@"responseKeyValues: %@",request.response.keyValues);
////            NSLog(@"URL: %@\nArgument: %@\nError: %@",request.response.URL,[self requestArgument],request.error);
//        }
        failure(request);
        dispatch_async(dispatch_get_main_queue(), ^{
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        });
    }];
}















@end

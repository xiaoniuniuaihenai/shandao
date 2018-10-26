//
//  Http.m
//  种草没
//
//  Created by 陈传亮 on 16/5/25.
//  Copyright © 2016年 古乐. All rights reserved.
//

#import "HttpTool.h"
#import "HttpClient.h"
#import <AFNetworking/AFNetworking.h>
#import <YYCache.h>
#import "NSJSONSerialization+LYJSON.h"

@interface HttpTool ()

@property (nonatomic) RequestCachePolicy policy;

@end

@implementation HttpTool

+ (void)netWorkStatus
{
    /**
     AFNetworkReachabilityStatusUnknown          = -1,   未知
     AFNetworkReachabilityStatusNotReachable     = 0,    无连接
     AFNetworkReachabilityStatusReachableViaWWAN = 1,    3G
     AFNetworkReachabilityStatusReachableViaWiFi = 2,    WiFi
     */
    // 如果要检测网络状态的变化,必须用检测管理器的单例的startMonitoring
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    // 检测网络连接的单例,网络变化时的回调方法
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case -1:
                NSLog(@"当前网络状况:未知");
                break;
            case 0:
                NSLog(@"当前网络状况:无连接");
                break;
            case 1:
                NSLog(@"当前网络状况:移动网络");
                break;
            case 2:
                NSLog(@"当前网络状况:WiFi");
                break;
            default:
                break;
        }
    }];
}

#pragma mark - GET (不显示请求进度)

// (不显示请求进度)
+ (void)getJSONWithUrl:(NSString *)urlStr
            parameters:(id)parameters
           cachePolicy:(RequestCachePolicy)cachePolicy
               success:(void (^)(id responseObject))success
               failure:(void (^)(NSString *errorInfo))failure
{
    [self requestMethod:RequestType_GET urlString:urlStr parameters:parameters cachePolicy:cachePolicy manager:nil progress:nil success:success failure:failure];
}



// (显示请求进度)
+ (void)getJSONWithUrl:(NSString *)urlStr
            parameters:(id)parameters
           cachePolicy:(RequestCachePolicy)cachePolicy
              progress:(void (^)(float downloadProgress))progress
               success:(void (^)(id responseObject))success
               failure:(void (^)(NSString *errorInfo))failure
{
    [self requestMethod:RequestType_GET urlString:urlStr parameters:parameters cachePolicy:cachePolicy manager:nil progress:progress success:success failure:failure];
}
+ (void)getJSONWithUrl:(NSString *)urlStr
            parameters:(id)parameters
               manager:(AFHTTPSessionManager *)manager
           cachePolicy:(RequestCachePolicy)cachePolicy
               success:(void (^)(id responseObject))success
               failure:(void (^)(NSString *errorInfo))failure
{
    [self requestMethod:RequestType_GET urlString:urlStr parameters:parameters cachePolicy:cachePolicy manager:manager progress:nil success:success failure:failure];
}
+ (void)getJSONWithUrl:(NSString *)urlStr
            parameters:(id)parameters
               manager:(AFHTTPSessionManager *)manager
           cachePolicy:(RequestCachePolicy)cachePolicy
              progress:(void (^)(float downloadProgress))progress
               success:(void (^)(id responseObject))success
               failure:(void (^)(NSString *errorInfo))failure
{
    [self requestMethod:RequestType_GET urlString:urlStr parameters:parameters cachePolicy:cachePolicy manager:manager progress:progress success:success failure:failure];
}

+ (NSURLSessionDataTask *)requestMethod:(RequestType)type
                              urlString:(NSString *)urlStr
                             parameters:(id)parameters
                            cachePolicy:(RequestCachePolicy)cachePolicy
                                manager:(AFHTTPSessionManager *)manager
                               progress:(void (^)(float downloadProgress))progress
                                success:(void (^)(id responseObject))success
                                failure:(void (^)(NSString *errorInfo))failure{
    NSString *cacheKey = urlStr;
    if (parameters) {
        if (![NSJSONSerialization isValidJSONObject:parameters]) return nil;//参数不是json类型
        NSData *data = [NSJSONSerialization dataWithJSONObject:parameters options:NSJSONWritingPrettyPrinted error:nil];
        NSString *paramStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        cacheKey = [urlStr stringByAppendingString:paramStr];
    }
    YYCache *cache = [[YYCache alloc] initWithName:RequestCache];
    cache.memoryCache.shouldRemoveAllObjectsOnMemoryWarning = YES;
    cache.memoryCache.shouldRemoveAllObjectsWhenEnteringBackground = NO;
    id object = [cache objectForKey:urlStr];
    switch (cachePolicy) {
        case ReturnCacheDataThenLoad: {//先返回缓存，同时请求
            if (object) {
                success(object);
            }
            break;
        }
        case ReloadIgnoringLocalCacheData: {//忽略本地缓存直接请求
            //不做处理，直接请求
            break;
        }
        case ReturnCacheDataElseLoad: {//有缓存就返回缓存，没有就请求
            if (object) {//有缓存
                if (progress) {
                    progress(1.0);
                }
                success(object);
                return nil;
            }
            break;
        }
        case ReturnCacheDataDontLoad: {//有缓存就返回缓存,从不请求（用于没有网络）
            if (object) {//有缓存
                success(object);
            }
            return nil;//退出从不请求
        }
        default: {
            break;
        }
    }
    return [self requestMethod:type urlString:urlStr parameters:parameters cache:cache cacheKey:cacheKey manager:manager progress:progress success:success failure:failure];
}


#pragma mark - POST




+ (void)postJSONWithUrl:(NSString *)urlStr
             parameters:(id)parameters
                manager:(AFHTTPSessionManager *)manager
                success:(void (^)(id responseObject))success
                failure:(void (^)(NSString *errorInfo))failure
{
    [self requestMethod:RequestType_POST urlString:urlStr parameters:parameters cache:nil cacheKey:nil manager:manager progress:nil success:success failure:failure];
}
+ (void)postJSONWithUrl:(NSString *)urlStr
             parameters:(id)parameters
                success:(void (^)(id responseObject))success
                failure:(void (^)(NSString *errorInfo))failure
{
    [self requestMethod:RequestType_POST urlString:urlStr parameters:parameters cache:nil cacheKey:nil manager:nil progress:nil success:success failure:failure];
}

#pragma mark - PUT

+ (void)putJSONWithUrl:(NSString *)urlStr
            parameters:(id)parameters
               success:(void (^)(id responseObject))success
               failure:(void (^)(NSString *errorInfo))failure
{
    [self requestMethod:RequestType_PUT urlString:urlStr parameters:parameters cache:nil cacheKey:nil manager:nil progress:nil success:success failure:failure];
}

+ (void)putJSONWithUrl:(NSString *)urlStr
            parameters:(id)parameters
               manager:(AFHTTPSessionManager *)manager
               success:(void (^)(id responseObject))success
               failure:(void (^)(NSString *errorInfo))failure
{
    [self requestMethod:RequestType_PUT urlString:urlStr parameters:parameters cache:nil cacheKey:nil manager:manager progress:nil success:success failure:failure];
}


#pragma mark - DELETE

+ (void)deleteJSONWithUrl:(NSString *)urlStr
               parameters:(id)parameters
                  success:(void (^)(id responseObject))success
                  failure:(void (^)(NSString *errorInfo))failure
{
    [self requestMethod:RequestType_DELETE urlString:urlStr parameters:parameters cache:nil cacheKey:nil manager:nil progress:nil success:success failure:failure];
}

+ (void)deleteJSONWithUrl:(NSString *)urlStr
               parameters:(id)parameters
                  manager:(AFHTTPSessionManager *)manager
                  success:(void (^)(id responseObject))success
                  failure:(void (^)(NSString *errorInfo))failure
{
    [self requestMethod:RequestType_DELETE urlString:urlStr parameters:parameters cache:nil cacheKey:nil manager:manager progress:nil success:success failure:failure];
}


#pragma mark - Public Method (统一处理)

+ (NSURLSessionDataTask *)requestMethod:(RequestType)type
                              urlString:(NSString *)urlStr
                             parameters:(id)parameters
                                  cache:(YYCache *)cache
                               cacheKey:(NSString *)cacheKey
                                manager:(AFHTTPSessionManager *)manager
                               progress:(void (^)(float downloadProgress))progress
                                success:(void (^)(id responseObject))success
                                failure:(void (^)(NSString *errorInfo))failure{
 
    if ([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus == 0){
//        kShowHUD(@"网络无连接,请检查网络配置!");
        if (failure) {
            failure(@"网络无连接,请检查网络配置!");
        }
        return nil;
    };
   
    manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"application/json", @"text/json", nil];
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    [manager.requestSerializer setValue:app_Version forHTTPHeaderField:@"version"];
    
    urlStr = [NSString stringWithFormat:@"%@%@", k_statisticalURL, urlStr];
    switch (type) {
        case RequestType_GET:{
            return [manager GET:urlStr parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
                
                float download = 1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount;
                if (progress) {
                    progress(download);
                }
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if ([responseObject isKindOfClass:[NSData class]]) {
                    responseObject = [NSJSONSerialization objectWithJSONData:responseObject];
                }
                [cache setObject:responseObject forKey:cacheKey];//YYCache 已经做了responseObject为空处理
                if (success) {
                    success(responseObject);
                    
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failure) {
                    if (error) {
                        if ([[error.userInfo allKeys] containsObject:@"com.alamofire.serialization.response.error.data"]) {
                            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:error.userInfo[@"com.alamofire.serialization.response.error.data"] options:NSJSONReadingMutableContainers error:nil];
                            if ([dic objectForKey:@"error"]) {
                                if (![[[dic objectForKey:@"error"] objectForKey:@"message"] isKindOfClass:[NSNull class]] && [[dic objectForKey:@"error"] objectForKey:@"message"] != nil && [[[dic objectForKey:@"error"] objectForKey:@"message"] length] != 0) {
                                    NSLog(@"----------->Error Url(POST): %@\n----------->Error Message: %@", urlStr, [[dic objectForKey:@"error"] objectForKey:@"message"]);
                                    
                                    failure([[dic objectForKey:@"error"] objectForKey:@"message"]);
                                } else {
                                    NSLog(@"----------->Error Url(POST): %@\n----------->Error Message: %@", urlStr, [dic objectForKey:@"error"]);
                                    failure(@"未知错误");
                                }
                            } else {
                                NSLog(@"----------->Error Url(POST): %@\n----------->Error Message: %@", urlStr, error);
                                failure(@"未知错误");
                            }
                        } else {
                            NSLog(@"----------->Error Url(POST): %@\n----------->Error Message: %@", urlStr, error);
                            failure(@"未知错误");
                        }
                    }
                }
            }];
            break;
        }
        case RequestType_POST:{
            return [manager POST:urlStr parameters:parameters progress:nil success:^(NSURLSessionDataTask *task, id  _Nonnull responseObject) {
                success(responseObject);
            } failure:^(NSURLSessionDataTask *task, NSError * _Nonnull error) {

            }];
            break;
        }
        case RequestType_PUT:{
            return [manager PUT:urlStr parameters:parameters success:^(NSURLSessionDataTask *task, id  _Nonnull responseObject) {
                
                if (success) {
                    
                    success(responseObject);
                }
            } failure:^(NSURLSessionDataTask *task, NSError * _Nonnull error) {
                if (failure) {
                    
                    if (error) {
                        if ([[error.userInfo allKeys] containsObject:@"com.alamofire.serialization.response.error.data"]) {
                            
                            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:error.userInfo[@"com.alamofire.serialization.response.error.data"] options:NSJSONReadingMutableContainers error:nil];
                            if ([dic objectForKey:@"error"]) {
                                if (![[[dic objectForKey:@"error"] objectForKey:@"message"] isKindOfClass:[NSNull class]] && [[dic objectForKey:@"error"] objectForKey:@"message"] != nil && [[[dic objectForKey:@"error"] objectForKey:@"message"] length] != 0) {
                                    NSLog(@"----------->Error Url(POST): %@\n----------->Error Message: %@", urlStr, [[dic objectForKey:@"error"] objectForKey:@"message"]);
                                    
                                    failure([[dic objectForKey:@"error"] objectForKey:@"message"]);
                                } else {
                                    NSLog(@"----------->Error Url(POST): %@\n----------->Error Message: %@", urlStr, [dic objectForKey:@"error"]);
                                    failure(@"未知错误");
                                }
                            } else {
                                NSLog(@"----------->Error Url(POST): %@\n----------->Error Message: %@", urlStr, error);
                                failure(@"未知错误");
                            }
                        } else {
                            NSLog(@"----------->Error Url(POST): %@\n----------->Error Message: %@", urlStr, error);
                            failure(@"未知错误");
                        }
                    }
                }
                
            }];
            break;
        }
        case RequestType_DELETE:{
            return [manager DELETE:urlStr parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (success) {
                    success(responseObject);
                }
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
                if (failure) {
                    
                    if (error) {
                        if ([[error.userInfo allKeys] containsObject:@"com.alamofire.serialization.response.error.data"]) {
                            
                            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:error.userInfo[@"com.alamofire.serialization.response.error.data"] options:NSJSONReadingMutableContainers error:nil];
                            if ([dic objectForKey:@"error"]) {
                                if (![[[dic objectForKey:@"error"] objectForKey:@"message"] isKindOfClass:[NSNull class]] && [[dic objectForKey:@"error"] objectForKey:@"message"] != nil && [[[dic objectForKey:@"error"] objectForKey:@"message"] length] != 0) {
                                    NSLog(@"----------->Error Url(POST): %@\n----------->Error Message: %@", urlStr, [[dic objectForKey:@"error"] objectForKey:@"message"]);
                                    
                                    failure([[dic objectForKey:@"error"] objectForKey:@"message"]);
                                } else {
                                    NSLog(@"----------->Error Url(POST): %@\n----------->Error Message: %@", urlStr, [dic objectForKey:@"error"]);
                                    failure(@"未知错误");
                                }
                            } else {
                                NSLog(@"----------->Error Url(POST): %@\n----------->Error Message: %@", urlStr, error);
                                failure(@"未知错误");
                            }
                        } else {
                            NSLog(@"----------->Error Url(POST): %@\n----------->Error Message: %@", urlStr, error);
                            failure(@"未知错误");
                        }
                    }
                }
            }];
            break;
        }
        default:
            break;
    }
    return nil;
}


+ (AFHTTPSessionManager *)httpTextHtml
{
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [manager.requestSerializer setValue:@"text/html; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    return manager;
}



@end

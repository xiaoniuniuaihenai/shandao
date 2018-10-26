//
//  Http.h
//  种草没
//
//  Created by 陈传亮 on 16/5/25.
//  Copyright © 2016年 古乐. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

static NSString * const RequestCache = @"RequestCache";
typedef NS_ENUM(NSUInteger, RequestType) {
    RequestType_GET = 0,
    RequestType_POST,
    RequestType_DELETE,
    RequestType_PUT
};

typedef NS_ENUM(NSUInteger, RequestCachePolicy){
    ReturnCacheDataThenLoad = 0,///< 有缓存就先返回缓存，同步请求数据
    ReloadIgnoringLocalCacheData, ///< 忽略缓存，重新请求
    ReturnCacheDataElseLoad,///< 有缓存就用缓存，没有缓存就重新请求(用于数据不变时)
    ReturnCacheDataDontLoad,///< 有缓存就用缓存，没有缓存就不发请求，当做请求出错处理（用于离线模式）
};


@interface HttpTool : NSObject

/*!
 *  网络状态判断
 *
 */

+ (void)netWorkStatus;

/*!
 *  GET请求 url,参数,缓存处理
 *
 *  @param urlStr       url
 *  @param parameters   参数
 *  @param cachePolicy  缓存处理
 *  @param success      成功的回调
 *  @param failure         失败的回调
 */

+ (void)getJSONWithUrl:(NSString *)urlStr
            parameters:(id)parameters
           cachePolicy:(RequestCachePolicy)cachePolicy
               success:(void (^)(id responseObject))success
               failure:(void (^)(NSString *errorInfo))failure;

/*!
 *  GET请求 url,参数,manager,缓存处理
 *
 *  @param urlStr       url
 *  @param parameters   参数
 *  @param manager      sessionManager
 *  @param cachePolicy  缓存处理
 *  @param success      成功的回调
 *  @param failure         失败的回调
 */

+ (void)getJSONWithUrl:(NSString *)urlStr
            parameters:(id)parameters
               manager:(AFHTTPSessionManager *)manager
           cachePolicy:(RequestCachePolicy)cachePolicy
               success:(void (^)(id responseObject))success
               failure:(void (^)(NSString *errorInfo))failure;

/*!
 *  GET请求 url,参数,缓存处理,progress
 *
 *  @param urlStr       url
 *  @param parameters   参数
 *  @param cachePolicy  缓存处理
 *  @param progress     请求进度
 *  @param success      成功的回调
 *  @param failure         失败的回调
 */

+ (void)getJSONWithUrl:(NSString *)urlStr
            parameters:(id)parameters
           cachePolicy:(RequestCachePolicy)cachePolicy
              progress:(void (^)(float downloadProgress))progress
               success:(void (^)(id responseObject))success
               failure:(void (^)(NSString *errorInfo))failure;

/*!
 *  GET请求 url,参数,manager,缓存处理,progress
 *
 *  @param urlStr       url
 *  @param parameters   参数
 *  @param manager      sessionManager
 *  @param cachePolicy  缓存处理
 *  @param progress     请求进度
 *  @param success      成功的回调
 *  @param failure         失败的回调
 */

+ (void)getJSONWithUrl:(NSString *)urlStr
            parameters:(id)parameters
               manager:(AFHTTPSessionManager *)manager
           cachePolicy:(RequestCachePolicy)cachePolicy
              progress:(void (^)(float downloadProgress))progress
               success:(void (^)(id responseObject))success
               failure:(void (^)(NSString *errorInfo))failure;

/*!
 *  POST请求 url,参数
 *
 *  @param urlStr       url
 *  @param parameters   参数
 *  @param success      成功的回调
 *  @param failure         失败的回调
 */

+ (void)postJSONWithUrl:(NSString *)urlStr
             parameters:(id)parameters
                success:(void (^)(id responseObject))success
                failure:(void (^)(NSString *errorInfo))failure;

/*!
 *  POST请求 url,参数,manager
 *
 *  @param urlStr       url
 *  @param parameters   参数
 *  @param manager      sessionManager
 *  @param success      成功的回调
 *  @param failure         失败的回调
 */

+ (void)postJSONWithUrl:(NSString *)urlStr
             parameters:(id)parameters
                manager:(AFHTTPSessionManager *)manager
                success:(void (^)(id responseObject))success
                failure:(void (^)(NSString *errorInfo))failure;

/*!
 *  PUT请求 url,参数
 *
 *  @param urlStr       url
 *  @param parameters   参数
 *  @param success      成功的回调
 *  @param failure         失败的回调
 */

+ (void)putJSONWithUrl:(NSString *)urlStr
            parameters:(id)parameters
               success:(void (^)(id responseObject))success
               failure:(void (^)(NSString *errorInfo))failure;

/*!
 *  PUT请求 url,参数,manager
 *
 *  @param urlStr       url
 *  @param parameters   参数
 *  @param manager      sessionManager
 *  @param success      成功的回调
 *  @param failure         失败的回调
 */

+ (void)putJSONWithUrl:(NSString *)urlStr
            parameters:(id)parameters
               manager:(AFHTTPSessionManager *)manager
               success:(void (^)(id responseObject))success
               failure:(void (^)(NSString *errorInfo))failure;

/*!
 *  DELETE请求 url,参数
 *
 *  @param urlStr       url
 *  @param parameters   参数
 *  @param success      成功的回调
 *  @param failure         失败的回调
 */

+ (void)deleteJSONWithUrl:(NSString *)urlStr
               parameters:(id)parameters
                  success:(void (^)(id responseObject))success
                  failure:(void (^)(NSString *errorInfo))failure;

/*!
 *  DELETE请求 url,参数,manager
 *
 *  @param urlStr       url
 *  @param parameters   参数
 *  @param manager      sessionManager
 *  @param success      成功的回调
 *  @param failure         失败的回调
 */

+ (void)deleteJSONWithUrl:(NSString *)urlStr
               parameters:(id)parameters
                  manager:(AFHTTPSessionManager *)manager
                  success:(void (^)(id responseObject))success
                  failure:(void (^)(NSString *errorInfo))failure;

/*!
 *  UPLOAD请求
 *
 *  @param urlStr       上传地址
 *  @param fileURL      文件路径
 *  @param fileName     自定义文件名
 *  @param fileTye      文件类型
 *  @param progress     上传进度
 *  @param success      成功的回调
 *  @param failure         失败的回调
 */

+ (void)fileUploadWithUrl:(NSString *)urlStr
                  fileUrl:(NSURL *)fileURL
                 fileName:(NSString *)fileName
                 fileType:(NSString *)fileTye
                 progress:(void (^)(float uploadProgress))progress
                  success:(void (^)(id responseObject))success
                  failure:(void (^)(NSString *errorInfo))failure;

/*!
 *  DOWNLOAD请求
 *
 *  @param urlStr       下载地址
 *  @param fileName     自定义文件名
 *  @param progress     下载进度
 *  @param success      成功的回调
 *  @param failure         失败的回调
 */

+ (void)fileDownloadWithUrl:(NSString *)urlStr
                   fileName:(NSString *)fileName
                   progress:(void (^)(float downloadProgress))progress
                    success:(void (^)(NSURL *fileURL))success
                    failure:(void (^)())failure;



//  格式
+ (AFHTTPSessionManager *)httpTextHtml;










@end

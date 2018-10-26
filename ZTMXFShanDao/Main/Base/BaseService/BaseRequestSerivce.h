//
//  BaseRequestSerivce.h
//  CoreFrame
//
//  Created by yangpenghua on 2017/8/28.
//  Copyright © 2017年 yangpenghua. All rights reserved.
//

#import "YTKRequest.h"

typedef void(^ successBlock)(NSDictionary *responseDict);
typedef void(^ failureBlock)(__kindof YTKBaseRequest *request);


@interface BaseRequestSerivce : YTKRequest

// 是否隐藏请求弹窗
@property (nonatomic,assign) BOOL  isHideToast;

//  发起网络请求
- (void)requestWithSuccess:(successBlock)success failure:(failureBlock)failure;

//  设置基础参数
+ (NSDictionary *)baseDictionaryWithBaseParameters:(NSDictionary *)dic method:(NSString *)method;

@end

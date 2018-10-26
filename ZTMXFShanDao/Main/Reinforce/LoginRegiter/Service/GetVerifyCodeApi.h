//
//  GetVerifyCodeApi.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/9/20.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "BaseRequestSerivce.h"

@interface GetVerifyCodeApi : BaseRequestSerivce

- (instancetype)initWithUserPhone:(NSString *)userPhone codeType:(NSString *)type imgCode:(NSString*)imgCode;

@end

//
//  GainImgCodeApi.h
//  ZTMXFXunMiaoiOS
//
//  Created by 朱吉达 on 2018/1/11.
//  Copyright © 2018年 LSCredit. All rights reserved.
//  获取图片验证码  v1.7.0

#import "BaseRequestSerivce.h"

@interface GainImgCodeApi : BaseRequestSerivce
//-(instancetype)initWithMobile:(NSString *)mobile;
-(instancetype)initWithMobile:(NSString *)mobile type:(NSString *)type;

@end

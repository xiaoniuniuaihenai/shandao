//
//  LSUploadIdfImgeResultApi.h
//  ZTMXFXunMiaoiOS
//
//  Created by 朱吉达 on 2017/9/28.
//  Copyright © 2017年 LSCredit. All rights reserved.
//  身份证识别 埋点

#import "BaseRequestSerivce.h"

@interface LSUploadIdfImgeResultApi : BaseRequestSerivce
-(instancetype)initUploadWithType:(NSString*)type andResult:(NSString*)result;
@end

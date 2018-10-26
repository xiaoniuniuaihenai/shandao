//
//  LSAuthZhimaApi.h
//  ZTMXFXunMiaoiOS
//
//  Created by 朱吉达 on 2017/9/24.
//  Copyright © 2017年 LSCredit. All rights reserved.
//  芝麻信用  认证

#import "BaseRequestSerivce.h"

@interface LSAuthZhimaApi : BaseRequestSerivce
-(instancetype)initWithSign:(NSString*)sign andRespBody:(NSString*)respBody;
@end

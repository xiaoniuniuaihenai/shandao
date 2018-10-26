//
//  CheckPayPasswordApi.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/9/22.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "BaseRequestSerivce.h"

@interface CheckPayPasswordApi : BaseRequestSerivce
- (instancetype)initWithPassword:(NSString *)password;

@end

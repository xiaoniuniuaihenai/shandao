//
//  MobileAttributionApi.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2018/1/30.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "BaseRequestSerivce.h"

@interface MobileAttributionApi : BaseRequestSerivce

- (instancetype)initWithMobile:(NSString *)phoneNumber;

@end

//
//  RegisterApi.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/9/18.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "BaseRequestSerivce.h"

@interface RegisterApi : BaseRequestSerivce

- (instancetype)initWithUserPhone:(NSString *)userPhone password:(NSString *)password securityCode:(NSString *)code recommendPhone:(NSString *)recommender;

@end

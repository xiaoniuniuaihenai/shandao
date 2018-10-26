//
//  ZTMXFLoginApi.h
//  ZTMXFXunMiaoiOS
//
//  Created by 余金超 on 2018/5/7.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "BaseRequestSerivce.h"

@interface ZTMXFLoginApi : BaseRequestSerivce
- (instancetype)initWithLoginType:(NSString *)type VerficationCode:(NSString *)verficationCode Password:(NSString *)password;
@end

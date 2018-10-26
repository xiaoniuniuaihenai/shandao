//
//  LSAuthContactsApi.h
//  ZTMXFXunMiaoiOS
//
//  Created by 朱吉达 on 2017/9/23.
//  Copyright © 2017年 LSCredit. All rights reserved.
//  同步通讯录

#import "BaseRequestSerivce.h"

@interface LSAuthContactsApi : BaseRequestSerivce
-(instancetype)initWithContacts:(NSString*)contacts;
@end

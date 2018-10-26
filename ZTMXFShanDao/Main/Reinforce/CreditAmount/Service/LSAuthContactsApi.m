//
//  LSAuthContactsApi.m
//  ZTMXFXunMiaoiOS
//
//  Created by 朱吉达 on 2017/9/23.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "LSAuthContactsApi.h"
@interface LSAuthContactsApi()
@property (nonatomic,copy) NSString * contacts;
@end
@implementation LSAuthContactsApi

-(NSString*)requestUrl{
    return @"/auth/authContacts";
}
-(id)requestArgument{
    NSMutableDictionary * rqDic = [[NSMutableDictionary alloc]init];
    [rqDic setValue:_contacts forKey:@"contacts"];
    return rqDic;
}

-(instancetype)initWithContacts:(NSString*)contacts{
    if (self = [super init]) {
        _contacts = contacts;
    }
    return self;
}
@end

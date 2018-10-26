//
//  GainImgCodeApi.m
//  ZTMXFXunMiaoiOS
//
//  Created by 朱吉达 on 2018/1/11.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "GainImgCodeApi.h"
@interface GainImgCodeApi ()
@property (nonatomic,copy) NSString * mobile;

@property (nonatomic,copy) NSString * type;

@end
@implementation GainImgCodeApi
-(instancetype)initWithMobile:(NSString *)mobile type:(NSString *)type
{
    if (self = [super init]) {
        _mobile = mobile;
        _type = type;
    }
    return self;
}
- (NSString *)requestUrl{
//    http://tapi.letto8.cn/user/getImgCode
    return @"/user/getImgCode";
}
-(id)requestArgument{
    NSMutableDictionary * dic = [[NSMutableDictionary alloc]init];
    [dic setValue:_mobile forKey:@"mobile"];
    [dic setValue:_type forKey:@"type"];

    return dic;

}
@end

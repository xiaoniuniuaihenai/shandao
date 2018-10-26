//
//  LSAuthZhimaApi.m
//  ZTMXFXunMiaoiOS
//
//  Created by 朱吉达 on 2017/9/24.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "LSAuthZhimaApi.h"
@interface LSAuthZhimaApi()
@property (nonatomic,copy) NSString * signStr;
@property (nonatomic,copy) NSString * respBodyStr;

@end
@implementation LSAuthZhimaApi
-(instancetype)initWithSign:(NSString*)sign andRespBody:(NSString*)respBody{
    if (self = [super init]) {
        _signStr = sign;
        _respBodyStr = respBody;
    }
    return self;
}


-(id)requestArgument{
    NSMutableDictionary * rqDic = [[NSMutableDictionary alloc]init];
    [rqDic setValue:_signStr forKey:@"sign"];
    [rqDic setValue:_respBodyStr forKey:@"respBody"];
    return rqDic;
}

-(NSString *)requestUrl{
    return @"/auth/authZhima";
}
@end

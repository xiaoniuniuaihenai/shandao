//
//  ShareAddRecommendApi.m
//  ZTMXFXunMiaoiOS
//
//  Created by 朱吉达 on 2017/9/30.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "ShareAddRecommendApi.h"
@interface ShareAddRecommendApi()
@property (nonatomic,copy) NSString * shareType;
@end
@implementation ShareAddRecommendApi
-(instancetype)initWithType:(NSString*)shareType{
    if (self = [super init]) {
        _shareType = shareType;
    }
    return self;
}
-(NSString*)requestUrl{
    return @"/user/addRecommendShared";
}
-(id)requestArgument{
    
    NSMutableDictionary * dic =[[NSMutableDictionary alloc]init];
    [dic setValue:_shareType forKey:@"type"];
    return dic;
}
@end

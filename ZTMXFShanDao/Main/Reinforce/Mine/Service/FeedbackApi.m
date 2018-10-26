//
//  FeedbackApi.m
//  ZTMXFXunMiaoiOS
//
//  Created by 朱吉达 on 2018/1/29.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "FeedbackApi.h"
@interface FeedbackApi()
@property (nonatomic,copy) NSString * detailStr;
@property (nonatomic,copy) NSString * imgsUrl;
@end
@implementation FeedbackApi
-(instancetype)initWithOpinionMsg:(NSString * )detail imagesUrl:(NSString*)imgsURL{
    if (self = [super init]) {
        _detailStr = detail;
        _imgsUrl = imgsURL;
        
    }
    return self;
}
-(NSString*)requestUrl{
    return @"/system/commitFeedback";
}
-(id)requestArgument{
    NSMutableDictionary * dicArgument = [[NSMutableDictionary alloc]init];
    [dicArgument setValue:_detailStr forKey:@"detail"];
    [dicArgument setValue:_imgsUrl forKey:@"images"];
    return dicArgument;
}
@end

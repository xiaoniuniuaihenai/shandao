//
//  FeedbackApi.h
//  ZTMXFXunMiaoiOS
//
//  Created by 朱吉达 on 2018/1/29.
//  Copyright © 2018年 LSCredit. All rights reserved.
//  意见反馈Api

#import "BaseRequestSerivce.h"

@interface FeedbackApi : BaseRequestSerivce
-(instancetype)initWithOpinionMsg:(NSString * )detail imagesUrl:(NSString*)imgsURL;
@end

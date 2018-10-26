//
//  ShareAddRecommendApi.h
//  ZTMXFXunMiaoiOS
//
//  Created by 朱吉达 on 2017/9/30.
//  Copyright © 2017年 LSCredit. All rights reserved.
//  添加分享记录

#import "BaseRequestSerivce.h"
@interface ShareAddRecommendApi : BaseRequestSerivce
/**类型   0 微信朋友圈，1 微信好友，2 qq空间 ，3微博 4 短信 5二维码 6qq*/
-(instancetype)initWithType:(NSString*)shareType;
@end

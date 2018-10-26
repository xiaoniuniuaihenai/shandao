//
//  ZTMXFUMengHelper.h
//  ZTMXFXunMiaoiOS
//
//  Created by 陈传亮 on 2018/4/20.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZTMXFUMengHelper : NSObject

+ (void)mqEvent:(NSString *)eventId;

+ (void)mqEvent:(NSString *)eventId parameter:(NSDictionary *)parameter;

/** 账号退出
 */
+(void)UMFileSignOff;
//[param addEntriesFromDictionary:self.selectedDic];

@end

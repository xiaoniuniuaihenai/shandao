//
//  ZTMXFServerStatisticalHelper.h
//  ZTMXFXunMiaoiOS
//
//  Created by 陈传亮 on 2018/5/23.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZTMXFServerStatisticalHelper : NSObject

+ (NSDictionary *)baseDictionary;

+ (void)loanStatisticalApiWithIntoTime:(NSDate *)date CurrentClassName:(NSString *)className PageName:(NSString *)pageName;

+ (void)loanStatisticalApiWithIoutTime:(NSDate *)date CurrentClassName:(NSString *)className PageName:(NSString *)pageName;

@end

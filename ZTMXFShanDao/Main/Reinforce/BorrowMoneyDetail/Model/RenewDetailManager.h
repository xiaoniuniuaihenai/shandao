//
//  RenewDetailManager.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/9/24.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LSRenewDetailModel;

@interface RenewDetailManager : NSObject

+ (NSArray *)manageWithRenewDetailModel:(LSRenewDetailModel *)renewDetailModel;

@end

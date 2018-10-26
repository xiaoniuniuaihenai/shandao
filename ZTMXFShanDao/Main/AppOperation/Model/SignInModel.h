//
//  SignInModel.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/9/25.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SignInModel : NSObject

/** 周期 */
@property (nonatomic, assign) NSInteger cycle;
/** T 可以签到；F不能签到 */
@property (nonatomic, copy) NSString *isSignin;
/** 签到规则 */
@property (nonatomic, copy) NSString *ruleSignin;
/** 积累签到天数 */
@property (nonatomic, assign) NSInteger seriesCount;

@end

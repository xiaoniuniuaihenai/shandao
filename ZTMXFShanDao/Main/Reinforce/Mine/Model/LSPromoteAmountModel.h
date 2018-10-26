//
//  LSPromoteAmountModel.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/9/19.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSPromoteAmountModel : NSObject

/** 提额时间 */
@property (nonatomic, assign) long long gmtAuthAmount;
/** 类型 */
@property (nonatomic, copy) NSString *type;
/** 类型描述 */
@property (nonatomic, copy) NSString *typeDec;
/** 最新额度 */
@property (nonatomic, assign) CGFloat amount;
/** 上次额度 */
@property (nonatomic, assign) CGFloat originalAmount;

@end

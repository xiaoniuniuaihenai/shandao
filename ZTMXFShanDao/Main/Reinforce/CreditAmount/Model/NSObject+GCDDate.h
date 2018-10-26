//
//  NSObject+GCDDate.h
//  ZTMXFXunMiaoiOS
//
//  Created by 朱吉达 on 2017/10/24.
//  Copyright © 2017年 LSCredit. All rights reserved.
//  倒计时

#import <Foundation/Foundation.h>
/**
 *  处理倒计时停止的回调
 */
typedef void(^HandleStopCountdownBlock)(NSInteger minutes,NSInteger seconds,NSString *stopTime);
/**
 *  处理倒计时改变的回调
 */
typedef void(^HandleChangeCountdownBlock)(NSInteger minutes,NSInteger seconds,NSString *changeTime);

@interface NSObject (GCDDate)
/**
 *  GCD定时器（倒计时）
 *
 *  param   Timeout                         倒计时开始时间
 *  param   handleChangeCountdownBlock      倒计时时间改变回调
 *  param   handleStopCountdownBlock        倒计时时间停止回调
 */
+ (dispatch_source_t)queryGCDWithTimeout:(NSInteger)Timeout
              handleChangeCountdownBlock:(HandleChangeCountdownBlock)handleChangeCountdownBlock
                handleStopCountdownBlock:(HandleStopCountdownBlock)handleStopCountdownBlock;


@end

//
//  NSObject+GCDDate.m
//  ZTMXFXunMiaoiOS
//
//  Created by 朱吉达 on 2017/10/24.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "NSObject+GCDDate.h"

@implementation NSObject (GCDDate)
+ (dispatch_source_t)queryGCDWithTimeout:(NSInteger)Timeout
              handleChangeCountdownBlock:(HandleChangeCountdownBlock)handleChangeCountdownBlock
                handleStopCountdownBlock:(HandleStopCountdownBlock)handleStopCountdownBlock
{
    __block NSInteger timeout = Timeout;//倒计时时间
    dispatch_queue_t queue =dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0);
    dispatch_source_t _timer =dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER,0,0, queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL,0),1.0 * NSEC_PER_SEC,0);//每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout <=0){//倒计时结束，关闭
            
            //取消
            dispatch_source_cancel(_timer);
            //回到主线程
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置界面的按钮显示根据自己需求设置
                if (handleStopCountdownBlock)
                {
                    NSString *timeoutStr = [NSString stringWithFormat:@"%ld",timeout];
                    handleStopCountdownBlock(0,0,timeoutStr);
                }
                
            });
        }else{
            
           __block NSInteger minutes = 0;
           __block NSInteger seconds = 0;
            NSString *strTime;
            
            if (timeout >60)
            {
                minutes = timeout / 60;
                seconds = timeout % 60;
                strTime = [NSString stringWithFormat:@"%ld分%.2ld秒",(long)minutes, (long)seconds];
            }
            else
            {
                seconds = timeout % 60;
                strTime = [NSString stringWithFormat:@"%ld秒",(long)seconds];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示根据自己需求设置
                if (handleChangeCountdownBlock)
                {
                    handleChangeCountdownBlock(minutes,seconds,strTime);
                }
                
            });
            timeout--;
        }
    });
    //启动
    dispatch_resume(_timer);
    
    return _timer;
}

@end

//
//  TextLoopView.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/12/12.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol TextLoopViewDelegate <NSObject>
/** 点击轮播图 */
- (void)textLoopViewClickWithIndex:(NSInteger )index;
@end

@interface ZTMXFTextLoopView : UIView

/**
 直接调用这个方法
 
 @param dataSource 数据源
 @param timeInterval 时间间隔,默认是1.0秒
 @param frame 控件大小
 */
+ (instancetype)textLoopViewWith:(NSArray *)dataSource loopInterval:(NSTimeInterval)timeInterval initWithFrame:(CGRect)frame;
@property (nonatomic, weak) id<TextLoopViewDelegate> delegate;

- (void)configTextLoopArray:(NSArray *)textArray;

@end

//
//  LSSegmentView.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/12/15.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SegmentViewDelegate <NSObject>

/** 选中索引 */
- (void)segmentViewSelectIndex:(NSInteger)index;

@end

@interface LSSegmentView : UIView

@property (nonatomic, weak) id<SegmentViewDelegate> delegate;

//  选中消费贷认证
- (void)selectConsumeLoanAuth;
//  选中白领贷认证
- (void)selectWhiteLoanAuth;

@end

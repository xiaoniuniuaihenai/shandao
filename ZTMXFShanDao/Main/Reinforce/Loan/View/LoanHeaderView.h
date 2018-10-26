//
//  LoanHeaderView.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2018/1/9.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LSBorrowBannerModel;
@class LSHornBarModel;
@protocol LoanHeaderViewDelegate <NSObject>
/** 点击轮播图 */
- (void)loanHeaderViewClickBannerImage:(LSBorrowBannerModel *)bannerModel;
// 点击头部广播
- (void)loanHeaderViewClickTextLoopView:(LSHornBarModel *)hornModel;

@end

@interface LoanHeaderView : UIView

/** 轮播图数组 */
@property (nonatomic, strong) NSArray *bannerImageArray;
/** 跑马灯数组 */
@property (nonatomic, strong) NSArray *noticeTextArray;

@property (nonatomic, weak) id<LoanHeaderViewDelegate> delegate;

@end

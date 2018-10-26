//
//  InstallmentInfoView.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2018/1/5.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GoodsNperInfoModel;

@protocol InstallmentInfoViewDelegate <NSObject>

/** 点击选择分期 */
- (void)installmentInfoViewSelectNperInfoModel:(GoodsNperInfoModel *)nperInfoModel;

@end

@interface InstallmentInfoView : UIView

/** 分期数组数据 */
@property (nonatomic, strong) NSArray *installmentArray;

@property (nonatomic, weak) id<InstallmentInfoViewDelegate> delegate;

@end


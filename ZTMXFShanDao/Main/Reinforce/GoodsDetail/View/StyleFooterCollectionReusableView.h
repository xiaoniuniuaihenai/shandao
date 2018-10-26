//
//  StyleFooterCollectionReusableView.h
//  ALAFanBei
//
//  Created by yangpenghua on 2017/7/18.
//  Copyright © 2017年 阿拉丁. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AddNumberView;
@class ChoiseGoodsByStageView;

@interface StyleFooterCollectionReusableView : UICollectionReusableView
/** 购买数量背景view */
@property (nonatomic, strong) AddNumberView     *addNumberView;
/** 返呗分期 */
@property (nonatomic, strong) UILabel           *bystageLabel;
/** 分期view */
@property (nonatomic, strong) ChoiseGoodsByStageView  *goodsBystageView;

@end

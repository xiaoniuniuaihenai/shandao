//
//  HomePagePopupView.h
//  ALAFanBei
//
//  Created by yangpenghua on 17/5/16.
//  Copyright © 2017年 讯秒. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HomePagePopupViewDelegate <NSObject>

@optional
- (void)homePagePopupViewClickAdImageView;

@end

@interface HomePagePopupView : UIView

/** 蒙版view */
@property (nonatomic, strong) UIView       *maskBackgroundView;
/** 首页广告图片 */
@property (nonatomic, strong) UIImageView  *adImageView;
/** 广告按钮 */
@property (nonatomic, strong) UIButton     *adButton;
/** 取消按钮 */
@property (nonatomic, strong) UIButton     *cancelButton;

+ (instancetype)popupView;

@property (nonatomic, weak) id<HomePagePopupViewDelegate> delegate;

- (void)hiddenViewWithNoAnimation;

@end

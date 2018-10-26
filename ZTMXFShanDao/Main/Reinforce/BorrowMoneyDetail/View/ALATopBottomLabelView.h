//
//  ALATopBottomLabelView.h
//  ALAFanBei
//
//  Created by yangpenghua on 17/2/15.
//  Copyright © 2017年 讯秒. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ALATopBottomLabelView;

@protocol ALATopBottomLabelViewDelegate <NSObject>

- (void)topBottomLabelViewClickButton:(ALATopBottomLabelView *)view;

@end

@interface ALATopBottomLabelView : UIView

/** top text */
@property (nonatomic, copy) NSString *topStr;
/** top label Color */
@property (nonatomic, strong) UIColor *topTitleColor;
/** top Font */
@property (nonatomic, assign) CGFloat topFontSize;

/** 设置bottom text */
@property (nonatomic, copy) NSString *bottomStr;
/** bottom text Color */
@property (nonatomic, strong) UIColor *bottomTitleColor;
/** top Font */
@property (nonatomic, assign) CGFloat bottomFontSize;

/** button */
@property (nonatomic, strong) UIButton *viewButton;

//  设置整体字体对齐方式
- (void)setAllTextAlignment:(NSTextAlignment)textAlignment;

@property (nonatomic, weak) id<ALATopBottomLabelViewDelegate> delegate;

@end

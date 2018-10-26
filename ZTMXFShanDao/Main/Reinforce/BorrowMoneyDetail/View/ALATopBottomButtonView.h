//
//  ALATopBottomButtonView.h
//  ALAFanBei
//
//  Created by yangpenghua on 17/2/15.
//  Copyright © 2017年 讯秒. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ALATopBottomButtonViewDelegate <NSObject>

//  点击查看明细
- (void)topBottomButtonViewClickViewDetail;

@end

@interface ALATopBottomButtonView : UIView

//  设置top text
@property (nonatomic, copy) NSString *topStr;
//  设置bottom text
@property (nonatomic, copy) NSString *bottomStr;
/** top text color */
@property (nonatomic, strong) UIColor *topTextColor;
/** bottom text color */
@property (nonatomic, strong) UIColor *bottomTextColor;
/** top text fontSize */
@property (nonatomic, assign) CGFloat topFontSize;
/** bottom text fontSize */
@property (nonatomic, assign) CGFloat bottomFontSize;

/** 是否显示查看明细按钮 */
@property (nonatomic, assign) BOOL showViewDetailButton;
/** 是否显示箭头 */
@property (nonatomic, assign) BOOL showRowImageView;

/** 设置文字居中 */
@property (nonatomic, assign) BOOL textCenter;
@property (nonatomic, weak) id<ALATopBottomButtonViewDelegate> delegate;

//  设置整体字体对齐方式
- (void)setAllTextAlignment:(NSTextAlignment)textAlignment;

- (instancetype)initWithTopTitle:(NSString *)topTitle bottomTitle:(NSString *)bottomTitle target:(NSObject *)obj action:(SEL)action;


@end

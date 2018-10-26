//
//  LSTopBottomLabelView.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/11/16.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LSTopBottomLabelView : UIView

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

/** top bottom Margin */
@property (nonatomic, assign) CGFloat topBottomMargin;

//  设置整体字体对齐方式
- (void)setAllTextAlignment:(NSTextAlignment)textAlignment;

- (instancetype)initWithTopStr:(NSString *)topStr bottomStr:(NSString *)bottomStr;

@end

//
//  LSTitleValueCellView.h
//  ALAFanBei
//
//  Created by yangpenghua on 17/2/15.
//  Copyright © 2017年 讯秒. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LSTitleValueCellView : UIView

/** title */
@property (nonatomic, copy) NSString *titleStr;
/** value */
@property (nonatomic, strong) NSString *valueStr;

/** titletext color */
@property (nonatomic, copy) NSString *titleColorStr;
/** valuetext color */
@property (nonatomic, copy) NSString *valueColorStr;

/** title font size */
@property (nonatomic, assign) CGFloat titleFontSize;
/** value font size */
@property (nonatomic, assign) CGFloat valueFontSize;

/** title image str */
@property (nonatomic, copy) NSString *titleImageStr;
/** title image margin */
@property (nonatomic, assign) CGFloat titleImageMargin;

/** bottom Str 显示一行还是多行 */
@property (nonatomic, assign) BOOL showSigleLine;

- (instancetype)initWithTitle:(NSString *)title value:(NSString *)value target:(NSObject *)obj action:(SEL)action;


/** 是否显示下面的细线 */
@property (nonatomic, assign) BOOL showBottomLineView;
/** 是否显示箭头 */
@property (nonatomic, assign) BOOL showRowImageView;
/** 显示左右有间距的细线 */
@property (nonatomic, assign) BOOL showMarginBottomLineView;
/** 细线颜色 */
@property (nonatomic, strong) UIColor *bottomLineColor;

@end

//
//  ALATitleValueCellView.h
//  ALAFanBei
//
//  Created by yangpenghua on 17/2/15.
//  Copyright © 2017年 讯秒. All rights reserved.
//

#import <UIKit/UIKit.h>
/*长条选择工具*/
@interface ALATitleValueCellView : UIView

/** value label */
@property (nonatomic, strong) UILabel *valueLabel;

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
/** title font */
@property (nonatomic, strong) UIFont *titleFont;
/** value font size */
@property (nonatomic, assign) CGFloat valueFontSize;
/** value font */
@property (nonatomic, strong) UIFont *valueFont;
/** value NSTextAligment */
@property (nonatomic, assign) NSTextAlignment valueTextAlignment;

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
@end

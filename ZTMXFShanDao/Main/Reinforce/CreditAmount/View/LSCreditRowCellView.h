//
//  LSCreditRowCellView.h
//  ZTMXFXunMiaoiOS
//
//  Created by 朱吉达 on 2017/10/18.
//  Copyright © 2017年 LSCredit. All rights reserved.
//  信用  cell

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,LSCreditSeparatorStyle) {
    LSCreditSeparatorStyleDefault = 0, //实线
    LSCreditSeparatorStyleDotted, // 虚线
};
@interface LSCreditRowCellView : UIView

/**
 左icon 大小
 */
@property (nonatomic,assign) CGFloat imgLeftSize;
@property (nonatomic,assign) CGFloat titleFontSize;
@property (nonatomic,assign) CGFloat valueFontSize;
/** 标题与Icon间距 */
@property (nonatomic,assign) CGFloat titleMarginImgLeft;
/** 内容左右间距  */
@property (nonatomic,assign) CGFloat contentMargin;
/** 分割线 */
@property (nonatomic,assign) UIEdgeInsets lineEdgeInsets;
/** 分割线样式*/
@property (nonatomic,assign) LSCreditSeparatorStyle separatorStyle;
/** 是否隐藏分割线 */
@property (nonatomic,assign) BOOL isHideLine;
/** 是否隐藏 右箭头*/
@property (nonatomic,assign) BOOL isHideRightImg;
@property (nonatomic,copy  ) NSString * titleImageStr;
@property (nonatomic,copy  ) NSString * titleColor;
@property (nonatomic,copy  ) NSString * valueColor;
@property (nonatomic,copy  ) NSString * valueStr;
@property (nonatomic,copy  ) NSString * titleStr;

-(instancetype)initWithTitle:(NSString *)title value:(NSString *)value target:(NSObject *)obj action:(SEL)action;
@end

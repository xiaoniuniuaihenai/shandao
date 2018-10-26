//
//  UIButton+instance.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/9/18.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (instance)

+ (UIButton *)setupButtonWithSuperView:(UIView *)superView withFrame:(CGRect)frame withTitle:(NSString *)title;

+ (UIButton *)setupButtonWithSuperView:(UIView *)superView withTitle:(NSString *)title titleFont:(CGFloat)fontSize corner:(CGFloat)corner withObject:(NSObject *)obj action:(SEL)action;


/** 透明按钮 */
+ (UIButton *)setupButtonWithSuperView:(UIView *)superView withObject:(NSObject *)obj action:(SEL)action;

//   设置带图片和title的按钮
+ (UIButton *)setupButtonWithImageStr:(NSString *)imageStr title:(NSString *)title titleColor:(UIColor *)color titleFont:(CGFloat)fontSize withObject:(NSObject *)obj action:(SEL)action;

/** 设置按钮图片和文字间的距离 */
- (void)setupButtonImageTitleMargin:(double)margin;

/** 指定title里面的字符串的字体颜色 */
+ (UIButton *)setupButtonTitle:(NSString *)title titleColor:(NSString *)color anotherColorTitle:(NSString *)colorTitle anotherColor:(NSString *)anotherColor titleFont:(CGFloat)fontSize withObject:(NSObject *)obj action:(SEL)action;


@end

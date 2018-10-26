//
//  UILabel+instance.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/9/18.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (instance)

/**
 * 创建 UILabel
 *  @param titleColor    标题颜色
 *  @param titleFont 字体大小
 *  @return UILabel(文本水平居中)
 */
+ (instancetype)labelWithTitleColor:(UIColor *)titleColor titleFont:(UIFont *)titleFont alignment:(NSTextAlignment)alignment;

+ (instancetype)labelWithTitleColorStr:(NSString *)colorStr fontSize:(CGFloat)fontSize alignment:(NSTextAlignment)alignment;

+ (instancetype)labelWithTitleColorStr:(NSString *)colorStr titleFont:(UIFont *)titleFont alignment:(NSTextAlignment)alignment;

+ (instancetype)labelWithTitleColor:(UIColor *)titleColor fontSize:(CGFloat)fontSize alignment:(NSTextAlignment)alignment;



@end

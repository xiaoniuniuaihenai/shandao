//
//  UILabel+Attribute.h
//  Label颜色测试
//
//  Created by panfei mao on 2017/11/29.
//  Copyright © 2017年 panfei mao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Attribute)

/** 设置颜色 */
+ (void)attributeWithLabel:(UILabel *)label text:(NSString *)text textColor:(NSString *)textColorStr attributes:(NSArray *)attributeStrs attributeColors:(NSArray *)colors;

/** 设置字体大小 */
+ (void)attributeWithLabel:(UILabel *)label text:(NSString *)text textFont:(CGFloat)textFont attributes:(NSArray *)attributeStrs attributeFonts:(NSArray *)fonts;

/** 设置字体颜色和大小 */
+ (void)attributeWithLabel:(UILabel *)label text:(NSString *)text textColor:(NSString *)textColorStr attributesOriginalColorStrs:(NSArray *)originalColorStrs attributeNewColors:(NSArray *)newColors textFont:(CGFloat)textFont attributesOriginalFontStrs:(NSArray *)originalFontStrs attributeNewFonts:(NSArray *)newFonts;

/** 文字上对齐 */
+ (void)attributeWithLabel:(UILabel *)label text:(NSString *)text maxFont:(CGFloat)maxFont minFont:(CGFloat)minFont attributes:(NSArray *)attributeStrs attributeFonts:(NSArray *)fonts;


@end

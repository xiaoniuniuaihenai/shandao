//
//  UILabel+instance.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/9/18.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "UILabel+instance.h"

@implementation UILabel (instance)

+ (instancetype)labelWithTitleColor:(UIColor *)titleColor titleFont:(UIFont *)titleFont alignment:(NSTextAlignment)alignment{
    
    UILabel *label = [[UILabel alloc] init];
    if (!titleFont) {
        titleFont = [UIFont systemFontOfSize:14];
    }
    if (!titleColor) {
        titleColor = [UIColor blackColor];
    }
    label.textColor = titleColor;
    label.font = titleFont;
    label.numberOfLines = 0;
    label.textAlignment = alignment;
    return label;
    
}

+ (instancetype)labelWithTitleColorStr:(NSString *)colorStr fontSize:(CGFloat)fontSize alignment:(NSTextAlignment)alignment{
    UIColor *titleColor = [UIColor blackColor];
    if (colorStr) {
        titleColor = [UIColor colorWithHexString:colorStr];
    }
    UIFont *titleFont = [UIFont systemFontOfSize:14];
    if (fontSize > 0) {
        titleFont = FONT_Regular(fontSize);
    }
    UILabel *label = [UILabel labelWithTitleColor:titleColor titleFont:titleFont alignment:alignment];
    return label;
}

+ (instancetype)labelWithTitleColorStr:(NSString *)colorStr titleFont:(UIFont *)titleFont alignment:(NSTextAlignment)alignment{
    UIColor *titleColor = [UIColor blackColor];
    if (colorStr) {
        titleColor = [UIColor colorWithHexString:colorStr];
    }
    if (!titleFont) {
        titleFont = [UIFont systemFontOfSize:14];
    }
    UILabel *label = [UILabel labelWithTitleColor:titleColor titleFont:titleFont alignment:alignment];
    return label;
    
}

+ (instancetype)labelWithTitleColor:(UIColor *)titleColor fontSize:(CGFloat)fontSize alignment:(NSTextAlignment)alignment{
    if (!titleColor) {
        titleColor = [UIColor blackColor];
    }
    UIFont *titleFont = [UIFont systemFontOfSize:14];
    if (fontSize > 0) {
        titleFont = [UIFont systemFontOfSize:fontSize];
    }
    UILabel *label = [UILabel labelWithTitleColor:titleColor titleFont:titleFont alignment:alignment];
    return label;
    
}


@end

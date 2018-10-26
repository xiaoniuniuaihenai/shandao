//
//  UILabel+Attribute.m
//  Label颜色测试
//
//  Created by panfei mao on 2017/11/29.
//  Copyright © 2017年 panfei mao. All rights reserved.
//

#import "UILabel+Attribute.h"

@implementation UILabel (Attribute)

/** 设置颜色 */
+ (void)attributeWithLabel:(UILabel *)label text:(NSString *)text textColor:(NSString *)textColorStr attributes:(NSArray *)attributeStrs attributeColors:(NSArray *)colors{

    if (text) {
        NSMutableAttributedString * attDesc = [[NSMutableAttributedString alloc] initWithString:text];
        
        //  设置字体颜色
        UIColor *titleColor = [UIColor colorWithHexString:textColorStr];
        [attDesc addAttribute:NSForegroundColorAttributeName value:titleColor range:[text rangeOfString:text]];
        
        if (attributeStrs.count >0 && colors.count > 0 && attributeStrs.count == colors.count) {
            for (int i =0; i<attributeStrs.count; i++) {
                NSString *str = attributeStrs[i];
                UIColor *strColor = colors[i];
                [attDesc addAttribute:NSForegroundColorAttributeName value:strColor range:[text rangeOfString:str]];
            }
        }
        label.attributedText = attDesc;
    }
}

/** 设置字体大小 */
+ (void)attributeWithLabel:(UILabel *)label text:(NSString *)text textFont:(CGFloat)textFont attributes:(NSArray *)attributeStrs attributeFonts:(NSArray *)fonts{
    if (text) {
        NSMutableAttributedString * attDesc = [[NSMutableAttributedString alloc] initWithString:text];

        //  设置字体大小
        UIFont *titleFont = [UIFont systemFontOfSize:textFont];
        [attDesc addAttribute:NSFontAttributeName value:titleFont range:[text rangeOfString:text]];
        
        if (attributeStrs.count >0 && fonts.count > 0 && attributeStrs.count == fonts.count) {
            for (int i =0; i<attributeStrs.count; i++) {
                NSString *str = attributeStrs[i];
                UIFont *strFont = fonts[i];
                [attDesc addAttribute:NSFontAttributeName value:strFont range:[text rangeOfString:str]];
            }
        }
        label.attributedText = attDesc;
    }
}

/** 设置字体颜色和大小 */
+ (void)attributeWithLabel:(UILabel *)label text:(NSString *)text textColor:(NSString *)textColorStr attributesOriginalColorStrs:(NSArray *)originalColorStrs attributeNewColors:(NSArray *)newColors textFont:(CGFloat)textFont attributesOriginalFontStrs:(NSArray *)originalFontStrs attributeNewFonts:(NSArray *)newFonts{
    if (text) {
        NSMutableAttributedString * attDesc = [[NSMutableAttributedString alloc] initWithString:text];
        //  设置字体颜色
        UIColor *titleColor = [UIColor colorWithHexString:textColorStr];
        [attDesc addAttribute:NSForegroundColorAttributeName value:titleColor range:[text rangeOfString:text]];
        
        //  设置字体大小
        UIFont *titleFont = [UIFont systemFontOfSize:textFont];
        [attDesc addAttribute:NSFontAttributeName value:titleFont range:[text rangeOfString:text]];
        
        //  设置字体颜色
        if (originalColorStrs.count >0 && newColors.count > 0 && originalColorStrs.count == newColors.count) {
            for (int i =0; i<originalColorStrs.count; i++) {
                NSString *str = originalColorStrs[i];
                UIColor *strColor = newColors[i];
                [attDesc addAttribute:NSForegroundColorAttributeName value:strColor range:[text rangeOfString:str]];
            }
        }
        
        //  设置字体大小
        if (originalFontStrs.count >0 && newFonts.count > 0 && originalFontStrs.count == newFonts.count) {
            for (int i =0; i<originalFontStrs.count; i++) {
                NSString *str = originalFontStrs[i];
                UIFont *strFont = newFonts[i];
                [attDesc addAttribute:NSFontAttributeName value:strFont range:[text rangeOfString:str]];
            }
        }
        label.attributedText = attDesc;
    }

}



/** 文字上对齐 */
+ (void)attributeWithLabel:(UILabel *)label text:(NSString *)text maxFont:(CGFloat)maxFont minFont:(CGFloat)minFont attributes:(NSArray *)attributeStrs attributeFonts:(NSArray *)fonts
{
    if (text) {
        NSMutableAttributedString * attDesc = [[NSMutableAttributedString alloc] initWithString:@""];
        if (attributeStrs.count >0 && fonts.count > 0 && attributeStrs.count == fonts.count) {
            for (int i =0; i<attributeStrs.count; i++) {
                NSString *str = attributeStrs[i];
                NSAttributedString *string25;
                if (i == 0) {
                     string25 = [[NSAttributedString alloc] initWithString:str attributes:@{NSFontAttributeName : fonts[i],NSForegroundColorAttributeName : label.textColor,NSBaselineOffsetAttributeName : @((maxFont - minFont) / 2 + 3)}];
                }else{
                    string25 = [[NSAttributedString alloc] initWithString:str attributes:@{NSFontAttributeName : fonts[i],NSForegroundColorAttributeName : label.textColor}];
                }
                [attDesc appendAttributedString:string25];
            }
        }
        label.attributedText = attDesc;
    }
}



@end

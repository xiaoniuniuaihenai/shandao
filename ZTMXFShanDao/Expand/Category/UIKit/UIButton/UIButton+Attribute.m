//
//  UIButton+Attribute.m
//  Label颜色测试
//
//  Created by panfei mao on 2017/11/29.
//  Copyright © 2017年 panfei mao. All rights reserved.
//

#import "UIButton+Attribute.h"

@implementation UIButton (Attribute)

+ (void)attributeWithBUtton:(UIButton *)button title:(NSString *)text titleColor:(NSString *)titleColorStr forState:(UIControlState)state attributes:(NSArray *)attributeStrs attributeColors:(NSArray *)colors{
    if (text) {
        NSMutableAttributedString * attDesc = [[NSMutableAttributedString alloc] initWithString:text];
        UIColor *titleColor = [UIColor colorWithHexString:titleColorStr];
        [attDesc addAttribute:NSForegroundColorAttributeName value:titleColor range:[text rangeOfString:text]];
        
        if (attributeStrs.count >0 && colors.count > 0 && attributeStrs.count == colors.count) {
            for (int i =0; i<attributeStrs.count; i++) {
                NSString *str = attributeStrs[i];
                UIColor *strColor = colors[i];
                [attDesc addAttribute:NSForegroundColorAttributeName value:strColor range:[text rangeOfString:str]];
            }
        }
        [button setAttributedTitle:attDesc forState:state];
    }
}

@end

//
//  UIButton+Attribute.h
//  Label颜色测试
//
//  Created by panfei mao on 2017/11/29.
//  Copyright © 2017年 panfei mao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Attribute)

+ (void)attributeWithBUtton:(UIButton *)button title:(NSString *)text titleColor:(NSString *)titleColorStr forState:(UIControlState)state attributes:(NSArray *)attributeStrs attributeColors:(NSArray *)colors;

@end

//
//  UIButton+instance.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/9/18.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "UIButton+instance.h"

@implementation UIButton (instance)

+ (UIButton *)setupButtonWithSuperView:(UIView *)superView withFrame:(CGRect)frame withTitle:(NSString *)title{
    if (!title) {
        title = @"";
    }
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    button.frame = frame;
    [superView addSubview:button];
    return button;
}


+ (UIButton *)setupButtonWithSuperView:(UIView *)superView withTitle:(NSString *)title titleFont:(CGFloat)fontSize corner:(CGFloat)corner withObject:(NSObject *)obj action:(SEL)action{
    if (!title) {
        title = @"";
    }
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    if (fontSize > 0) {
        button.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    } else {
        button.titleLabel.font = [UIFont systemFontOfSize:14];
    }
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    if (corner > 0) {
        button.layer.cornerRadius = corner;
    }
    if (obj && action) {
        [button addTarget:obj action:action forControlEvents:UIControlEventTouchUpInside];
    }
    [superView addSubview:button];
    return button;
}

/** 透明按钮 */
+ (UIButton *)setupButtonWithSuperView:(UIView *)superView withObject:(NSObject *)obj action:(SEL)action{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    if (obj && action) {
        [button addTarget:obj action:action forControlEvents:UIControlEventTouchUpInside];
    }
    button.backgroundColor = [UIColor clearColor];
    [superView addSubview:button];
    return button;
}

/** 指定title里面的字符串的字体颜色 */
+ (UIButton *)setupButtonTitle:(NSString *)title titleColor:(NSString *)color anotherColorTitle:(NSString *)colorTitle anotherColor:(NSString *)anotherColor titleFont:(CGFloat)fontSize withObject:(NSObject *)obj action:(SEL)action{
    if (!title) {
        title = @"";
    }
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    if (color) {
        [button setTitleColor:[UIColor colorWithHexString:color] forState:UIControlStateNormal];
    }
    if (fontSize > 0) {
        button.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    } else {
        button.titleLabel.font = [UIFont systemFontOfSize:14];
    }
    if ([title rangeOfString:colorTitle].location != NSNotFound) {
        NSMutableAttributedString * attService = [[NSMutableAttributedString alloc]initWithString:title];
        [attService addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:anotherColor] range:[title rangeOfString:colorTitle]];
        [button setAttributedTitle:attService forState:UIControlStateNormal];
    }
    if (obj && action) {
        [button addTarget:obj action:action forControlEvents:UIControlEventTouchUpInside];
    }
    return button;

}


//   设置带图片和title的按钮
+ (UIButton *)setupButtonWithImageStr:(NSString *)imageStr title:(NSString *)title titleColor:(UIColor *)color titleFont:(CGFloat)fontSize withObject:(NSObject *)obj action:(SEL)action{
    
    if (!title) {
        title = @"";
    }
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    if (imageStr) {
        [button setImage:[UIImage imageNamed:imageStr] forState:UIControlStateNormal];
    }
    if (color) {
        [button setTitleColor:color forState:UIControlStateNormal];
    }
    if (fontSize > 0) {
        button.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    } else {
        button.titleLabel.font = [UIFont systemFontOfSize:14];
    }
    if (obj && action) {
        [button addTarget:obj action:action forControlEvents:UIControlEventTouchUpInside];
    }
    return button;
}

/** 设置按钮图片和文字间的距离 */
- (void)setupButtonImageTitleMargin:(double)margin
{
    UIEdgeInsets edgeInsets = self.titleEdgeInsets;
    edgeInsets.left = margin / 2.0;
    self.titleEdgeInsets = edgeInsets;
    
    UIEdgeInsets imageEdgeInsets = self.imageEdgeInsets;
    imageEdgeInsets.right = margin / 2.0;
    self.imageEdgeInsets = imageEdgeInsets;
    
}

@end

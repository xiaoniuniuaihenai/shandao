//
//  UIImageView+instance.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/9/18.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "UIImageView+instance.h"

@implementation UIImageView (instance)

+ (UIImageView *)setupImageViewWithImageName:(NSString *)imageName{
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.backgroundColor = [UIColor clearColor];
    imageView.userInteractionEnabled = YES;
    imageView.image = [UIImage imageNamed:imageName];
    //  设置图片显示样式
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    return imageView;
}

+ (UIImageView *)setupImageViewWithImageName:(NSString *)imageName withSuperView:(UIView *)superView{
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.backgroundColor = [UIColor clearColor];
    imageView.userInteractionEnabled = YES;
    imageView.image = [UIImage imageNamed:imageName];
    //  设置图片显示样式
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    [superView addSubview:imageView];
    return imageView;
}
+ (UIImageView *)setupImageViewWithImage:(UIImage *)image withSuperView:(UIView *)superView{
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.backgroundColor = [UIColor clearColor];
    imageView.userInteractionEnabled = YES;
    imageView.image = image;
    //  设置图片显示样式
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    [superView addSubview:imageView];
    return imageView;
}

@end

//
//  UIImageView+OSS.h
//  ZTMXFXunMiaoiOS
//
//  Created by 陈传亮 on 2018/3/20.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (OSS)
/**
 将图缩略成宽度为h，高度按比例处理。
 */
-(void)OSS_setImageWithString:(NSString*)imgStr w:(float)w placeholderImage:(UIImage *)placeholderImage;
/**
 将图缩略成高度为h，宽度按比例处理。
 */
-(void)OSS_setImageWithString:(NSString*)imgStr h:(float)h placeholderImage:(UIImage *)placeholderImage;



@end

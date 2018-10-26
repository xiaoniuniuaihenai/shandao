//
//  UIImageView+OSS.m
//  ZTMXFXunMiaoiOS
//
//  Created by 陈传亮 on 2018/3/20.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "UIImageView+OSS.h"
#import <UIImageView+WebCache.h>
@implementation UIImageView (OSS)


/**
 将图缩略成高度为h，宽度按比例处理。
 */
-(void)OSS_setImageWithString:(NSString*)imgStr h:(float)h placeholderImage:(UIImage *)placeholderImage
{
    imgStr = [NSString stringWithFormat:@"%@?x-oss-process=image/resize,h_%.f", imgStr,h * 2];
    NSURL * url = [NSURL URLWithString:imgStr];
    [self sd_setImageWithURL:url placeholderImage:placeholderImage];
}
/**
 将图缩略成宽度为h，高度按比例处理。
 */
-(void)OSS_setImageWithString:(NSString*)imgStr w:(float)w placeholderImage:(UIImage *)placeholderImage
{
    imgStr = [NSString stringWithFormat:@"%@?x-oss-process=image/resize,w_%.f", imgStr,w * 2];
    NSURL * url = [NSURL URLWithString:imgStr];
    [self sd_setImageWithURL:url placeholderImage:placeholderImage];
}





@end

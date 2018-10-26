//
//  ImageAnimation.h
//  ZhongCaoMei
//
//  Created by 陈传亮 on 15/11/5.
//  Copyright © 2015年 种草没. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class MJRefreshGifHeader, CoutomTabbar;

@interface ImageAnimation : NSObject

///** 即将刷新图片数组*/
//+ (void)getWillBeginAnimationImageArray:(MJRefreshGifHeader *)refreshGifHeader;
///** 正在刷新图片数组*/
//+ (void)getDidBeginAnimationImageArray:(MJRefreshGifHeader *)refreshGifHeader;
///** 结束刷新图片数组*/
//+ (void)getEndAnimationImageArray:(MJRefreshGifHeader *)refreshGifHeader;
///** 刷新图片数组*/
+ (void)refreshImageArray:(MJRefreshGifHeader *)refreshGifHeader;

+ (NSData *)compressOriginalImage:(UIImage *)image toMaxDataSizeKBytes:(CGFloat)size;


@end

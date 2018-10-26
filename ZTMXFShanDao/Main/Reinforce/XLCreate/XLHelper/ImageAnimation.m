//
//  ImageAnimation.m
//  ZhongCaoMei
//
//  Created by 陈传亮 on 15/11/5.
//  Copyright © 2015年 种草没. All rights reserved.
//

#import "ImageAnimation.h"
#import <MJRefreshGifHeader.h>
#import <UIKit/UIKit.h>
@implementation ImageAnimation

+ (void)refreshImageArray:(MJRefreshGifHeader *)refreshGifHeader
{
    [self getDidBeginAnimationImageArray:refreshGifHeader];
    [self getEndAnimationImageArray:refreshGifHeader];
    [self getWillBeginAnimationImageArray:refreshGifHeader];
    refreshGifHeader.lastUpdatedTimeLabel.hidden = YES;
//    [refreshGifHeader setTitle:@"下拉可以刷新   " forState:MJRefreshStateIdle];
//    [refreshGifHeader setTitle:@"松开即可刷新   " forState:MJRefreshStatePulling];
//    [refreshGifHeader setTitle:@"正在努力加载..." forState:MJRefreshStateRefreshing];
//    refreshGifHeader.stateLabel.textColor = COLOR_SRT(@"8b8b8b");
//    refreshGifHeader.stateLabel.font = FONT_LIGHT(14);
    //// 隐藏状态
    refreshGifHeader.stateLabel.hidden = YES;
//    refreshGifHeader.ignoredScrollViewContentInsetTop = -10;
}


+ (void)getWillBeginAnimationImageArray:(MJRefreshGifHeader *)refreshGifHeader
{
    NSMutableArray * array = [NSMutableArray array];
    for (int i = 4 ; i < 5; i++) {
        NSString * str = @"钱币0";
        UIImage * image = [UIImage imageNamed:[NSString stringWithFormat:@"%@%d.png", str, i]];
        [array addObject:image];
    }
    [refreshGifHeader setImages:[NSArray arrayWithArray:array] duration:2 forState:MJRefreshStatePulling];
}



+ (void )getEndAnimationImageArray:(MJRefreshGifHeader *)refreshGifHeader
{
    NSMutableArray * array = [NSMutableArray array];
    for (int i = 0 ; i < 5; i++) {
        NSString * str = @"钱币0";
        UIImage * image = [UIImage imageNamed:[NSString stringWithFormat:@"%@%d.png", str, i]];
        [array addObject:image];
    }
    [refreshGifHeader setImages:[NSArray arrayWithArray:array] forState:MJRefreshStateRefreshing];
}


+ (NSData *)compressOriginalImage:(UIImage *)image toMaxDataSizeKBytes:(CGFloat)size
{
    NSData * data = UIImageJPEGRepresentation(image, 1.0);
    CGFloat dataKBytes = data.length/1000.0;
    CGFloat maxQuality = 0.9f;
    CGFloat lastData = dataKBytes;
    while (dataKBytes > size && maxQuality > 0.01f) {
        maxQuality = maxQuality - 0.01f;
        data = UIImageJPEGRepresentation(image, maxQuality);
        dataKBytes = data.length / 1000.0;
        if (lastData == dataKBytes) {
            break;
        }else{
            lastData = dataKBytes;
        }
    }
    return data;
}
+ (void)getDidBeginAnimationImageArray:(MJRefreshGifHeader *)refreshGifHeader
{
    NSMutableArray * array = [NSMutableArray array];
    for (int i = 4 ; i < 5; i++) {
        NSString * str = @"钱币0";
        UIImage * image = [UIImage imageNamed:[NSString stringWithFormat:@"%@%d.png", str, i]];
        [array addObject:image];
    }
    [refreshGifHeader setImages:[NSArray arrayWithArray:array] forState:MJRefreshStateIdle];
}
@end

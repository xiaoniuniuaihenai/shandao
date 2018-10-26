//
//  BannerGoodsFrame.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2018/1/13.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "ZTMXFBannerGoodsFrame.h"
#import "HomePageMallModel.h"

@implementation ZTMXFBannerGoodsFrame



- (void)setBannerGoodsModel:(MallBannerGoodsModel *)bannerGoodsModel{
    _bannerGoodsModel = bannerGoodsModel;
    
    // cell的宽度
    CGFloat cellWidth = [UIScreen mainScreen].bounds.size.width;

    CGFloat leftMargin = AdaptedWidth(12.0);
    
    /** title */
    self.titleCellViewFrame = CGRectMake(0.0, 0.0, cellWidth, AdaptedHeight(50.0));
    /** 轮播图 */
    if (_bannerGoodsModel.bannerList.count > 0) {
        CGFloat cycleScrollViewW = (cellWidth - leftMargin * 2);
        CGFloat cycleScrollViewH = 135.0 / 351.0 * cycleScrollViewW;
        self.cycleScrollViewFrame = CGRectMake(leftMargin, CGRectGetMaxY(self.titleCellViewFrame), cycleScrollViewW, cycleScrollViewH);
    } else {
        self.cycleScrollViewFrame = CGRectMake(leftMargin, CGRectGetMaxY(self.titleCellViewFrame), (cellWidth - leftMargin * 2), 0.0);
    }
    /** 商品CollectionView */
    if (_bannerGoodsModel.goodsList.count > 0) {
        NSInteger goodsCount = _bannerGoodsModel.goodsList.count;
        if (goodsCount == 1) {
            CGFloat goodsImageWidth = Main_Screen_Width - leftMargin * 2;
            CGFloat goodsImageHeight = goodsImageWidth * 135.0 / 351.0;
            CGFloat goodsDescribeHeight = AdaptedHeight(52.0);
            self.goodsCollectionViewFrame = CGRectMake(0.0, CGRectGetMaxY(self.cycleScrollViewFrame) + AdaptedWidth(2.0), cellWidth, goodsImageHeight + goodsDescribeHeight);
        } else if (goodsCount == 2) {
            CGFloat goodsImageWidth = (Main_Screen_Width - leftMargin * 2 - AdaptedWidth(2.0)) / 2.0;
            CGFloat goodsImageHeight = goodsImageWidth * 138.0 / 175.0;
            CGFloat goodsDescribeHeight = AdaptedHeight(52.0);
            self.goodsCollectionViewFrame = CGRectMake(0.0, CGRectGetMaxY(self.cycleScrollViewFrame) + AdaptedWidth(2.0), cellWidth, goodsImageHeight + goodsDescribeHeight);
        } else if (goodsCount == 3) {
            CGFloat goodsImageWidth = (Main_Screen_Width - leftMargin * 2 - AdaptedWidth(30) * 2) / 3.0;
            CGFloat goodsImageHeight = goodsImageWidth;
            CGFloat goodsDescribeHeight = AdaptedHeight(40.0);
            self.goodsCollectionViewFrame = CGRectMake(0.0, CGRectGetMaxY(self.cycleScrollViewFrame) + AdaptedWidth(2.0), cellWidth, goodsImageHeight + goodsDescribeHeight);
        } else if (goodsCount >= 4) {
            CGFloat goodsImageWidth = (Main_Screen_Width - leftMargin * 2 - AdaptedWidth(30) * 2) / 3.0;
            CGFloat goodsImageHeight = goodsImageWidth;
            CGFloat goodsDescribeHeight = AdaptedHeight(40.0);
            self.goodsCollectionViewFrame = CGRectMake(0.0, CGRectGetMaxY(self.cycleScrollViewFrame) + AdaptedWidth(2.0), cellWidth, goodsImageHeight + goodsDescribeHeight);
        }
    } else {
        self.goodsCollectionViewFrame = CGRectMake(0.0, CGRectGetMaxY(self.cycleScrollViewFrame), cellWidth, 0.0);
    }
    /** 间隔view */
    self.gapViewFrame = CGRectMake(0.0, CGRectGetMaxY(self.goodsCollectionViewFrame) + AdaptedHeight(16.0), cellWidth, AdaptedHeight(10.0));
    
    self.cellHeight = CGRectGetMaxY(self.gapViewFrame);
}

@end

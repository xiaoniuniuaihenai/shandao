//
//  GoodRemarkFrame.m
//  Himalaya
//
//  Created by 杨鹏 on 16/8/1.
//  Copyright © 2016年 ala. All rights reserved.
//

#import "GoodRemarkFrame.h"
#import "GoodRemark.h"
#import "RemarkPhoto.h"
#import "GoodsRemarkPhotosView.h"

@implementation GoodRemarkFrame

- (void)setGoodRemark:(GoodRemark *)goodRemark
{
    _goodRemark = goodRemark;
    
    /** 头像 */
    CGFloat iconImageViewX = 0.0;
    CGFloat iconImageViewY = 0.0;
    CGFloat iconImageViewW = 0.0;
    CGFloat iconImageViewH = 0.0;
    self.iconImageViewF = CGRectMake(iconImageViewX, iconImageViewY, iconImageViewW, iconImageViewH);
    
    /** 用户名 */
    CGFloat userNameLabelX = CGRectGetMaxX(self.iconImageViewF) + 15.0;
    CGFloat userNameLabelY = CGRectGetMinY(self.iconImageViewF) + 12.0;
    CGFloat userNameLabelW = 260.0;
    CGFloat userNameLabelH = 20.0;
    self.userNameLabelF = CGRectMake(userNameLabelX, userNameLabelY, userNameLabelW, userNameLabelH);

    /** 时间 */
    CGFloat dateLabelX = CGRectGetMinX(self.userNameLabelF);
    CGFloat dateLabelY = CGRectGetMaxY(self.userNameLabelF) + 8.0;
    CGFloat dateLabelW = SCREEN_WIDTH - 30.0;
    CGFloat dateLabelH = 16.0;
    self.dateLabelF = CGRectMake(dateLabelX, dateLabelY, dateLabelW, dateLabelH);

    /** 评价详情 */
    CGFloat detailRemarkLabelX = CGRectGetMinX(self.userNameLabelF);
    CGFloat detailRemarkLabelY = CGRectGetMaxY(self.dateLabelF) + 10.0;
    CGFloat detailRemarkLabelW = SCREEN_WIDTH - 30.0;
    CGFloat detailRemarkLabelH = [_goodRemark.content sizeWithFont:[UIFont systemFontOfSize:13] maxW:(SCREEN_WIDTH - 30.0)].height;
    self.detailRemarkLabelF = CGRectMake(detailRemarkLabelX, detailRemarkLabelY, detailRemarkLabelW, detailRemarkLabelH);

    /** 评价图片 */
    CGFloat photoViewH = 0.0;
    
    NSInteger photoCount = 0.0;
    if (goodRemark.rateDetail.count > 0) {
        NSMutableArray *imageUrlsArray = [NSMutableArray array];
        for (RemarkPhoto *photo in goodRemark.rateDetail) {
            if (photo.picUrl && photo.picUrl.length > 0) {
                [imageUrlsArray addObject:photo.picUrl];
            }
        }
        
        NSMutableArray *filterImageArray = [NSMutableArray array];
        for (NSString *imageUrl in imageUrlsArray) {
            if (imageUrl.length > 2) {
                [filterImageArray addObject:imageUrl];
            }
        }
        if (filterImageArray.count > 0) {
            photoCount = filterImageArray.count;
        } else {
            photoCount = 0;
        }
    } else {
        photoCount = 0;
    }
    
    if (photoCount > 0) {
        CGFloat photosViewX = 15.0;
        CGFloat photosViewY = CGRectGetMaxY(self.detailRemarkLabelF) + 12.0;
        CGFloat photosViewW = SCREEN_WIDTH - 30.0;
        CGFloat photosViewH = [GoodsRemarkPhotosView sizeWithCount:photoCount].height;
        self.photosViewF = CGRectMake(photosViewX, photosViewY, photosViewW, photosViewH);
        
        photoViewH = CGRectGetMaxY(self.photosViewF) + 10.0;
    } else {
        photoViewH = CGRectGetMaxY(self.detailRemarkLabelF) + 10.0;
    }
    
    /** 细线 */
    CGFloat lineViewX = 0.0;
    CGFloat lineViewY = photoViewH - 0.5;
    CGFloat lineViewW = SCREEN_WIDTH;
    CGFloat lineViewH = 0.5;
    self.lineViewF = CGRectMake(lineViewX, lineViewY, lineViewW, lineViewH);
    
    self.cellHeight = photoViewH;
}

@end

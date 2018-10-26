//
//  MallGoodsStyleOneCell.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2018/1/13.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZTMXFBannerGoodsFrame;
@class MallBannerModel;
@class MallGoodsModel;
@class MallBannerGoodsModel;

@protocol MallGoodsStyleOneCellDelegate <NSObject>

/** 点击banner跳转 */
- (void)mallGoodsStyleOneCellClickBanner:(MallBannerModel *)bannerModel cell:(id)cell;
/** 点击商品 */
- (void)mallGoodsStyleOneCellClickGoods:(MallGoodsModel *)goodsModel;

@end

@interface MallGoodsStyleOneCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) ZTMXFBannerGoodsFrame  *bannerGoodsFrame;
@property (nonatomic, strong) MallBannerGoodsModel *bannerGoodsModel;

@property (nonatomic, weak) id<MallGoodsStyleOneCellDelegate> delegate;
@end

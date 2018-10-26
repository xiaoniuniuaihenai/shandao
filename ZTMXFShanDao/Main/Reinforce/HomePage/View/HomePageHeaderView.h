//
//  HomePageHeaderView.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/12/7.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MallBannerModel;
@class MallCategoryModel;

@protocol HomePageHeaderViewDelegate <NSObject>

/** 点击轮播图 */
- (void)homePageHeaderViewClickBannerImage:(MallBannerModel *)bannerModel;
/** 点击分类 */
- (void)homePageHeaderViewClickCategory:(MallCategoryModel *)categoryModel;

@end

@interface HomePageHeaderView : UIView

/** 轮播图数组 */
@property (nonatomic, strong) NSArray *bannerImageArray;
/** 分类菜单项数组 */
@property (nonatomic, strong) NSArray *categoryArray;
/** 活动推广轮播图数组 */
@property (nonatomic, strong) NSArray *promotionImageArray;
/** 分类菜单背景色 */
@property (nonatomic, copy) NSString *categoryBgColor;
/** 分类菜单字体颜色 */
@property (nonatomic, copy) NSString *categoryFontColor;


@property (nonatomic, weak) id<HomePageHeaderViewDelegate> delegate;

@end

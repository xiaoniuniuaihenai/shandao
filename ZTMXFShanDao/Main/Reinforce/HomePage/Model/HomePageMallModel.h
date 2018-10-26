//
//  HomePageMallModel.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2018/1/12.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomePageMallModel : NSObject

/** banner 数组 */
@property (nonatomic, strong) NSArray *bannerList;
/** 分类数组 */
@property (nonatomic, strong) NSArray *categoryList;
/** 活动推广banner 数组 */
@property (nonatomic, strong) NSArray *bannerListTwo;
/** banner+商品 */
@property (nonatomic, strong) NSArray *bannerGoodsList;
/** 分类栏目背景色 */
@property (nonatomic, copy) NSString *categoryBgColor;
/** 分类栏目字体颜色 */
@property (nonatomic, copy) NSString *categoryFontColor;

@end

@interface MallBannerModel : NSObject
/** 1：h5；2:类目(专区)；3:商品;4:原生页面key; */
@property (nonatomic, assign) NSInteger type;
/** 图片地址 */
@property (nonatomic, strong) NSString *image;
/** 跳转类型：为1时：h5跳转链接；为2:类目id；为3是：商品id跳转类型：为1时：h5跳转链接；为2:类目id；为3是：商品id；为4是：app内页（eg：MOBILE,代表跳到手机充值） */
@property (nonatomic, copy) NSString *desc;

@end

@interface MallCategoryModel : NSObject
/** 分类专区id（用于跳转分类id */
@property (nonatomic, copy) NSString *categoryId;
/** 分类Icon */
@property (nonatomic, copy) NSString *categoryIcon;
/** 分类名称 */
@property (nonatomic, copy) NSString *name;
/** 分类字体颜色 */
@property (nonatomic, copy) NSString *categoryFontColor;

@end

@interface MallBannerGoodsModel : NSObject
/** 模块名字 */
@property (nonatomic, copy) NSString *name;
/** banner 数组 */
@property (nonatomic, strong) NSArray *bannerList;
/** 商品数组 */
@property (nonatomic, strong) NSArray *goodsList;

@end

@interface MallGoodsModel : NSObject

/** 商品Id */
@property (nonatomic, assign) long goodsId;
/** 商品图标 */
@property (nonatomic, copy) NSString *goodsIcon;
/** 商品名称 */
@property (nonatomic, copy) NSString *name;
/** 商品标题简介 */
@property (nonatomic, copy) NSString *remark;
/** 最低月供 */
@property (nonatomic, assign) double monthPay;
/** 最低月供对应的期数 */
@property (nonatomic, assign) NSInteger nper;

/** 商品个数 */
@property (nonatomic, assign) NSInteger goodsCount;

@end



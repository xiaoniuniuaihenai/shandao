//
//  CategoryListModel.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2018/1/10.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CategoryListModel : NSObject

/** title */
@property (nonatomic, copy) NSString *title;

/** 轮播数组 */
@property (nonatomic, strong) NSArray *bannerList;
/** 分区数组 */
@property (nonatomic, strong) NSArray *categoryList;

@end


@interface CategoryBannerModel : NSObject
/** 内容类型 */
@property (nonatomic, copy) NSString *type;
/** 图片地址 */
@property (nonatomic, copy) NSString *image;
/** type为1时：h5条转链接；type为2:类目id；type为3是：商品详情{rid:"商品id",name:"商品名",price"价格"} */
@property (nonatomic, copy) NSString *desc;

@end

@interface CategoryGoodsModel : NSObject

@property (nonatomic, strong) NSArray *goodsList;

@end

@interface CategoryGoodsInfoModel : NSObject
/** 商品id */
@property (nonatomic, assign) long goodsId;
/** 商品图片 */
@property (nonatomic, copy) NSString *goodsIcon;
/** 商品标题简介 */
@property (nonatomic, copy) NSString *title;
/** 最低月供 */
@property (nonatomic, assign) double monthPay;
/** 最低月供对应的期数 */
@property (nonatomic, assign) NSInteger nper;

@end


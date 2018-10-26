//
//  ApplyRefundGoodsInfoModel.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2018/1/14.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ApplyRefundGoodsInfoModel : NSObject
/** 商品名称 */
@property (nonatomic, copy) NSString *title;
/** 商品图片 */
@property (nonatomic, copy) NSString *goodsIcon;
/** 商品规格 */
@property (nonatomic, copy) NSString *propertyValueNames;
/** 商品个数 */
@property (nonatomic, assign) NSInteger count;

@end

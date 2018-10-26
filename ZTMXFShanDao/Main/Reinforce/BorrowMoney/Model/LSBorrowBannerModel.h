//
//  LSBorrowBannerModel.h
//  ZTMXFXunMiaoiOS
//
//  Created by 朱吉达 on 2017/9/23.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSBorrowBannerModel : NSObject

/**
 图片地址
 */
@property (nonatomic,copy) NSString * imageUrl;

/**
 第二页名称
 */
@property (nonatomic,copy) NSString * titleName;

/**
 分类的值类型
 跳转普通H5地址, 如H5_URL,
 */
@property (nonatomic,copy) NSString * type;
/**
 type 为H5_URL 则为H5链接地址 如http://51fanbei.com
 如果value_1 为GOODS_ID则为商品id, 如23
 */
@property (nonatomic,copy) NSString * content;

/**
 是否需要登录才能点击，1 是， 0否
 */
@property (nonatomic,assign)  NSInteger isNeedLogin;

/**
 1.3 版本 banner 色值
 */
@property (nonatomic,copy) NSString * background;

@end

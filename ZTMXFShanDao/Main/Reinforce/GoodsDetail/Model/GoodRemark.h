//
//  GoodRemark.h
//  Himalaya
//
//  Created by 杨鹏 on 16/8/1.
//  Copyright © 2016年 ala. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoodRemark : NSObject

/** 评论昵称 */
@property (nonatomic, copy) NSString    *userName;
/** 评论时间 */
@property (nonatomic, assign) long long rateTime;
/** 商品规格 */
@property (nonatomic, copy) NSString    *auctionSku;
/** 评论内容 */
@property (nonatomic, copy) NSString    *content;

/** 评论图片数组 */
@property (nonatomic, strong) NSArray   *rateDetail;

@end

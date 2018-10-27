//
//  ZTMXFChooseGoodsViewController.h
//  ZTMXFXunMiaoiOS
//
//  Created by 陈传亮 on 2018/4/17.
//  Copyright © 2018年 LSCredit. All rights reserved.
//  选择商品

#import "ZTMXFTableViewController.h"
@class  GoodsInfoModel;

@interface ShanDaoChooseGoodsViewController : ZTMXFTableViewController

@property (nonatomic, copy)NSArray * goodsDtoList;

@property (nonatomic, copy)void(^clickCell)(GoodsInfoModel * goodsInfoModel);


@end

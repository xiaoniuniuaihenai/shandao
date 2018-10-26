//
//  GoodsDetailImageTableViewCell.h
//  ALAFanBei
//
//  Created by yangpenghua on 2017/9/2.
//  Copyright © 2017年 阿拉丁. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GoodsDetailImageInfoModel;

@interface GoodsDetailImageTableViewCell : UITableViewCell

@property (nonatomic, strong) GoodsDetailImageInfoModel *goodsDetailImageInfoModel;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) UIImageView *goodsDetailImageView;

@end

//
//  ZTMXFClassificationCell.h
//  ZTMXFXunMiaoiOS
//
//  Created by 陈传亮 on 2018/3/23.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CategoryGoodsInfoModel;
@interface ZTMXFClassificationCell : UICollectionViewCell


@property (nonatomic, strong)UIImageView * imgView;

@property (nonatomic, strong)UILabel * titleLabel;


@property (nonatomic, strong)CategoryGoodsInfoModel * categoryGoodsInfoModel;


@end

//
//  CategoryCollectionViewCell.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2018/1/18.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MallCategoryModel;

@interface CategoryCollectionViewCell : UICollectionViewCell
/** 分类Model */
@property (nonatomic, strong) MallCategoryModel *mallCategoryModel;

@end

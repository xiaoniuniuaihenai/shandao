//
//  GoodsPropertyCollectionViewLayout.h
//  Himalaya
//
//  Created by 杨鹏 on 16/8/17.
//  Copyright © 2016年 ala. All rights reserved.
//

#import <UIKit/UIKit.h>

#define GoodsPropertyCollectionViewHeader  @"GP_HeadView"
#define GoodsPropertyCollectionViewHeaderReuseIdentifier  @"HeadView"
#define GoodsPropertyCollectionViewFooter  @"GP_FootView"
#define GoodsPropertyCollectionViewFooterReuseIdentifier  @"FooterView"
#define GoodsPropertyCollectionViewFooterLineReuseIdentifier  @"FooterLineView"

#define collectionHeaderH           44.0
#define collectionFooterH           60.0

@class GoodsPropertyCollectionViewLayout;

@interface GoodsPropertyCollectionViewLayout : UICollectionViewFlowLayout

@property (assign, nonatomic) CGFloat startY;//记录开始的Y
@property (assign, nonatomic) CGFloat topAndBottomDustance;//cell 到顶部 底部的间距
@property (assign, nonatomic) CGFloat headerViewHeight;//头视图的高度
@property (assign, nonatomic) CGFloat footViewHeight;//尾视图的高度

@end

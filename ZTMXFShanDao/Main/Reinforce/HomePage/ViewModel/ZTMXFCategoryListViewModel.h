//
//  CategoryListViewModel.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2018/1/10.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CategoryListModel;

@protocol CategoryListViewModelDelegate <NSObject>

/** 获取商品分区数据成功 */
- (void)requestGoodsCategoryListSuccess:(CategoryListModel *)categoryListModel pageNumber:(NSInteger)pageNumber;
/** 获取商品分区数据失败 */
- (void)requestGoodsCategoryListFailure;

@end

@interface ZTMXFCategoryListViewModel : NSObject

/** 获取商品分区列表 */
- (void)requestGoodsCategoryListWithCategoryId:(NSString *)categoryId pageNumber:(NSInteger)pageNumber showLoad:(BOOL)showLoad;

@property (nonatomic, weak) id<CategoryListViewModelDelegate> delegate;

@end

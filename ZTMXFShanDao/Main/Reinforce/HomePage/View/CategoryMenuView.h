//
//  CategoryMenuView.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2018/1/13.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MallCategoryModel;

@protocol CategoryMenuVeiwDelegate <NSObject>
/** 点击分类 */
- (void)categoryMenuViewClickCategory:(MallCategoryModel *)categoryModel;
@end

@interface CategoryMenuView : UIView
/** 分类数组 */
@property (nonatomic, strong) NSArray *categoryArray;

@property (nonatomic, weak) id<CategoryMenuVeiwDelegate> delegate;

@end

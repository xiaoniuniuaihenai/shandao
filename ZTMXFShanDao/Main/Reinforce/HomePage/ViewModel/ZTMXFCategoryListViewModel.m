//
//  CategoryListViewModel.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2018/1/10.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "ZTMXFCategoryListViewModel.h"
#import "CategoryListApi.h"
#import "CategoryListModel.h"

@implementation ZTMXFCategoryListViewModel



/** 获取商品分区列表 */
- (void)requestGoodsCategoryListWithCategoryId:(NSString *)categoryId pageNumber:(NSInteger)pageNumber showLoad:(BOOL)showLoad{
    if (showLoad) {
        [SVProgressHUD showLoading];
    }
    CategoryListApi *categoryListApi = [[CategoryListApi alloc] initWithCategoryId:categoryId pageNumber:pageNumber];
    [categoryListApi requestWithSuccess:^(NSDictionary *responseDict) {
        [SVProgressHUD dismiss];
        NSString * codeStr = [responseDict[@"code"]description];
        if ([codeStr isEqualToString:@"1000"]) {
            CategoryListModel *categoryListModel = [CategoryListModel mj_objectWithKeyValues:responseDict[@"data"]];
            if (self.delegate && [self.delegate respondsToSelector:@selector(requestGoodsCategoryListSuccess:pageNumber:)]) {
                [self.delegate requestGoodsCategoryListSuccess:categoryListModel pageNumber:pageNumber];
                return ;
            }
        }
        if (self.delegate && [self.delegate respondsToSelector:@selector(requestGoodsCategoryListFailure)]) {
            [self.delegate requestGoodsCategoryListFailure];
        }
    } failure:^(__kindof YTKBaseRequest *request) {
        [SVProgressHUD dismiss];
        if (self.delegate && [self.delegate respondsToSelector:@selector(requestGoodsCategoryListFailure)]) {
            [self.delegate requestGoodsCategoryListFailure];
        }
    }];
}

@end

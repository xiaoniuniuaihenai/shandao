//
//  LSBorrowMoneyViewModel.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/11/15.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LSBorrowHomeInfoModel;
@class LSLoanSupermarketLabelModel;

@protocol LSBorrowMoneyViewModelDelegate<NSObject>
@optional
/** 成功获取借钱首页数据 */
- (void)requestBorrowMoneyViewSuccess:(LSBorrowHomeInfoModel *)homeInfoModel;
/** 获取借钱首页数据失败 */
- (void)requestBorrowMoneyViewFailure;

/** 成功获取借贷超市类型列表数据 */
- (void)requestBorrowMoneyRecommendAliasSuccess:(NSArray *)aliasArray findUrl:(NSString *)findUrl;
/** 根据标签成功获取借贷超市全部列表数据 */
- (void)requestBorrowMoneyMarketListsSuccess:(NSDictionary *)marketListDict;

/** 获取骨头状态 */
- (void)requestAppReviewStateSuccess:(NSInteger)reviewState;
/** 获取骨头状态失败 */
- (void)requestAppReviewStateFailure;

@end

@interface LSBorrowMoneyViewModel : NSObject


@property (nonatomic, assign)NSInteger sortingType;


@property (nonatomic, weak) id<LSBorrowMoneyViewModelDelegate> delegate;

//  借钱首页页面数据请求
- (void)requestBorrowMoneyViewData;

//  升级接口请求
- (void)requestUpdateVersionApi;

//  获取骨头状态接口
- (void)requestAppReviewState;

// 获取借贷超市类别
- (void)requestBorrowMoneyRecommendAliasList;

// 获取所有的借贷超市列表
- (void)requestBorrowMoneyAllMarketsDataWithAlias:(NSArray *)aliasList;

// 进入点击进入借贷超市埋点
- (void)requestBorrowMoneyRecommendListEnterWithNumber:(NSString *)number;

// 点击获取确认借钱页面信息跳转到借钱页面
- (void)requestConfirmBorrowMoneyInfoWithBorrowDays:(NSString *)borrowDays amount:(NSString *)amount borrowType:(NSString *)borrowType currentController:(UIViewController *)controller;


/**
  根据审核状态修改借-钱tabBar
  */
+ (void)changeTabBarTextAndImage;

@end

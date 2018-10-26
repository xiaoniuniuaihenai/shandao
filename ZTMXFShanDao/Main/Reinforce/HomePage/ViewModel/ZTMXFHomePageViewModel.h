//
//  HomePageViewModel.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2018/1/3.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HomePageMallModel;

@protocol HomePageViewModelDelegate <NSObject>
/** 请求首页接口数据成功 */
- (void)requestHomePageSuccess:(HomePageMallModel *)homePageMallModel;
/** 请求首页接口失败 */
- (void)requestHomePageFailure;

@end

@interface ZTMXFHomePageViewModel : NSObject
//  升级接口请求
- (void)requestUpdateVersionApi;

/** 获取首页数据 */
- (void)requestHomePageData;

@property (nonatomic, weak) id<HomePageViewModelDelegate> delegate;

@end

//
//  XLLoanMarketStatisticalApi.m
//  YWLTMeiQiiOS
//
//  Created by 凉 on 2018/7/31.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "XLLoanMarketStatisticalApi.h"
@interface XLLoanMarketStatisticalApi ()

/**
贷超位置
 */
@property (nonatomic, copy)NSString * recordsType;
/**
 贷超编号
 */
@property (nonatomic, copy)NSString * lsmNo;


@end
@implementation XLLoanMarketStatisticalApi

/**
 
 * APP_LIST(1, "app","APP端借款超市列表访问"),
 * APP_BNANNER(2,"appLoanBanner","APP端借款超市banner访问"),
 * H5_LOAN_BANNER(3,"h5LoanBanner","H5借贷超市轮播"),
 * H5(4,"h5","h5普通列表"),
 * WX(5,"wx","微信访问借贷超市"),
 * AUTH_NO_PASS(6,"authNoPass","h5审核未通过"),
 * GOOD_RECOMMEND(7,"goodRecommend","优质平台推荐"),
 * DETAIL_PAGE(8,"detailPage","详情页访问"),
 * ADVERTISEMENT(9,"ad","广告位");
 
 
 */
- (instancetype)initWithRecordsType:(NSString *)recordsType lsmNo:(NSString *)lsmNo
{
    self = [super init];
    if (self) {
        _recordsType = recordsType;
        _lsmNo = lsmNo;
    }
    return self;
}



//- (NSString *)baseUrl
//{
//    return k_statisticalURL;
//}

- (NSString *)requestUrl
{
    return @"/loanMarket/loanmarketEventTracking";
}


-(id)requestArgument
{
    NSMutableDictionary * dic = [[NSMutableDictionary alloc]init];
    [dic setValue:_recordsType forKey:@"linkType"];
    [dic setValue:_lsmNo forKey:@"lsmNo"];

    return dic;
}

- (void)loanMarketStatisticalWithRecordsType:(NSString *)recordsType lsmNo:(NSString *)lsmNo
{
//    [self.requestArgument setValue:_lsmNo forKey:@"lsmNo"];
//    [self.requestArgument setValue:_recordsType forKey:@"linkType"];
    XLLoanMarketStatisticalApi * api = [[XLLoanMarketStatisticalApi alloc] initWithRecordsType:recordsType lsmNo:lsmNo];
    [api requestWithSuccess:^(NSDictionary *responseDict) {
        
    } failure:^(__kindof YTKBaseRequest *request) {
        
    }];
}



@end

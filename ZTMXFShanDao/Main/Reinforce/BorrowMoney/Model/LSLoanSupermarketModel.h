//
//  LSLoanSupermarketModel.h
//  ALAFanBei
//
//  Created by Try on 2017/6/5.
//  Copyright © 2017年 讯秒. All rights reserved.
//  借款超市

#import <Foundation/Foundation.h>

@interface LSLoanSupermarketModel : NSObject
/** 160新增 贷超跳转链接*/
@property (nonatomic,copy) NSString* originLinkUrl;
/** 编号*/
@property (nonatomic,copy) NSString* lsmNo;
/** 图标*/
@property (nonatomic,copy) NSString* iconUrl;
/** 名称*/
@property (nonatomic,copy) NSString* lsmName;
/** 简介*/
@property (nonatomic,copy) NSString* lsmIntro;
/** 跳转链接*/
@property (nonatomic,copy) NSString* linkUrl;
/** 标签（暂时设计定三种 ）activity：代表活动 hot：代表热门newest：代表最新*/
@property (nonatomic,copy) NSString* label;
@property (nonatomic,copy) NSString * marketPoint;// 营销类别，逗号分隔
@property (nonatomic,copy) NSString * marketOne;
@property (nonatomic,copy) NSString * marketTwo;

/** */
@property (nonatomic, assign) NSInteger iconLabel;// 左上角标签
@property (nonatomic, strong) NSArray *marketLabel;// 右边标签
/**
最高额度
 */
//@property (nonatomic,assign) double  maxLoanAmount;
@property (nonatomic,copy) NSString *  maxLoanAmountStr;

/**
 利率
 */
//@property (nonatomic,assign) double  interestRate;
@property (nonatomic,copy) NSString *  interestRateStr;

/**
 周期
 */
//@property (nonatomic,assign) double  cycleDate;
@property (nonatomic,copy) NSString *  cycleDateStr;





@end

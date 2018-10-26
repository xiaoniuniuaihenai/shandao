//
//  LSRepaymentCouponListApi.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/9/26.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "LSRepaymentCouponListApi.h"

@interface LSRepaymentCouponListApi ()

@property (nonatomic, copy) NSString *borrowId;
@property (nonatomic, copy) NSString *repaymentAmount;
@property (nonatomic, assign) NSInteger pageNo;

@end


@implementation LSRepaymentCouponListApi

- (instancetype)initWithBorrowId:(NSString *)borrowId repaymentAmount:(NSString *)repaymentAmount pageNum:(NSInteger)pageNo{
    self = [super init];
    if (self) {
        _borrowId = borrowId;
        _repaymentAmount = repaymentAmount;
        _pageNo = pageNo;
    }
    return self;
}

-(NSString * )requestUrl{
    return @"/repayCash/getRepaymentCouponList";
}

-(id)requestArgument{
    NSMutableDictionary * paramDict = [[NSMutableDictionary alloc]init];
    [paramDict setValue:_borrowId forKey:@"borrowId"];
    [paramDict setValue:_repaymentAmount forKey:@"repaymentAmount"];
    [paramDict setValue:[NSString stringWithFormat:@"%ld", _pageNo] forKey:@"pageNo"];
    return paramDict;
}


@end

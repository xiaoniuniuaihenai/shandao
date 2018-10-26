//
//  LSUploadPayProofApi.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/10/23.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "LSUploadPayProofApi.h"

@interface LSUploadPayProofApi ()

@property (nonatomic, copy) NSString *borrowId;
@property (nonatomic, copy) NSString *repaymentAmount;
@property (nonatomic, copy) NSString *orderNo;

@end

@implementation LSUploadPayProofApi

- (instancetype)initWithBorrowId:(NSString *)borrowId repaymentAmount:(NSString *)repaymentAmount orderNumber:(NSString *)orderNo{
    self = [super init];
    if (self) {
        _borrowId = borrowId;
        _repaymentAmount = repaymentAmount;
        _orderNo = orderNo;
    }
    return self;
}

-(NSString * )requestUrl{
    return @"/borrowCash/commitOfflineRepayInfoV2";
}

-(id)requestArgument{
    NSMutableDictionary * paramDict = [[NSMutableDictionary alloc]init];
    [paramDict setValue:_borrowId forKey:@"borrowId"];
    [paramDict setValue:_repaymentAmount forKey:@"amount"];
    [paramDict setValue:_orderNo forKey:@"orderNo"];
    return paramDict;
}


@end

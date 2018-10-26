//
//  LSUploadPayOldApi.m
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2018/1/3.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "LSUploadPayOldApi.h"

@interface LSUploadPayOldApi ()

@property (nonatomic, copy) NSString *borrowId;
@property (nonatomic, copy) NSString *repaymentAmount;
@property (nonatomic, copy) NSString *proofUrl;

@end

@implementation LSUploadPayOldApi

- (instancetype)initWithBorrowId:(NSString *)borrowId repaymentAmount:(NSString *)repaymentAmount proofUrl:(NSString *)proofUrl{
    self = [super init];
    if (self) {
        _borrowId = borrowId;
        _repaymentAmount = repaymentAmount;
        _proofUrl = proofUrl;
    }
    return self;
}

-(NSString * )requestUrl{
    return @"/borrowCash/commitOfflineRepayInfo";
}

-(id)requestArgument{
    NSMutableDictionary * paramDict = [[NSMutableDictionary alloc]init];
    [paramDict setValue:_borrowId forKey:@"borrowId"];
    [paramDict setValue:_repaymentAmount forKey:@"amount"];
    [paramDict setValue:_proofUrl forKey:@"url"];
    return paramDict;
}

@end

//
//  WhiteLoanInfoModel.m
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2018/1/12.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "WhiteLoanInfoModel.h"
#import "MallBillInfoModel.h"

@implementation WhiteLoanInfoModel



+ (NSDictionary *)mj_objectClassInArray{
    return @{@"billList": [MallBillListModel class]};
}

@end

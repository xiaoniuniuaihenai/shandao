//
//  LSLoanSupermarketModel.m
//  ALAFanBei
//
//  Created by Try on 2017/6/5.
//  Copyright © 2017年 讯秒. All rights reserved.
//

#import "LSLoanSupermarketModel.h"

@implementation LSLoanSupermarketModel
-(void)setMarketPoint:(NSString *)marketPoint{
    _marketPoint = marketPoint;
    NSArray * arrComp = [_marketPoint componentsSeparatedByString:@","];
    _marketOne = arrComp.firstObject;
    if ([arrComp count]==2) {
        _marketTwo = arrComp.lastObject;
    }
    
}
@end

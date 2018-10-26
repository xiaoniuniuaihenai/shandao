//
//  GoodRemark.m
//  Himalaya
//
//  Created by 杨鹏 on 16/8/1.
//  Copyright © 2016年 ala. All rights reserved.
//

#import "GoodRemark.h"
#import "RemarkPhoto.h"

@implementation GoodRemark

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"rateDetail":[RemarkPhoto class]};
}

@end

//
//  CategoryListApi.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2018/1/10.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "CategoryListApi.h"

@interface CategoryListApi ()

@property (nonatomic, copy) NSString *categoryId;
@property (nonatomic, assign) NSInteger pageNumber;

@end

@implementation CategoryListApi

- (instancetype)initWithCategoryId:(NSString *)categoryId pageNumber:(NSInteger)pageNumber
{
    self = [super init];
    if (self) {
        _categoryId = categoryId;
        _pageNumber = pageNumber;
    }
    return self;
}



- (id)requestArgument{
    NSMutableDictionary * paramDict = [[NSMutableDictionary alloc]init];
    [paramDict setValue:self.categoryId forKey:@"rid"];
    [paramDict setValue:[NSString stringWithFormat:@"%ld", _pageNumber] forKey:@"pageNo"];
    return paramDict;
}
- (NSString * )requestUrl{
    return @"/mall/getGoodsPartition";
}

@end

//
//  CategoryListApi.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2018/1/10.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "BaseRequestSerivce.h"

@interface CategoryListApi : BaseRequestSerivce

- (instancetype)initWithCategoryId:(NSString *)categoryId pageNumber:(NSInteger)pageNumber;

@end

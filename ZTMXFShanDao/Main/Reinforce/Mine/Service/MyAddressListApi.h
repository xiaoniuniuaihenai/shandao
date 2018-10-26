//
//  MyAddressListApi.h
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2017/12/11.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "BaseRequestSerivce.h"

@interface MyAddressListApi : BaseRequestSerivce

- (instancetype)initWithId:(NSString *)addressId pageNum:(NSInteger)pageNum pageSize:(NSInteger)pageSize;

@end

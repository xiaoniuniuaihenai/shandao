//
//  LSAddressModel.h
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2017/12/8.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSAddressModel : NSObject

@property (nonatomic, assign) long addressId;//地址id
@property (nonatomic, copy) NSString *consignee;// 联系人
@property (nonatomic, copy) NSString *consigneeMobile;// 联系电话
@property (nonatomic, copy) NSString *province;// 省
@property (nonatomic, copy) NSString *city;// 市
@property (nonatomic, copy) NSString *region;// 联系区
@property (nonatomic, copy) NSString *street;// 街道
@property (nonatomic, copy) NSString *detailAddress;// 详细地址
@property (nonatomic, assign) int isDefault;// 是否默认地址

@property (nonatomic, assign) BOOL isSelected;// 是否选中


@end

@interface LSOrderAddressModel : NSObject

/* 收货地址*/
@property (nonatomic, copy) NSString *address;
/* 收货人*/
@property (nonatomic, copy) NSString *consignee;
/* 手机号*/
@property (nonatomic, copy) NSString *consigneeMobile;

@end

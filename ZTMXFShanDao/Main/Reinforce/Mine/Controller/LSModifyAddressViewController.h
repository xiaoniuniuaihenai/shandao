//
//  LSModifyAddressViewController.h
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2017/12/8.
//  Copyright © 2017年 LSCredit. All rights reserved.
//  编辑地址

#import "BaseViewController.h"
@class LSAddressModel;

typedef NS_ENUM(NSUInteger ,LSLoanAddressType) {
    LSAddAddressType,         //添加地址
    LSModifyAddressType,      //修改地址
    LSWriteAddressType        //填写地址
};

@protocol LSModifyAddressDelegete <NSObject>

@optional

- (void)writeAddressSuccess;

@end

@interface LSModifyAddressViewController : BaseViewController

@property (nonatomic, assign) LSLoanAddressType addressType;

@property (nonatomic, strong) LSAddressModel *addressModel;

@property (nonatomic, strong) NSString *orderId; // 订单id

@property (nonatomic, weak) id <LSModifyAddressDelegete> delegete;
/**
140新增  1 借款结果页  隐藏删除按钮
 */
@property (nonatomic, assign) int stepType;


@end

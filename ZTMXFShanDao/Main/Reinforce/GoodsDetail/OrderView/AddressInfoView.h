//
//  AddressInfoView.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2018/1/5.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LSAddressModel;

@protocol AddressInfoViewDelegate <NSObject>

@optional
/** 选择地址 */
- (void)addressInfoViewChoiseAddress;
/** 添加地址 */
- (void)addressInfoViewAddAddress;

@end

@interface AddressInfoView : UIView

@property (nonatomic, weak) id<AddressInfoViewDelegate> delegate;

/** 地址信息 */
@property (nonatomic, strong) LSAddressModel *addressModel;
/** 显示地址view还是添加地址view */
@property (nonatomic, assign) BOOL showAddress;

/** 不显示箭头和左边图片 */
- (void)showRowButtonView:(BOOL)showRow;

@end

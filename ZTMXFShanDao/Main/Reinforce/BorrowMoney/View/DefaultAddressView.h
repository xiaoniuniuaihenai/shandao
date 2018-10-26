//
//  DefaultAddressView.h
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2017/12/13.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LSAddressModel;

@protocol DefaultAddressDelegete <NSObject>

@optional
- (void)clickEditDefaultAddress;

@end

@interface DefaultAddressView : UIView

@property (nonatomic, strong) LSAddressModel *defaultAddress;

@property (nonatomic, weak) id <DefaultAddressDelegete> delegete;

@end

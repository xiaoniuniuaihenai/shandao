//
//  LSReceivingView.h
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2017/12/7.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LSAddressModel;


@protocol LSReceivingViewDelegete <NSObject>

- (void)updateAddressWithProvice:(NSString *)provice city:(NSString *)city region:(NSString *)region;

@end

@interface LSReceivingView : UIView

@property (nonatomic, strong) UITextField *textName;

@property (nonatomic, strong) UITextField *phoneNum;

@property (nonatomic, strong) UILabel *choosedAreaLabel;

@property (nonatomic, strong) UITextView *detailArea;

@property (nonatomic, strong) LSAddressModel *addressModel;

@property (nonatomic, weak) id <LSReceivingViewDelegete>delegete;

@property (nonatomic, strong) UISwitch * defaultAddressSwitch;


//@property (nonatomic, strong) UIButton *chooseButton;

//134版本新增type
- (instancetype)initWithFrame:(CGRect)frame type:(NSInteger)type;

@end

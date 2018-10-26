//
//  MyAddressCell.h
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2017/12/8.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LSAddressModel;

@protocol MyAddressDelegate <NSObject>

@optional
- (void)clickMyAddressBtn:(UIButton *)sender;

@end

@interface MyAddressCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *defaultAddressBtn;

@property (nonatomic, weak) id<MyAddressDelegate> delegete;

@property (nonatomic, strong) LSAddressModel *addressModel;

@end

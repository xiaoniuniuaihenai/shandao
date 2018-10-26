//
//  OrderChoiseBankCardCell.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2018/1/9.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BankCardModel;

@interface OrderChoiseBankCardCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) BankCardModel *bankCardModel;

@end

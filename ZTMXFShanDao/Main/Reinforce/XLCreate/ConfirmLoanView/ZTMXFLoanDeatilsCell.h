//
//  ZTMXFLoanDeatilsCell.h
//  ZTMXFXunMiaoiOS
//
//  Created by 陈传亮 on 2018/4/17.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LSBorrwingCashInfoModel;

@interface ZTMXFLoanDeatilsCell : UITableViewCell

+(id)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) LSBorrwingCashInfoModel * cashInfoModel;
@end

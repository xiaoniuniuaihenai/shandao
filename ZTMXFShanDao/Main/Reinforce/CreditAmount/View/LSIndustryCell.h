//
//  LSIndustryCell.h
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2017/12/27.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LSIndustryCell : UITableViewCell

@property (nonatomic, copy) NSString *industryTitle;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end

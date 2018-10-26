//
//  ZTMXFLoanAdCell.h
//  ZTMXFXunMiaoiOS
//
//  Created by 陈传亮 on 2018/5/3.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZTMXFLoanAdCell : UITableViewCell


@property (nonatomic, strong)UIImageView * adImageView;

@property (nonatomic, strong)UIButton * shutBtn;

@property (nonatomic, copy)NSString * imageUrl;


+ (id)LoanAdCellWithTableView:(UITableView *)tableView;



@end

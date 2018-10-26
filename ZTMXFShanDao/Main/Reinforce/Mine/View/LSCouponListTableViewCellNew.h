//
//  LSCouponListTableViewCellNew.h
//  YWLTMeiQiiOS
//
//  Created by 余金超 on 2018/6/22.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CounponModel;

@interface LSCouponListTableViewCellNew : UITableViewCell

@property (nonatomic, assign) BOOL isMine;

@property (nonatomic, strong) CounponModel *couponModel;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end

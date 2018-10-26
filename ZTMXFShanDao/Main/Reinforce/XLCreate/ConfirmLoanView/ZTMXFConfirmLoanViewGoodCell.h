//
//  ZTMXFConfirmLoanViewGoodCellTableViewCell.h
//  ZTMXFXunMiaoiOS
//
//  Created by 余金超 on 2018/6/14.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LSBorrwingCashInfoModel.h"

typedef void(^ActionBlock)(void);
typedef void(^SeletedBlock)(BOOL);

@interface ZTMXFConfirmLoanViewGoodCell : UITableViewCell

@property(nonatomic, strong)GoodsInfoModel * goodsInfoModel;

@property (nonatomic, copy) ActionBlock moreButtonClickBlock;
@property (nonatomic, copy) ActionBlock detailButtonClickBlock;
@property (nonatomic, copy) SeletedBlock seletedBlock;
+(id)cellWithTableView:(UITableView *)tableView;
@end

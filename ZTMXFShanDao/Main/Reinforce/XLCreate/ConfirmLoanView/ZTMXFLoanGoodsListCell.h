//
//  ZTMXFLoanGoodsListCell.h
//  ZTMXFXunMiaoiOS
//
//  Created by 陈传亮 on 2018/4/17.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GoodsInfoModel;
//typedef void(^clickHandle)(ZTMXFLoanGoodsListCell * loanGoodsListCell);

@interface ZTMXFLoanGoodsListCell : UITableViewCell
@property (nonatomic, strong)UIButton * chooseBtn;

@property (nonatomic, copy)void(^clickHandle)(ZTMXFLoanGoodsListCell * loanGoodsListCell);

@property(nonatomic, strong)GoodsInfoModel * goodsInfoModel;

@property(nonatomic, strong)UIImageView * goodsIconView;

@property(nonatomic, assign)BOOL         isFromVC;

+(id)cellWithTableView:(UITableView *)tableView;
/**
 自定义分割线
 */
@property (nonatomic, strong)UIView * bottomLine;

@property (nonatomic, strong)UILabel *goodsTextLabel;
@property (nonatomic, strong)UILabel *goodsDetailTextLabel;

/**
 原价
 */
@property (nonatomic, strong)UILabel * originalPriceLabel;

@property (nonatomic, strong)UIButton * arrowBtn;

@property (nonatomic, strong)UILabel * detailsTextLabel;








@end

//
//  ZTMXFConfirmLoanCell.h
//  ZTMXFXunMiaoiOS
//
//  Created by 陈传亮 on 2018/4/17.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZTMXFConfirmLoanCell : UITableViewCell

+(id)cellWithTableView:(UITableView *)tableView;

/**
 自定义分割线
 */
@property (nonatomic, strong)UIView * bottomLine;
/**
 对号
 */
@property (nonatomic, strong)UIImageView * successfulImgView;

/**
 
 */
@property (nonatomic, strong)UILabel * rigthLabel;

/**
 
 */
@property (nonatomic, strong)UIImageView * iconImgView;



@end

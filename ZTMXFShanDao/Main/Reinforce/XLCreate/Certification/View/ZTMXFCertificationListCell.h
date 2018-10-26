//
//  ZTMXFCertificationListCell.h
//  ZTMXFXunMiaoiOS
//
//  Created by 陈传亮 on 2018/4/8.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XLCertificationStatus;
@interface ZTMXFCertificationListCell : UITableViewCell

+(id)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong)XLCertificationStatus * certificationStatus;

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

@end

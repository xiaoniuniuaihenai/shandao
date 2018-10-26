//
//  ZTMXFCertificationCenterCell.h
//  ZTMXFXunMiaoiOS
//
//  Created by 陈传亮 on 2018/3/9.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZTMXFCertificationStatusModel;
@interface ZTMXFCertificationCenterCell : UITableViewCell

@property (nonatomic, strong)UIImageView * imgView;

@property (nonatomic, strong)UILabel * nameLabel;

@property (nonatomic, strong)UIButton * certificationBtn;

@property (nonatomic, strong)UIView * lineView;

@property (nonatomic, strong)ZTMXFCertificationStatusModel * certificationStatusModel;


@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel     *titleLabel;
@property (nonatomic, strong) UILabel     *detailTitleLabel;
@property (nonatomic, strong) UIButton    *rightButton;

@end

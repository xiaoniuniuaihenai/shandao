//
//  ZTMXFLoanSupermarketCell.h
//  ZTMXFXunMiaoiOS
//
//  Created by 陈传亮 on 2018/3/10.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LSLoanSupermarketModel;

@interface ZTMXFLoanSupermarketCell : UITableViewCell

@property (nonatomic, strong)LSLoanSupermarketModel * loanSupermarketModel;

@property (nonatomic, strong)UIImageView * iconView;

@property (nonatomic, strong)UILabel * nameLabel;

//@property (nonatomic, strong)UICollectionView * tagView;

@property (nonatomic, strong)UIImageView * angleImgView;

@end

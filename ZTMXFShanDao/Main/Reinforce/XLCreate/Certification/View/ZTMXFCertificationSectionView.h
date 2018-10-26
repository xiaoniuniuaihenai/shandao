//
//  ZTMXFCertificationSectionView.h
//  ZTMXFXunMiaoiOS
//
//  Created by 陈传亮 on 2018/4/8.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZTMXFCertificationSectionView : UITableViewHeaderFooterView

@property (nonatomic, strong)UILabel * titleLabel;

@property (nonatomic, strong)UIView * lineView;

@property (nonatomic, strong)UIView * leftLineView;

+ (id)headerFooterViewWithTable:(UITableView *)tableView;



@end

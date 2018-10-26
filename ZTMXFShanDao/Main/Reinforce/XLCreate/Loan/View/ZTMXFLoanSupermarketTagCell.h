//
//  ZTMXFLoanSupermarketTagCell.h
//  ZTMXFXunMiaoiOS
//
//  Created by 陈传亮 on 2018/5/8.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZTMXFLoanSupermarketTagCell : UICollectionViewCell


@property (nonatomic, strong)UILabel * tagLabel;

@property (nonatomic, copy)NSString * tagString;

+ (CGFloat)adaptionWidth:(NSString *)str;

@end

//
//  ProductTagCell.h
//  YuCaiShi
//
//  Created by 陈传亮 on 2017/3/28.
//  Copyright © 2017年 陈传亮. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductTagCell : UICollectionViewCell

@property (nonatomic, strong)UILabel * tagLabel;

@property (nonatomic, copy)NSString * tagString;

+ (CGFloat)adaptionWidth:(NSString *)str;

@end

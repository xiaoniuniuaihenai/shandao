//
//  StyleCollectionViewCell.h
//  Himalaya
//
//  Created by 杨鹏 on 16/8/6.
//  Copyright © 2016年 ala. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StyleCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UILabel  *titleLabel;
/** 是否选中 */
@property (nonatomic, assign) BOOL  selectedState;

@end

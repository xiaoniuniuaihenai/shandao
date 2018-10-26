//
//  ZTMXFMineFirstSectionCell.h
//  ZTMXFXunMiaoiOS
//
//  Created by 余金超 on 2018/5/15.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

typedef void(^CallBackBlock)(NSString *title);

#import <UIKit/UIKit.h>

@interface ZTMXFMineFirstSectionCell : UITableViewCell

@property (nonatomic, copy) CallBackBlock itemSeletedBlock;

@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic, strong) NSArray *dataAry;

+ (CGFloat)cellHeight;

@end

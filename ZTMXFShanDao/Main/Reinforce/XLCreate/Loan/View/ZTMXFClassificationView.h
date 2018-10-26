//
//  ZTMXFClassificationView.h
//  ZTMXFXunMiaoiOS
//
//  Created by 陈传亮 on 2018/3/23.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZTMXFClassification;
@interface ZTMXFClassificationView : UIView

@property (nonatomic, strong)UICollectionView * collectionView;

@property (nonatomic, strong)UITableView * tableView;

@property (nonatomic, strong)NSMutableArray * dataArray;

@property (nonatomic, strong)ZTMXFClassification * classification;

@property (nonatomic, copy) void (^clickTableViewCell)(ZTMXFClassification * classification);




@end

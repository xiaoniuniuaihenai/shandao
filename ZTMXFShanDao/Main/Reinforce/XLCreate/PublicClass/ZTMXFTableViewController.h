//
//  ZTMXFTableViewController.h
//  ZTMXFXunMiaoiOS
//
//  Created by 陈传亮 on 2018/3/8.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "BaseViewController.h"

@interface ZTMXFTableViewController : BaseViewController


@property (nonatomic, strong)UITableView * tableView;

@property (nonatomic, strong)NSMutableArray * dataArray;

@property (nonatomic, assign)NSInteger pageNum;

@property (nonatomic, strong)UIImageView * imageView;

/** 更多数据 */
- (void)moreData;
/** 刷新数据 */
- (void)refData;
/** 添加footer */
- (void)addFooter;
/** 结束刷新 */
- (void)endRef;

@end

//
//  ZTMXFLoanCollectionViewCell.m
//  ZTMXFXunMiaoiOS
//
//  Created by 陈传亮 on 2018/3/20.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "ZTMXFLoanCollectionViewCell.h"
#import "ZTMXFLoanSupermarketCell.h"
#import "LSLoanSupermarketModel.h"

@interface ZTMXFLoanCollectionViewCell ()<UITableViewDelegate, UITableViewDataSource>


@end



@implementation ZTMXFLoanCollectionViewCell


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UITableView * tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        if (@available(iOS 11.0, *)) {
            tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        tableView.rowHeight = 66;
        tableView.tableFooterView = [[UIView alloc] init];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.showsVerticalScrollIndicator = NO;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.contentView addSubview:tableView];
        
        
        
    }
    return self;
}

#pragma mark -  TableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return _dataArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellstr = @"cell";
    ZTMXFLoanSupermarketCell * cell = [tableView dequeueReusableCellWithIdentifier:cellstr];
    if (!cell) {
        cell = [[ZTMXFLoanSupermarketCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellstr];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.loanSupermarketModel = _dataArr[indexPath.row];
    return cell;
}



@end

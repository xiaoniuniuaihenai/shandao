//
//  PFDropMenuView.m
//  WSDropMenuView
//
//  Created by panfei mao on 2018/1/1.
//  Copyright © 2018年 Senro Wong. All rights reserved.
//

#import "PFDropMenuView.h"

#define Main_Screen_Height [[UIScreen mainScreen] bounds].size.height
#define Main_Screen_Width [[UIScreen mainScreen] bounds].size.width
#define KBgMaxHeight  Main_Screen_Height
#define KTableViewMaxHeight Main_Screen_Height - k_Navigation_Bar_Height
#define KFontSize 14

#define KTopButtonHeight 44

@implementation PFIndexPath

+ (instancetype)twIndexPathWithColumn:(NSInteger)column
                                  row:(NSInteger)row
                                 item:(NSInteger)item
                                 rank:(NSInteger)rank{
    
    PFIndexPath *indexPath = [[self alloc] initWithColumn:column row:row item:item rank:rank];
    
    return indexPath;
}

- (instancetype)initWithColumn:(NSInteger )column
                           row:(NSInteger )row
                          item:(NSInteger )item
                          rank:(NSInteger )rank{
    
    if (self = [super init]) {
        
        self.row = row;
        self.item = item;
        self.rank = rank;
        
    }
    
    return self;
}

@end

static NSString *cellIdent = @"cellIdent";

@interface PFDropMenuView ()<UITableViewDataSource,UITableViewDelegate>
{
    
    NSInteger _currSelectColumn;
    NSInteger _currSelectRow;
    NSInteger _currSelectItem;
    NSInteger _currSelectRank;
}

@property (nonatomic,strong) UITableView *leftTableView;
@property (nonatomic,strong) UITableView *leftTableView_1;
@property (nonatomic,strong) UITableView *leftTableView_2;

@property (nonatomic,strong) UIButton *bgButton; //背景

@end

@implementation PFDropMenuView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self _initialize];
        [self _setSubViews];
    }
    return self;
}



- (void)_setSubViews{
    
    [self addSubview:self.bgButton];
    [self.bgButton addSubview:self.leftTableView];
    [self.bgButton addSubview:self.leftTableView_1];
    [self.bgButton addSubview:self.leftTableView_2];
    
    
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, Main_Screen_Width, Main_Screen_Height);
    self.bgButton.frame = CGRectMake(self.bgButton.frame.origin.x, self.bgButton.frame.origin.y, self.bounds.size.width, self.bounds.size.height);
    self.bgButton.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.3];
    [self _showLeftTableViews];
}
- (void)_initialize{
    
    _currSelectColumn = 0;
    _currSelectItem = 0;
    _currSelectRank = 0;
    _currSelectRow = 0;
}
#pragma mark -- public fun --
- (void)reloadLeftTableView{
    
    [self.leftTableView reloadData];
}

- (void)setIndustryName:(NSString *)industryName{
    _industryName = industryName;
    
}

#pragma mark -- getter --
- (UITableView *)leftTableView{
    
    if (!_leftTableView) {
        
        _leftTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _leftTableView.backgroundColor = [UIColor colorWithHexString:@"F2F4F5"];
        _leftTableView.delegate = self;
        _leftTableView.dataSource = self;
        [_leftTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdent];
        _leftTableView.frame = CGRectMake(0, 0, self.bgButton.frame.size.width/3.0, 0);
        _leftTableView.tableFooterView = [[UIView alloc]init];
    }
    return _leftTableView;
}




- (UITableView *)leftTableView_2{
    
    if (!_leftTableView_2) {
        _leftTableView_2 = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _leftTableView_2.delegate = self;
        _leftTableView_2.dataSource = self;
        [_leftTableView_2 registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdent];
        _leftTableView_2.frame = CGRectMake( self.bgButton.frame.size.width/3.0 * 2, 0 , self.bgButton.frame.size.width/3.0, 0);
        _leftTableView_2.backgroundColor = [UIColor colorWithHexString:@"F2F4F5"];
        _leftTableView_2.tableFooterView = [[UIView alloc]init];
    }
    return _leftTableView_2;
}
- (UITableView *)leftTableView_1{
    
    if (!_leftTableView_1) {
        _leftTableView_1 = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _leftTableView_1.delegate = self;
        _leftTableView_1.dataSource = self;
        [_leftTableView_1 registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdent];
        _leftTableView_1.frame = CGRectMake( self.bgButton.frame.size.width/3.0, 0 , self.bgButton.frame.size.width/3.0, 0);
        _leftTableView_1.backgroundColor = [UIColor whiteColor];
        _leftTableView_1.tableFooterView = [[UIView alloc]init];
    }
    return _leftTableView_1;
}
- (UIButton *)bgButton{
    
    if (!_bgButton) {
        _bgButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _bgButton.backgroundColor = [UIColor clearColor];
        _bgButton.frame = CGRectMake(0.0, 0.0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
        [_bgButton addTarget:self action:@selector(bgAction:) forControlEvents:UIControlEventTouchUpInside];
        _bgButton.clipsToBounds = YES;
    }
    return _bgButton;
}

#pragma mark -- tableViews Change -
- (void)_hiddenLeftTableViews{
    
    self.leftTableView.frame = CGRectMake(self.leftTableView.frame.origin.x, self.leftTableView.frame.origin.y, self.leftTableView.frame.size.width, 0);
    self.leftTableView_1.frame = CGRectMake(self.leftTableView_1.frame.origin.x, self.leftTableView_1.frame.origin.y, self.leftTableView_1.frame.size.width, 0);
    self.leftTableView_2.frame = CGRectMake(self.leftTableView_2.frame.origin.x, self.leftTableView_2.frame.origin.y, self.leftTableView_2.frame.size.width, 0);
}

- (void)_showLeftTableViews{
    
    self.leftTableView.frame = CGRectMake(self.leftTableView.frame.origin.x, self.leftTableView.frame.origin.y, self.leftTableView.frame.size.width, KTableViewMaxHeight);
    self.leftTableView_1.frame = CGRectMake(self.leftTableView_1.frame.origin.x, self.leftTableView_1.frame.origin.y, self.leftTableView_1.frame.size.width, KTableViewMaxHeight);
    self.leftTableView_2.frame = CGRectMake(self.leftTableView_2.frame.origin.x, self.leftTableView_2.frame.origin.y, self.leftTableView_2.frame.size.width, KTableViewMaxHeight);
}

- (void)bgAction:(UIButton *)sender{
    
    [UIView animateWithDuration:0.2 animations:^{
        
        self.bgButton.backgroundColor = [UIColor clearColor];
        [self _hiddenLeftTableViews];
        
    } completion:^(BOOL finished) {
        
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, Main_Screen_Width, KTopButtonHeight);
        self.bgButton.frame = CGRectMake(self.bgButton.frame.origin.x, self.bgButton.frame.origin.y, self.bounds.size.width, 0);
    }];
}

#pragma mark -- DataSource -
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60.0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    PFIndexPath *twIndexPath =[self _getTwIndexPathForNumWithtableView:tableView];
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(dropMenuView:numberWithIndexPath:)]) {
        
        NSInteger count =  [self.dataSource dropMenuView:self numberWithIndexPath:twIndexPath];
        return count;
    }else{
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PFIndexPath *twIndexPath = [self _getTwIndexPathForCellWithTableView:tableView indexPath:indexPath];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdent];
    cell.selectedBackgroundView = [[UIView alloc] init];
    cell.selectedBackgroundView.backgroundColor =  [UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:1.0];
    cell.textLabel.textColor = [UIColor colorWithHexString:COLOR_GRAY_STR];
    cell.textLabel.font = [UIFont systemFontOfSize:AdaptedWidth(KFontSize)];
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.highlightedTextColor = [UIColor colorWithHexString:COLOR_RED_STR];
    cell.textLabel.numberOfLines = 2;
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(dropMenuView:titleWithIndexPath:)]) {
        
        cell.textLabel.text =  [self.dataSource dropMenuView:self titleWithIndexPath:twIndexPath];
        if ([cell.textLabel.text isEqualToString:self.industryName]) {
            cell.textLabel.textColor = [UIColor colorWithHexString:COLOR_RED_STR];
            _currSelectRow = indexPath.row;
        }
    }else{
        
        cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    }
    
    return cell;
}



#pragma mark - tableView delegate -
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *position = cell.textLabel.text;
    if (tableView == self.leftTableView) {
        if (_currSelectRow != indexPath.row) {
            NSIndexPath *lastIndexPath = [NSIndexPath indexPathForRow:_currSelectRow inSection:indexPath.section];
            UITableViewCell *lastCell = [tableView cellForRowAtIndexPath:lastIndexPath];
            lastCell.textLabel.textColor = [UIColor colorWithHexString:COLOR_GRAY_STR];
        }
        _currSelectRow = indexPath.row;
        self.industryName = cell.textLabel.text;
        _currSelectItem = 0;
        _currSelectRank = 0;
        
        [self.leftTableView_1 reloadData];
        [self.leftTableView_2 reloadData];
    }
    if (tableView == self.leftTableView_1) {
        if (_currSelectItem != indexPath.row) {
            NSIndexPath *lastIndexPath = [NSIndexPath indexPathForRow:_currSelectItem inSection:indexPath.section];
            UITableViewCell *lastCell = [tableView cellForRowAtIndexPath:lastIndexPath];
            lastCell.textLabel.textColor = [UIColor colorWithHexString:COLOR_GRAY_STR];
        }
        _currSelectItem = indexPath.row;
        _currSelectRank = 0;
        [self.leftTableView_2 reloadData];
    }
    if (self.leftTableView_2 == tableView) {
        // 点击第三列
        cell.backgroundColor = [UIColor colorWithHexString:@"FFE5DF"];
        _currSelectRank = indexPath.row;
        if (self.delegate && [self.delegate respondsToSelector:@selector(dropMenuView:didSelectWithIndexPath:title:)]) {
            PFIndexPath *twIndexPath = [self _getTwIndexPathForCellWithTableView:tableView indexPath:indexPath];
            [self.delegate dropMenuView:self didSelectWithIndexPath:twIndexPath title:position];
        }
    }
}

- (PFIndexPath *)_getTwIndexPathForNumWithtableView:(UITableView *)tableView{
    
    if (tableView == self.leftTableView) {
        
        return  [PFIndexPath twIndexPathWithColumn:_currSelectColumn row:WSNoFound item:WSNoFound rank:WSNoFound];
    }
    
    if (tableView == self.leftTableView_1 && _currSelectRow != WSNoFound) {
        
        return [PFIndexPath twIndexPathWithColumn:_currSelectColumn row:_currSelectRow item:WSNoFound rank:WSNoFound];
    }
    
    if (tableView == self.leftTableView_2 && _currSelectRow != WSNoFound && _currSelectItem != WSNoFound) {
        return [PFIndexPath twIndexPathWithColumn:_currSelectColumn row:_currSelectRow item:_currSelectItem  rank:WSNoFound];
    }
    return  0;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}
- (PFIndexPath *)_getTwIndexPathForCellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath{
    
    if (tableView == self.leftTableView) {
        
        return  [PFIndexPath twIndexPathWithColumn:0 row:indexPath.row item:WSNoFound rank:WSNoFound];
    }
    
    if (tableView == self.leftTableView_1) {
        
        return [PFIndexPath twIndexPathWithColumn:_currSelectColumn row:_currSelectRow item:indexPath.row rank:WSNoFound];
    }
    
    if (tableView == self.leftTableView_2) {
        return [PFIndexPath twIndexPathWithColumn:_currSelectColumn row:_currSelectRow item:_currSelectItem  rank:indexPath.row];
    }
    return  [PFIndexPath twIndexPathWithColumn:0 row:indexPath.row item:WSNoFound rank:WSNoFound];
}



@end

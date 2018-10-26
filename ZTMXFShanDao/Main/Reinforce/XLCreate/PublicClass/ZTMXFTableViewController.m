//
//  ZTMXFTableViewController.m
//  ZTMXFXunMiaoiOS
//
//  Created by 陈传亮 on 2018/3/8.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "ZTMXFTableViewController.h"
@interface ZTMXFTableViewController ()<UITableViewDelegate, UITableViewDataSource>



@end

@implementation ZTMXFTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray = [NSMutableArray array];
    // Do any additional setup after loading the view.
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


- (void)addFooter
{
    @WeakObj(self);
    if (!_tableView.mj_footer) {
        MJRefreshAutoGifFooter * footer = [MJRefreshAutoGifFooter footerWithRefreshingBlock:^{
            [selfWeak moreData];
        }];
        footer.frame = CGRectMake(0, 0, KW, 70);
        [footer setTitle:MJEndText forState:MJRefreshStateNoMoreData];
        footer.stateLabel.font = FONT_LIGHT(14);
        [footer addSubview:self.imageView];
        _imageView.frame = CGRectMake(15, 0, KW - 30, footer.height);
        _tableView.mj_footer = footer;
    }
}


- (UIImageView *)imageView
{
    if (!_imageView) {
        self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"GY_EndImage"]];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        _imageView.hidden = YES;
    }
    return _imageView;
}

- (void)moreData
{
    
}

- (void)refData
{
    
}

- (void)endRef
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self addFooter];
        [self.tableView.mj_footer endRefreshing];
        [self.tableView.mj_header endRefreshing];
        if (self.dataArray.count) {
            if (self.dataArray.count - (self.pageNum - 1) * K_Page_size != 0) {
                MJRefreshAutoGifFooter * footer = (MJRefreshAutoGifFooter *)self.tableView.mj_footer;
                [footer endRefreshingWithNoMoreData];
                _imageView.hidden = NO;
            }else{
                _imageView.hidden = YES;
            }
        }else{
            self.tableView.mj_footer.hidden = YES;
        }
        [self.tableView reloadData];
    });
}

- (UITableView *)tableView
{
    if (!_tableView) {
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KW, KH - TabBar_Height) style:UITableViewStylePlain];
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            // Fallback on earlier versions
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        @WeakObj(self);
       
        MJRefreshNormalHeader* headerRefresh = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [selfWeak refData];
        }];
        headerRefresh.lastUpdatedTimeLabel.hidden = YES;
        headerRefresh.stateLabel.hidden = YES;
//        headerRefresh.stateLabel.font = FONT_LIGHT(14);
        _tableView.mj_header = headerRefresh;
    }
    return _tableView;
}


#pragma mark -  TableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return _dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellstr = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellstr];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellstr];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

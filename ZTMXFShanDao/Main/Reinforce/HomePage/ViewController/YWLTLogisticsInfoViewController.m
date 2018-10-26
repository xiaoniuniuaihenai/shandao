//
//  LSLogisticsInfoViewController.m
//  ZTMXFXunMiaoiOS
//
//  Created by 朱吉达 on 2018/1/14.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "YWLTLogisticsInfoViewController.h"
#import "LogisticsHeadView.h"
#import "LogisticsInfoListView.h"
#import "LogistcsInfoModel.h"
#import "ZTMXFLogisticsInfoViewModel.h"
@interface YWLTLogisticsInfoViewController ()<LogistcsInfoViewModelDelegate>
@property (nonatomic,strong) UIScrollView * scrollView;
@property (nonatomic,strong) LogisticsHeadView * headView;
@property (nonatomic,strong) LogisticsInfoListView * infoListView;
@property (nonatomic,strong) LogistcsInfoModel * infoModel;
@end

@implementation YWLTLogisticsInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"物流详情";
    if (@available(iOS 11.0, *)) {
        self.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self.view setBackgroundColor:[UIColor colorWithHexString:COLOR_LIGHTBG_STR]];
    [self configAddSubView];
    [self configRequestApi];
}

-(void)configRequestApi{
    ZTMXFLogisticsInfoViewModel * infoViewModel = [[ZTMXFLogisticsInfoViewModel alloc]init];
    infoViewModel.delegate = self;
    [infoViewModel requestLogistcsInfoDataWithOrderId:_orderId type:_type];
}

#pragma mark ---
-(void)configAddSubView{
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.headView];
    [self.scrollView addSubview:self.infoListView];
    self.scrollView.contentSize = CGSizeMake(0, _infoListView.bottom);
}
-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]init];
        [_scrollView setFrame:CGRectMake(0,k_Navigation_Bar_Height, Main_Screen_Width, Main_Screen_Height-k_Navigation_Bar_Height)];
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
    }
    return _scrollView;
}
-(LogisticsHeadView *)headView{
    if (!_headView) {
        _headView = [[LogisticsHeadView alloc]init];
        [_headView setFrame:CGRectMake(0, 0, Main_Screen_Width, AdaptedWidth(90))];
    }
    return _headView;
}
-(LogisticsInfoListView *)infoListView{
    if (!_infoListView) {
        _infoListView = [[LogisticsInfoListView alloc]init];
        [_infoListView setFrame:CGRectMake(0, _headView.bottom+AdaptedWidth(10), Main_Screen_Width,0)];
    }
    return _infoListView;
}


#pragma mark -- delegate
-(void)requestLogistcsInfoSuccess:(LogistcsInfoModel *)logistcsModel{
    _infoModel = logistcsModel;
    _headView.infoModel = logistcsModel;
    _infoListView.infoModel = logistcsModel;
    _scrollView.contentSize = CGSizeMake(0, _infoListView.bottom+AdaptedWidth(20));
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

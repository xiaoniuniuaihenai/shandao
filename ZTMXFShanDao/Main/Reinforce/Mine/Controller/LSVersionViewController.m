//
//  LSVersionViewController.m
//  YWLTMeiQiiOS
//
//  Created by yangpenghua on 2017/9/19.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "LSVersionViewController.h"
#import "LSTitleValueTableViewCell.h"
#import "HWNewfeatureViewController.h"
#import "XXYActionSheetView.h"
#import "LSChangeBaseUrlViewController.h"
@interface LSVersionViewController ()<UITableViewDelegate, UITableViewDataSource, NewfeatureViewControllerDelegate,BBBaseViewControllerDataSource>
/** tableView */
@property (nonatomic, strong) UITableView       *tableView;
/** tableHeaderView */
@property (nonatomic, strong) UIView            *headerView;
/** 服务协议 */
@property (nonatomic, strong) UIButton          *protocolButton;
/** app Name Label */
@property (nonatomic, strong) UILabel           *appNameLabel;
/** app Company Label */
@property (nonatomic, strong) UILabel           *appCompanyLabel;

/** data Array */
@property (nonatomic, strong) NSArray           *dataArray;

@end

@implementation LSVersionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"版本管理";
    self.dataArray = @[@"去评分", @"客服电话"];
    [self configueSubViews];
    
    
}

#pragma mark - BBBaseViewControllerDataSource
- (BOOL)hideNavigationBottomLine{
    return YES;
}

#pragma mark UITableDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LSTitleValueTableViewCell *cell = [LSTitleValueTableViewCell cellWithTableView:tableView];
    NSString *title = self.dataArray[indexPath.row];
    cell.titleLabel.text = title;
    if ([title isEqualToString:@"客服电话"]) {
        cell.valueLabel.text = kCustomerServicePhone;
    } else {
        cell.valueLabel.text = @"";
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *title = self.dataArray[indexPath.row];
    if ([title isEqualToString:@"去评分"]) {
        //  评价页面 
        // itms-apps://itunes.apple.com/app/id1436433217
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/id%@", @"1436433217"]]];
        
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=1436433217&pageNumber=0&sortOrdering=2&type=Purple+Software&mt=8"]];
    } else if ([title isEqualToString:@"客服电话"]) {
        //  客服电话
        NSArray * arr = @[kCustomerServicePhone, @"取消"];
        XXYActionSheetView *alertSheetView = [[XXYActionSheetView alloc] initWithTitle:@"拨打客服电话\n工作时间9:00-23:00" cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:arr actionSheetBlock:^(NSInteger index) {
            if (0 == index) {
                dispatch_after(0.3, dispatch_get_main_queue(), ^{
                    [NSString makePhoneCall];
                });
            }
        }];
        [alertSheetView xxy_show];
        //        TKActionSheetController *uActionSheet = [TKActionSheetController sheetWithTitle:@"拨打客服电话\n工作时间9:00-23:00"];
        //        [uActionSheet addButtonWithTitle:kCustomerServicePhone block:^(NSUInteger index) {
        //            dispatch_after(0.3, dispatch_get_main_queue(), ^{
        //                [NSString makePhoneCall];
        //            });
        //        }];
        //        [uActionSheet setCancelButtonWithTitle:@"取消" block:nil];
        //        [uActionSheet showInViewController:self animated:YES completion:nil];
        
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return AdaptedHeight(44.0);
}

#pragma mark - NewfeatureViewControllerDelegate
- (void)newfeatureViewControllerClickStart
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 按钮点击事件
//  点击服务协议
- (void)protocolButtonAction
{
    LSWebViewController * webVC = [[LSWebViewController alloc] init];
    webVC.webUrlStr = DefineUrlString(registerProtocol);
    [self.navigationController pushViewController:webVC animated:YES];
}


#pragma mark - Configue SubViews(添加子视图)
//  添加子视图
- (void)configueSubViews
{
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = self.headerView;
}

#pragma mark - getters and setters

- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0, 0.0, Main_Screen_Width, Main_Screen_Height) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor colorWithHexString:COLOR_LIGHTBG_STR];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.showsVerticalScrollIndicator = NO;
    }
    return _tableView;
}

- (UIView *)headerView{
    if (_headerView == nil) {
        _headerView = [[UIView alloc] init];
        _headerView.backgroundColor = [UIColor colorWithHexString:COLOR_LIGHTBG_STR];
        _headerView.frame = CGRectMake(0.0, 0.0, Main_Screen_Width, AdaptedHeight(212.0));
        
        UIImageView *iconImageView = [[UIImageView alloc] init];
        CGFloat iconImageWidthW = AdaptedHeight(70);
        iconImageView.frame = CGRectMake((Main_Screen_Width - iconImageWidthW) / 2.0, AdaptedHeight(48), iconImageWidthW, iconImageWidthW);
        iconImageView.image = [UIImage imageNamed:@"XL_appIconShare"];
        iconImageView.layer.cornerRadius = 15.0;
        iconImageView.clipsToBounds = YES;
        [_headerView addSubview:iconImageView];
        
        if (isAppOnline!=1) {
            UITapGestureRecognizer * longPg = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(longPressGesture:)];
            iconImageView.userInteractionEnabled = YES;
            [iconImageView addGestureRecognizer:longPg];
        }
        
        UILabel *versionLabel = [UILabel labelWithTitleColorStr:COLOR_LIGHT_STR fontSize:12 alignment:NSTextAlignmentCenter];
        NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
        NSString * build = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
        
        versionLabel.text = [NSString stringWithFormat:@"版本号 %@(build:%@)", version, build];
        versionLabel.frame = CGRectMake(0.0, CGRectGetMaxY(iconImageView.frame) + 8.0, Main_Screen_Width, 14.0);
        [_headerView addSubview:versionLabel];
        
        UIView *lineView = [UIView setupViewWithSuperView:_headerView withBGColor:COLOR_DEEPBORDER_STR];
        lineView.frame = CGRectMake(0.0, CGRectGetHeight(_headerView.frame) - 0.5, Main_Screen_Width, 0.5);
    }
    return _headerView;
}

- (UIButton *)protocolButton{
    if (_protocolButton == nil) {
        NSString * title = [NSString stringWithFormat:@"《%@用户服务协议》", k_APP_Name];
        _protocolButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_protocolButton setTitle:title forState:UIControlStateNormal];
        _protocolButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [_protocolButton setTitleColor:[UIColor colorWithHexString:COLOR_BLUE_STR] forState:UIControlStateNormal];
        [_protocolButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
        [_protocolButton addTarget:self action:@selector(protocolButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _protocolButton;
}

- (UILabel *)appNameLabel{
    if (_appNameLabel == nil) {
        _appNameLabel = [UILabel labelWithTitleColorStr:COLOR_LIGHT_STR fontSize:12 alignment:NSTextAlignmentCenter];
        _appNameLabel.font = AdaptedFontSize(12);
        _appNameLabel.frame = CGRectMake(0.0, 0, Main_Screen_Width, 20.0);
        _appNameLabel.text = k_APP_Name;
    }
    return _appNameLabel;
}

- (UILabel *)appCompanyLabel{
    if (_appCompanyLabel == nil) {
        _appCompanyLabel = [UILabel labelWithTitleColorStr:COLOR_LIGHT_STR fontSize:12 alignment:NSTextAlignmentCenter];
        _appCompanyLabel.font = AdaptedFontSize(12);
        _appCompanyLabel.frame = CGRectMake(0.0, CGRectGetMaxY(_appNameLabel.frame), Main_Screen_Width, 20.0);
        _appCompanyLabel.text = kCompanyName;
    }
    return _appCompanyLabel;
}
- (NSArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [NSArray array];
    }
    return _dataArray;
}
-(void)longPressGesture:(UITapGestureRecognizer*)longPre{
    LSChangeBaseUrlViewController * vc = [[LSChangeBaseUrlViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
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

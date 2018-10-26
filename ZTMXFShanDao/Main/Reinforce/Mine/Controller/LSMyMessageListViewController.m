//
//  LSMyMessageListViewController.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/9/19.
//  Copyright © 2017年 LSCredit. All rights reserved.
//
#define IdentifierCell @"MsgCell"

#import "LSMyMessageListViewController.h"
#import "LSMsgListTableViewCell.h"
#import "LSMessageManager.h"
#import "ZTMXFPushHelper.h"
@interface LSMyMessageListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,strong) NSArray * arrMsgArr;

@end

@implementation LSMyMessageListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"消息中心";
    
    [self.view setBackgroundColor:[UIColor colorWithHexString:COLOR_LIGHTBG_STR]];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    //    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.showsHorizontalScrollIndicator = NO;
    
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [_tableView setBackgroundColor:[UIColor clearColor]];
    _tableView.sectionFooterHeight = 1;
    _tableView.sectionHeaderHeight = 10;
    UIView * vi = [[UIView alloc] init];
    [vi setFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    _tableView.tableHeaderView = vi;
    vi.height = 10;
    _tableView.tableFooterView = vi;
    [self.view addSubview:_tableView];
    UINib * nib = [UINib nibWithNibName:@"LSMsgListTableViewCell" bundle:nil];
    [_tableView registerNib:nib forCellReuseIdentifier:IdentifierCell];
    if (![LoginManager appReviewState]) {
        _arrMsgArr = [LSNotificationModel notifi_selectNotificationInfoList];
    }
    //增加无数据展现
    [self.view configBlankPage:EaseBlankPageTypeNoMsgList hasData:_arrMsgArr.count hasError:NO reloadButtonBlock:^(id sender) {
    }];
    //    将未读 改为已读

    [LSNotificationModel notifi_updateNotificationInfoNotReadWithCardCouponsPush];
    [[NSNotificationCenter defaultCenter] postNotificationName:NotNewNotificationMsg object:nil];

}

#pragma mark -UITableViewDelegate,UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [_arrMsgArr count];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    LSNotificationModel * model = _arrMsgArr[indexPath.section];
    NSString * showMsg = model.message;
    if (model.message.length>=60) {
        showMsg  = [model.message substringToIndex:60];
    }
    CGFloat height = [NSString heightForString:showMsg andFont:[UIFont systemFontOfSize:AdaptedWidth(14)] andWidth:AdaptedWidth(272)];
    height = height+60;
    return height;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LSMsgListTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:IdentifierCell];
    cell.notModel = _arrMsgArr[indexPath.section];
    [cell.contentView setBackgroundColor:[UIColor clearColor]];
    [cell setBackgroundColor:[UIColor clearColor]];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    //#warning 后续添加类型区分
    LSNotificationModel * notModel = _arrMsgArr[indexPath.section];
    [ZTMXFPushHelper pushDetailsPageWithNotificationModel:notModel controller:self];
//    [LSMessageManager messagePushViewControllerWithMsgModel:notModel];
}

@end

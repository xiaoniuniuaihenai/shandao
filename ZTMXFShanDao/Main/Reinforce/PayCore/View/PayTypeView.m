//
//  PayTypeView.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/9/24.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "PayTypeView.h"
#import "PayTypeTableViewCell.h"
#import "PayChannelModel.h"
#import "PayChannelListApi.h"

@interface PayTypeView ()<UITableViewDelegate, UITableViewDataSource>

/** tableView */
@property (nonatomic, strong) UITableView *tableView;
/** back button */
@property (nonatomic, strong) UIButton *backButton;
/** header title label */
@property (nonatomic, strong) UILabel *headerLabel;
/** line view */
@property (nonatomic, strong) UIView *lineView;

/** 渠道列表模型 */
@property (nonatomic, strong) NSMutableArray *channelArray;

@end

@implementation PayTypeView


#pragma mark - setter getter
- (NSMutableArray *)channelArray{
    if (_channelArray == nil) {
        _channelArray = [NSMutableArray array];
    }
    return _channelArray;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        //  添加子控件
        [self setupViews];
    }
    return self;
}

//  添加子控件
- (void)setupViews{
    
    self.backButton = [UIButton setupButtonWithImageStr:@"nav_back" title:@"" titleColor:[UIColor whiteColor] titleFont:14 withObject:self action:@selector(backButtonAction)];
    [self addSubview:self.backButton];
    
    self.headerLabel = [UILabel labelWithTitleColorStr:COLOR_BLACK_STR fontSize:17 alignment:NSTextAlignmentCenter];
    self.headerLabel.text = @"选择支付方式";
    [self addSubview:self.headerLabel];
    
    self.lineView = [UIView setupViewWithSuperView:self withBGColor:COLOR_DEEPBORDER_STR];
    
    //  添加TableView
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0,CGRectGetMaxY(self.headerLabel.frame), SCREEN_WIDTH, 100.0) style:UITableViewStylePlain];
    tableView.backgroundColor = [UIColor whiteColor];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.showsVerticalScrollIndicator = NO;
    self.tableView = tableView;
    [self addSubview:self.tableView];
    
}

- (void)setTitle:(NSString *)title{
    if (_title != title) {
        _title = title;
    }
    if (_title) {
        self.headerLabel.text = _title;
    }
}

#pragma mark - TableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.channelArray.count + 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == self.channelArray.count) {
        return 52;
    }else{
        PayChannelModel *_payChannelModel =(PayChannelModel *)self.channelArray[indexPath.row];
        if (_payChannelModel.isValid == 0) {
            return 70;
        } else {
            if (kStringIsEmpty(_payChannelModel.channelDesc)) {
                return 52;
            }else{
                return 70;
            }
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PayTypeTableViewCell *cell = [PayTypeTableViewCell cellWithTableView:tableView];
    if (indexPath.row == self.channelArray.count) {
        //  添加银行卡
        cell.iconImageView.image = [UIImage imageNamed:@"add_bank_card"];
        cell.titleLabel.text = @"添加银行卡";
        cell.showRowImage = YES;
        cell.recommendedImageView.hidden = YES;
    } else {
        PayChannelModel *channelModel = self.channelArray[indexPath.row];
        cell.showSelectedImage = NO;
        cell.channelModel = channelModel;
        cell.showRowImage = NO;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == self.channelArray.count) {
        //  添加银行卡
        if (self.delegate && [self.delegate respondsToSelector:@selector(choiseBankCardViewAddBankCard)]) {
            [self.delegate choiseBankCardViewAddBankCard];
        }
    }else{
        PayChannelModel *channelModel = self.channelArray[indexPath.row];
        //判断选中的cell是否表示有效的银行卡或渠道
        if (channelModel.isValid == 0) {
            return;
        }
        
        
        if (channelModel.isValid == 1) {
            self.selectBankCardId = channelModel.channelId;
            if ([self.delegate respondsToSelector:@selector(payTypeViewClickPayChannel:)]) {
                [self.delegate payTypeViewClickPayChannel:channelModel];
            }
        }
    }
}

//  布局子控件
- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat viewHeight = self.bounds.size.height;
    CGFloat headerHeight = 57.0;
    
    self.backButton.frame = CGRectMake(0.0, 0.0, 44.0, headerHeight);
    self.headerLabel.frame = CGRectMake(CGRectGetWidth(self.backButton.frame), 0.0, SCREEN_WIDTH - 2 * CGRectGetWidth(self.backButton.frame), headerHeight);
    self.lineView.frame = CGRectMake(0.0, headerHeight - 0.5, SCREEN_WIDTH, 0.5);
    self.tableView.frame = CGRectMake(0.0, CGRectGetMaxY(self.headerLabel.frame), SCREEN_WIDTH, viewHeight - CGRectGetMaxY(self.headerLabel.frame) - 10.0);
    
}

#pragma mark - 点击返回按钮
- (void)backButtonAction{
    if (self.delegate && [self.delegate respondsToSelector:@selector(payTypeViewClickBackButton)]) {
        [self.delegate payTypeViewClickBackButton];
    }
}

#pragma mark - 获取银行卡列表
- (void)requestPayChannelListApiWithSourceType:(NSString *)sourceType{
    if (!sourceType) {
        sourceType = @"0";
    }
//    [SVProgressHUD showLoadingWithOutMask];
    PayChannelListApi *channelApi = [[PayChannelListApi alloc] initWithSourceType:sourceType];
    [channelApi requestWithSuccess:^(NSDictionary *responseDict) {
        NSLog(@"%@", responseDict);
        [SVProgressHUD dismiss];
        NSString *codeStr = [responseDict[@"code"] description];
        if ([codeStr isEqualToString:@"1000"]) {
            NSDictionary *dataDict = responseDict[@"data"];
            if (self.channelArray.count > 0) {
                [self.channelArray removeAllObjects];
            }
            NSArray *dataArray = [PayChannelModel mj_objectArrayWithKeyValuesArray:dataDict[@"payChannelList"]];
            self.channelArray = [NSMutableArray arrayWithArray:dataArray];
            [self.tableView reloadData];
        }
        
    } failure:^(__kindof YTKBaseRequest *request) {
        [SVProgressHUD dismiss];
    }];
}

- (void)setOfflinePay:(BOOL)offlinePay{
    _offlinePay = offlinePay;
    if (_offlinePay) {
        //  显示线下还款方式
        [self requestPayChannelListApiWithSourceType:@"1"];
    } else {
        //  不显示线下还款方式
        [self requestPayChannelListApiWithSourceType:@"0"];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

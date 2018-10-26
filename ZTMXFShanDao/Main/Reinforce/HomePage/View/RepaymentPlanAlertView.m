//
//  RepaymentPlanAlertView.m
//  ZTMXFXunMiaoiOS
//
//  Created by 朱吉达 on 2018/1/14.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "RepaymentPlanAlertView.h"
#import "RepaymentTableViewCell.h"
#import "WJYAlertView.h"
#define CellId_f @"RepayCellIdentifier"
@interface RepaymentPlanAlertView ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UIButton * headBtn;
@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,strong) UIButton * btnCloseBtn;
@property (nonatomic,strong) __block WJYAlertView * alertView;
@property (nonatomic,strong) NSArray * arrData;
@property (nonatomic,strong) UIView * viMianView;

@end
@implementation RepaymentPlanAlertView

-(instancetype)initWithArrData:(NSArray *)arrData{
    if (self = [super init]) {
        _arrData = arrData;
        [self setBackgroundColor:[UIColor clearColor]];
        
        [self configAddSubview];
        [self configSubviewFrame];
    }
    return self;
}

#pragma mark ---
-(void)configAddSubview{
    [self addSubview:self.viMianView];
    [_viMianView addSubview:self.headBtn];
    [_viMianView addSubview:self.tableView];
    [self addSubview:self.btnCloseBtn];
    
}
-(void)configSubviewFrame{
    [self setFrame:CGRectMake(0, 0, AdaptedWidth(320), 100)];
    [_viMianView setFrame:CGRectMake(0, 0, AdaptedWidth(320), AdaptedWidth(100))];
    [_headBtn setFrame:CGRectMake(0, 0, _viMianView.width, AdaptedWidth(50))];
    [_btnCloseBtn setFrame:CGRectMake(0, 0, AdaptedWidth(60), AdaptedWidth(60))];
    _tableView.top = _headBtn.bottom;
    if (_arrData.count>=6) {
        _tableView.height = AdaptedWidth(60)*6;
    }else{
        _tableView.height = _arrData.count*AdaptedWidth(60);
    }
    _tableView.scrollEnabled = _arrData.count>6?YES:NO;
    _viMianView.height = _tableView.bottom+AdaptedWidth(12);
    _btnCloseBtn.top = _viMianView.bottom+AdaptedWidth(5);
    _btnCloseBtn.centerX = _viMianView.width/2.;
    self.height = _btnCloseBtn.bottom;
}
-(void)showAlertView{
    _alertView = [[WJYAlertView alloc]initWithCustomView:self dismissWhenTouchedBackground:NO];
    [_alertView show];
    
}
#pragma mark ---Action
-(void)btnCloseBtnClick:(UIButton*)btn{
    MJWeakSelf
    [_alertView dismissWithCompletion:^{
        if (weakSelf.blockCloseClick) {
            weakSelf.blockCloseClick();
        }
    }];
}


#pragma mark --- delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _arrData.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  AdaptedWidth(60);
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RepaymentTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellId_f];
    cell.nperInfoModel = _arrData[indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}
#pragma mark --- set/get
-(UIView*)viMianView{
    if (!_viMianView) {
        _viMianView = [[UIView alloc]init];
        [_viMianView setBackgroundColor:[UIColor whiteColor]];
        [_viMianView.layer setCornerRadius:8];
        _viMianView.clipsToBounds = YES;
    }
    return _viMianView;
}
-(UIButton*)headBtn{
    if (!_headBtn) {
        _headBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_headBtn setTitle:@"还款计划" forState:UIControlStateNormal];
        [_headBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _headBtn.titleLabel.font = [UIFont systemFontOfSize:AdaptedWidth(18)];
        [_headBtn setBackgroundColor:[UIColor colorWithHexString:@"2BADF0"]];
        _headBtn.userInteractionEnabled = NO;
    }
    return _headBtn;
}
-(UITableView *)tableView{
    if (!_tableView) {
        CGRect rect = CGRectMake(0, 0,AdaptedWidth(320), AdaptedWidth(100));
        _tableView = [[UITableView alloc]initWithFrame:rect style:UITableViewStyleGrouped];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        UIView * headView = [[UIView alloc]init];
        [headView setBackgroundColor:[UIColor clearColor]];
        headView.height = .01;
        _tableView.tableHeaderView = headView;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[RepaymentTableViewCell class] forCellReuseIdentifier:CellId_f];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}
-(UIButton *)btnCloseBtn{
    if (!_btnCloseBtn) {
        _btnCloseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnCloseBtn setImage:[UIImage imageNamed:@"closeWhite"] forState:UIControlStateNormal];
        [_btnCloseBtn addTarget:self action:@selector(btnCloseBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnCloseBtn;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

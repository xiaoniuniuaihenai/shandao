//
//  ZTMXFUpgradeAlertView.m
//  ZTMXFXunMiaoiOS
//
//  Created by 陈传亮 on 2018/4/20.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "ZTMXFUpgradeAlertView.h"
#import "ZTMXFUpgradeAlertCell.h"

@interface ZTMXFUpgradeAlertView ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, copy)NSString * version;

@property (nonatomic, copy)NSArray * descArr;

@property (nonatomic, copy)NSString * appUrl;


@property (nonatomic, assign)XLUpgradeAlertType upgradeAlertType;

@property (nonatomic, strong)UIButton * mainBtn;

@property (nonatomic, strong)UITableView * tableView;

@property (nonatomic, strong)UIButton * firstBtn;

@property (nonatomic, strong)UIButton * secondBtn;

@property (nonatomic, strong)UIButton * thirdBtn;

@property (nonatomic, strong)UILabel * titleLabel;

@property (nonatomic, strong)UIImageView * topImgView;








@end


@implementation ZTMXFUpgradeAlertView

+(void)showWithMessageArr:(NSArray *)messageArr version:(NSString *)version upgradeAlertType:(XLUpgradeAlertType)upgradeAlertType appUrlStr:(NSString *)appUrlStr
{
    ZTMXFUpgradeAlertView * alert = [[ZTMXFUpgradeAlertView alloc] init];
    alert.version = version;
    alert.appUrl  = appUrlStr;
    alert.descArr = messageArr;
    alert.upgradeAlertType = upgradeAlertType;
    [kKeyWindow addSubview:alert];
    [alert show];
}




- (void)setUpgradeAlertType:(XLUpgradeAlertType)upgradeAlertType
{
    switch (upgradeAlertType) {
        case XLUpgradeAlertDefault:
            [self.mainBtn addSubview:self.secondBtn];
            [self.mainBtn addSubview:self.thirdBtn];
            [self addLineView];
            break;
        case XLPermissionsForce:
            [self.mainBtn addSubview:self.firstBtn];
            break;
            
        default:
            break;
    }
}

- (void)addLineView
{
    UIView * hView = [[UIView alloc] initWithFrame:CGRectMake(0, self.secondBtn.top, _mainBtn.width, 1)];
    hView.backgroundColor = COLOR_SRT(@"#E6E6E6");
    [_mainBtn addSubview:hView];
    
    UIView * sView = [[UIView alloc] initWithFrame:CGRectMake(_mainBtn.width / 2 - 0.5, self.secondBtn.top, 1, 50 * PX)];
    sView.backgroundColor = COLOR_SRT(@"#E6E6E6");
    [_mainBtn addSubview:sView];
}
- (void)show
{
    _mainBtn.transform = CGAffineTransformMakeScale(0.7, 0.7);
    // 弹簧动画，参数分别为：时长，延时，弹性（越小弹性越大），初始速度
    [UIView animateWithDuration: 0.7 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.3 options:0 animations:^{
        // 放大
        _mainBtn.transform = CGAffineTransformMakeScale(1, 1);
    } completion:^(BOOL finished) {
        
    }];
}
- (id)init
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, KW, KH);
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.4f];
        _mainBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _mainBtn.frame = CGRectMake(0, 0, 300 * PX, 294 * PX);
        [self addSubview:_mainBtn];
        _mainBtn.backgroundColor = [UIColor whiteColor];
        _mainBtn.layer.cornerRadius = 4 * PX;
        _mainBtn.clipsToBounds = YES;
        _mainBtn.center = self.center;
        
//        UIView * wView = [[UIView alloc] initWithFrame:CGRectMake(0 , 0, _mainBtn.width, 80 * PX)];
//        wView.backgroundColor = K_GoldenColor;
//        [_mainBtn addSubview:wView];

        _topImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0 , 0, _mainBtn.width, 130 * PX)];
        _topImgView.image = [UIImage imageNamed:@"SJ_TopImg"];
        [_mainBtn addSubview:_topImgView];
        _topImgView.contentMode = UIViewContentModeScaleAspectFill;
        _topImgView.clipsToBounds = YES;
        
        
        UILabel *titleLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(26 * PX, 29 * PX, 150 * PX, 23 * PX)];
        titleLabel1.text = @"发现新版本";
        titleLabel1.textAlignment = NSTextAlignmentLeft;
        titleLabel1.textColor = [UIColor whiteColor];
        titleLabel1.font = FONT_Medium(22 * PX);
        [_mainBtn addSubview:titleLabel1];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(26*PX, titleLabel1.bottom + 2, 150*PX, 25*PX)];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.font = FONT_Medium(18 * PX);
        [_mainBtn addSubview:_titleLabel];
        [_mainBtn addSubview:self.tableView];
        
        
    }
    return self;
}


- (UITableView *)tableView
{
    if (!_tableView) {
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(25 * PX, _topImgView.bottom, (300 - 50) * PX, _mainBtn.height - _topImgView.height - 60 * PX) style:UITableViewStylePlain];
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0);

    }
    return _tableView;
}

#pragma mark -  TableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return _descArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // >>>>>>>>>>>>>>>>>>>>> * cell自适应步骤2 * >>>>>>>>>>>>>>>>>>>>>>>>
    
    
    //如果dataArray里面是字符串，那么model :传字符串，keyPath传@"text"
//    MYModel *model = dataArray[indexPath.row];
    
    NSString * desc = _descArr[indexPath.row];
    return [self.tableView cellHeightForIndexPath:indexPath model:desc keyPath:@"desc" cellClass:[ZTMXFUpgradeAlertCell class] contentViewWidth: (300 - 50) *PX];
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZTMXFUpgradeAlertCell * cell = [ZTMXFUpgradeAlertCell cellWithTableView:tableView];
    cell.desc = _descArr[indexPath.row];
    return cell;
}

- (void)setDescArr:(NSArray *)descArr
{
    if (_descArr != descArr) {
        _descArr = descArr;
    }
    [self.tableView reloadData];
}


- (void)setVersion:(NSString *)version
{
    _titleLabel.text = [NSString stringWithFormat:@"V%@", version];
}

- (UIButton *)firstBtn
{
    if (!_firstBtn) {
        _firstBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _firstBtn.frame = CGRectMake(25, _mainBtn.height - 56 * PX, _mainBtn.width - 50, 40 * PX );
        [_firstBtn setTitle:@"立即升级" forState:UIControlStateNormal];
        [_firstBtn addTarget:self action:@selector(setBtnAction) forControlEvents:UIControlEventTouchUpInside];
        _firstBtn.layer.cornerRadius = 3;
        CAGradientLayer * gradientLayer = [CAGradientLayer layer];
        gradientLayer.cornerRadius = 3;
        gradientLayer.frame = _firstBtn.bounds;
        gradientLayer.colors = @[(id)COLOR_SRT(@"#FFB447").CGColor,(id)COLOR_SRT(@"#FF7D22").CGColor];
        gradientLayer.startPoint = CGPointMake(0, 0);
        gradientLayer.endPoint = CGPointMake(1, 0);
        [_firstBtn.layer addSublayer:gradientLayer];
    }
    return _firstBtn;
}

- (UIButton *)secondBtn
{
    if (!_secondBtn) {
        _secondBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _secondBtn.frame = CGRectMake(0, _mainBtn.height - 50 * PX, _mainBtn.width / 2, 50 * PX );
        [_secondBtn setTitle:@"残忍拒绝" forState:UIControlStateNormal];
        [_secondBtn setTitleColor:COLOR_SRT(@"#999999") forState:UIControlStateNormal];
        [_secondBtn addTarget:self action:@selector(secondBtnAction) forControlEvents:UIControlEventTouchUpInside];
        _secondBtn.titleLabel.font = FONT_Regular(16 * PX );
        
    }
    return _secondBtn;
}

- (UIButton *)thirdBtn
{
    if (!_thirdBtn) {
        _thirdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _thirdBtn.frame = CGRectMake(_mainBtn.width / 2, _mainBtn.height - 50 * PX, _mainBtn.width / 2, 50 * PX );
        [_thirdBtn setTitleColor:COLOR_SRT(@"#FFA13A") forState:UIControlStateNormal];
        [_thirdBtn setTitle:@"立即升级" forState:UIControlStateNormal];
        _thirdBtn.titleLabel.font = FONT_Medium(16 * PX );
        [_thirdBtn addTarget:self action:@selector(setBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _thirdBtn;
}



- (void)secondBtnAction
{
    [UIView animateWithDuration:.3 animations:^{
        _mainBtn.transform = CGAffineTransformMakeScale(0.01, 0.01);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)setAppUrl:(NSString *)appUrl
{
    _appUrl = appUrl;
}

- (void)setBtnAction
{
//    NSString * appUrlStr = [appUrl encodingStringUsingURLEscape];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:_appUrl]];
  
}







/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

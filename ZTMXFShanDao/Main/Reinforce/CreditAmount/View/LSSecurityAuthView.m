//
//  LSSecurityAuthView.m
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2017/12/27.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "LSSecurityAuthView.h"

@interface LSSecurityAuthView ()

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIView *firstView;

@property (nonatomic, strong) UIView *secondView;

@end

@implementation LSSecurityAuthView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self configueSubViews];
    }
    return self;
}


#pragma mark - 按钮点击事件
- (void)serviceButtonAction{
    if (self.delegete && [self.delegete respondsToSelector:@selector(clickServiceButtonAction)]) {
        [self.delegete clickServiceButtonAction];
    }
}

#pragma mark - setter
- (void)setLoanType:(LoanType)loanType{
    if (loanType == WhiteLoanType) {
        // 白领贷
    } else if (loanType == MallLoanType) {
        // 消费分期
        self.titleLabel.text = @"电商认证（至少认证一个哦）";
        UIImageView *imageViewOne = [self.firstView viewWithTag:1000];
        imageViewOne.image = [UIImage imageNamed:@"jingdongAuth"];
        UILabel *titleLabelOne = [self.firstView viewWithTag:1001];
        titleLabelOne.text = @"京东认证";
        
        UIImageView *imageViewTwo = [self.secondView viewWithTag:1000];
        imageViewTwo.image = [UIImage imageNamed:@"taobaoAuth"];
        UILabel *titleLabelTwo = [self.secondView viewWithTag:1001];
        titleLabelTwo.text = @"淘宝认证";
    }
}
#pragma mark - 点击去认证
- (void)btnAuthBtnClick:(UIButton *)sender{
    if (self.delegete && [self.delegete respondsToSelector:@selector(clickSecurityAuthBtn:)]) {
        [self.delegete clickSecurityAuthBtn:sender.tag];
    }
}



#pragma mark - 设置子视图
- (void)configueSubViews{
    
    UILabel *redLabel = [[UILabel alloc] initWithFrame:CGRectMake(18, 59, 2, 13)];
    [redLabel setBackgroundColor:[UIColor colorWithHexString:@"FF795C"]];
    [self addSubview:redLabel];
    
    self.titleLabel = [UILabel labelWithTitleColor:[UIColor colorWithHexString:COLOR_GRAY_STR] fontSize:AdaptedWidth(15) alignment:NSTextAlignmentLeft];
    [self.titleLabel setFrame:CGRectMake(redLabel.right+6.0, 10.0, SCREEN_WIDTH-50.0, 21)];
    [self.titleLabel setText:@"认证社保/公积金（可二选一）"];
    redLabel.centerY = self.titleLabel.centerY;
    [self addSubview:self.titleLabel];
    
    self.firstView = [self createViewWithIcon:@"securityAuth_selected" title:@"社保认证" buttonTag:1];
    self.firstView.top = self.titleLabel.bottom + 20.0;
    [self addSubview:self.firstView];
    
    self.secondView = [self createViewWithIcon:@"fundAuth_selected" title:@"公积金认证" buttonTag:2];
    self.secondView.top = self.firstView.bottom + 26.0;
    [self addSubview:self.secondView];
    
    UIButton *serviceButton = [UIButton setupButtonTitle:@"如有疑问，点击这里>>" titleColor:COLOR_GRAY_STR anotherColorTitle:@"点击这里>>" anotherColor:COLOR_BLUE_STR titleFont:12 withObject:self action:@selector(serviceButtonAction)];
    serviceButton.frame = CGRectMake(0.0, 80.0, Main_Screen_Width, 20.0);
    serviceButton.bottom = self.height - 22.0;
//    [self addSubview:serviceButton];
}

- (UIView *)createViewWithIcon:(NSString *)icon title:(NSString *)title buttonTag:(NSInteger)tag{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(18, 0, SCREEN_WIDTH-36, 174)];
    view.layer.cornerRadius = 4.0;
    view.layer.masksToBounds = YES;
    view.backgroundColor = [UIColor colorWithHexString:@"E9F8FF"];
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 25, 35, 35)];
    imgView.centerX = view.width/2.;
    imgView.image = [UIImage imageNamed:icon];
    [view addSubview:imgView];
    imgView.tag = 1000;
    
    UILabel *titleLabel = [UILabel labelWithTitleColor:[UIColor colorWithHexString:COLOR_GRAY_STR] fontSize:AdaptedWidth(16) alignment:NSTextAlignmentCenter];
    [titleLabel setFrame:CGRectMake(0, imgView.bottom + 11.0, view.width, 22)];
    titleLabel.text = title;
    [view addSubview:titleLabel];
    titleLabel.tag = 1001;
    
    XLButton *button = [XLButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0,titleLabel.bottom + 23.0, AdaptedWidth(200), 36.0)];
    button.titleLabel.font = [UIFont systemFontOfSize:AdaptedWidth(16)];
    button.clipsToBounds = YES;
    button.centerX = view.width/2.;
    [button setTitle:@"去认证" forState:UIControlStateNormal];
    button.tag = tag;
    [button addTarget:self action:@selector(btnAuthBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    
    return view;
}

@end

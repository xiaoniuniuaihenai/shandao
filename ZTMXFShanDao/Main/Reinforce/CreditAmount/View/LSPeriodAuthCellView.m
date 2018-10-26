//
//  LSPeriodAuthCellView.m
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2018/1/8.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "LSPeriodAuthCellView.h"

@interface LSPeriodAuthCellView ()

@property (nonatomic, strong) UIImageView *iconImgView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIImageView *authStatusView;

@property (nonatomic, strong) UILabel *authStatusLabel;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *icon;

@end

@implementation LSPeriodAuthCellView

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title icon:(NSString *)icon;
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 4.0;
        
        self.title = title;
        self.icon = icon;
        [self configueSubViews];
    }
    return self;
}



#pragma mark - 设置子视图
- (void)configueSubViews
{
    self.iconImgView = [[UIImageView alloc] initWithFrame:CGRectMake(AdaptedWidth(37.0), AdaptedHeight(28.0), 30.0, 30.0)];
    self.iconImgView.centerY = self.height/2.;
    self.iconImgView.image = [UIImage imageNamed:self.icon];
    [self addSubview:self.iconImgView];
    
    self.titleLabel = [UILabel labelWithTitleColor:[UIColor colorWithHexString:@"5C5C5C"] fontSize:16 alignment:NSTextAlignmentLeft];
    [self.titleLabel setFrame:CGRectMake(_iconImgView.right+AdaptedWidth(17.0), AdaptedHeight(27.0), self.width/2., AdaptedHeight(22.0))];
    self.titleLabel.text = self.title;
    [self addSubview:self.titleLabel];
    
    self.authStatusLabel = [UILabel labelWithTitleColor:[UIColor colorWithHexString:@"FB8E77"] fontSize:12 alignment:NSTextAlignmentCenter];
    [self.authStatusLabel setFrame:CGRectMake(0.0, AdaptedHeight(29.0), 57.0, 22.0)];
    self.authStatusLabel.right = self.width - AdaptedWidth(37.0);
    self.authStatusLabel.centerY = self.titleLabel.centerY;
    self.authStatusLabel.layer.cornerRadius = 4.0;
    self.authStatusLabel.layer.borderWidth = 1.0;
    self.authStatusLabel.layer.borderColor = [UIColor colorWithHexString:@"FB8E77"].CGColor;
    [self addSubview:self.authStatusLabel];
    self.authStatusLabel.text = @"去认证";
    
    self.authStatusView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, AdaptedHeight(27.0), 17.0, 15.0)];
    self.authStatusView.right = self.authStatusLabel.right;
    self.authStatusView.bottom = self.authStatusLabel.bottom;
    self.authStatusView.image = [UIImage imageNamed:@"authed_icon"];
    [self addSubview:self.authStatusView];
    self.authStatusView.hidden = YES;
    
    self.lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(AdaptedWidth(41.0), AdaptedHeight(70.0), self.width-AdaptedWidth(82.0), 1.0)];
    [UIView drawDashLine:self.lineLabel lineLength:4.0 lineSpacing:4.0 lineColor:[UIColor colorWithHexString:@"EAEAEA"]];
    [self addSubview:self.lineLabel];
}
#pragma mark - setter
- (void)setAuthStatus:(NSInteger)authStatus
{
    UIColor *color = [UIColor colorWithHexString:@"FB8E77"];
    if (authStatus == 0) {
        // 未认证
        self.authStatusLabel.text = @"去认证";
        self.authStatusView.hidden = YES;
    } else if (authStatus == 1) {
        // 已认证
        self.authStatusLabel.text = @"已认证";
        color = [UIColor colorWithHexString:@"FF994A"];
        self.authStatusView.hidden = NO;
    } else if (authStatus == 2) {
        // 认证中
        self.authStatusLabel.text = @"认证中...";
        color = [UIColor colorWithHexString:@"46B7F1"];
        self.authStatusView.hidden = YES;
    } else if (authStatus == -1) {
        // 认证失败
        self.authStatusLabel.text = @"认证失败";
        color = [UIColor colorWithHexString:COLOR_LIGHT_GRAY_STR];
        self.authStatusView.hidden = YES;
    }
    self.authStatusLabel.textColor = color;
    self.authStatusLabel.layer.borderColor = color.CGColor;
}
@end

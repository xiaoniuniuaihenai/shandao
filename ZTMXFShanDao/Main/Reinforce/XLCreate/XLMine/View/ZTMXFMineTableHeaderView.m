//
//  ZTMXFMineTableHeaderView.m
//  ZTMXFXunMiaoiOS
//
//  Created by 余金超 on 2018/5/15.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "ZTMXFMineTableHeaderView.h"
#import "ZTMXFMineFirstSectionItem.h"

#define K_Cell @"cell"

@interface ZTMXFMineTableHeaderView ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) UIImageView *bgImageView;//下拉放大的背景图
@property (nonatomic, strong) UIImageView *iconView;//用户头像
@property (nonatomic, strong) UILabel     *userPhoneLabel;//用户手机号
@property (nonatomic, strong) UIButton    *loginButton;//登录按钮
@property (nonatomic, strong) UILabel     *jiZuLabel;

@property (nonatomic, strong) UIView *headTrayView;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, assign) CGFloat heightED;

@end

@implementation ZTMXFMineTableHeaderView

- (void)setLoginButtonHidden:(BOOL)loginButtonHidden{
    _loginButtonHidden = loginButtonHidden;
    if (loginButtonHidden) {
        _jiZuLabel.hidden = YES;
        _loginButton.hidden = YES;
        _userPhoneLabel.hidden = NO;
        _iconView.hidden = NO;
        NSString *text = k_USER_DEFAULT(kUserPhoneNumber);
        if (text.length == 11) {
            text = [text stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
        }
        self.userPhoneLabel.text = text;
    }else{
        _jiZuLabel.hidden = NO;
        _loginButton.hidden = NO;
        _userPhoneLabel.hidden = YES;
        _iconView.hidden = NO;
        self.userPhoneLabel.text = @"";
    }
}



- (void)configUI{
    [self addSubview:self.bgImageView];
    [self addSubview:self.headTrayView];
    [self.headTrayView addSubview:self.collectionView];
    [self addSubview:self.iconView];
    [self addSubview:self.userPhoneLabel];
    [self addSubview:self.loginButton];
//    [self addSubview:self.jiZuLabel];
    
    
    self.backgroundColor = UIColor.whiteColor;
    
    self.bgImageView.sd_layout
    .leftEqualToView(self)
    .rightEqualToView(self)
    .topEqualToView(self)
    .bottomSpaceToView(self, X(55));
    
    self.headTrayView.sd_layout
    .leftSpaceToView(self, X(15))
    .rightSpaceToView(self, X(15))
    .bottomSpaceToView(self, X(10))
    .heightIs(X(91));
    
    self.collectionView.sd_layout
    .leftEqualToView(self.headTrayView)
    .topEqualToView(self.headTrayView)
    .rightEqualToView(self.headTrayView)
    .bottomEqualToView(self.headTrayView);
    
    self.iconView.sd_layout
    .leftSpaceToView(self, X(18))
    .bottomSpaceToView(self.headTrayView, X(15))
    .widthIs(X(55))
    .heightIs(X(55));
    
    self.userPhoneLabel.sd_layout
    .leftSpaceToView(self.iconView, X(13))
    .centerYEqualToView(self.iconView)
    .widthIs(X(180))
    .heightIs(X(28));
    
    self.loginButton.sd_layout
    .leftSpaceToView(self.iconView, X(13))
    .centerYEqualToView(self.iconView)
    .widthIs(X(100))
    .heightIs(X(40));
    
//    self.jiZuLabel.sd_layout
//    .leftEqualToView(self)
//    .rightEqualToView(self)
//    .bottomSpaceToView(self.loginButton, X(13))
//    .heightIs(X(50));
}

- (void)loginButtonClick{
    if (self.loginButtonClickBlock) {
        self.loginButtonClickBlock();
    }
}
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.frame = frame;
        [self configUI];
    }
    return self;
}
- (UILabel *)jiZuLabel{
    if (!_jiZuLabel) {
        _jiZuLabel = [[UILabel alloc]init];
        _jiZuLabel.font = FONT_Regular(X(36));
        _jiZuLabel.textColor = COLOR_SRT(@"000000");
        _jiZuLabel.textAlignment = NSTextAlignmentCenter;
        _jiZuLabel.text = @"闪到";
    }
    return _jiZuLabel;
}

- (UIView *)headTrayView
{
    if (!_headTrayView) {
        _headTrayView = [[UIView alloc] init];
        _headTrayView.backgroundColor = [UIColor whiteColor];
        _headTrayView.layer.cornerRadius = 5.f;
        _headTrayView.layer.shadowColor = [UIColor blackColor].CGColor;
        _headTrayView.layer.shadowOffset = CGSizeMake(0.f, 3.f);
        _headTrayView.layer.shadowOpacity = 0.5f;
        _headTrayView.layer.shadowRadius = 3.f;
    }
    return _headTrayView;
}


- (UIButton *)loginButton{
    if (!_loginButton) {
        _loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        _loginButton.layer.cornerRadius = X(20);
        [_loginButton setTitle:@"我要登录" forState:UIControlStateNormal];
        [_loginButton setTitle:@"我要登录" forState:UIControlStateHighlighted];
        _loginButton.titleLabel.textAlignment = NSTextAlignmentLeft;
        _loginButton.backgroundColor = [UIColor clearColor];
        [_loginButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        [_loginButton setBackgroundImage:[UIImage imageWithColor:K_MainColor] forState:UIControlStateNormal];
//        [_loginButton setBackgroundImage:[UIImage imageWithColor:K_MainColor] forState:UIControlStateHighlighted];
        [_loginButton addTarget:self action:@selector(loginButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginButton;
}

- (UILabel *)userPhoneLabel{
    return _userPhoneLabel?:({
        _userPhoneLabel = [[UILabel alloc]init];
        _userPhoneLabel.font = FONT_Medium(X(20));
        _userPhoneLabel.textColor = K_333333;
        _userPhoneLabel;
    });
}

- (UIImageView *)iconView{
    return _iconView?:({
        _iconView = [[UIImageView alloc] init];
        _iconView.layer.cornerRadius = X(30);
        _iconView.image = [UIImage imageNamed:@"user_center_usericon_def"];
        _iconView;
    });
}

- (UIImageView *)bgImageView{
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc]init];
        _bgImageView.contentMode = UIViewContentModeScaleAspectFill;
        _bgImageView.layer.masksToBounds = YES;
        _bgImageView.image = [UIImage imageNamed:@"user_center_top_back"];
        _bgImageView.tag = 1001;
    }
    return _bgImageView;
}


#pragma mark ====== init ======
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        CGFloat itemWidth = ![LoginManager appReviewState]? ((KW - X(30) - 2)/ 4.f) : ((KW - X(30) - 2)/ 3.f);
        layout.itemSize = CGSizeMake(itemWidth, X(72));
        layout.minimumInteritemSpacing = 0.f;
        layout.minimumLineSpacing = 0.f;
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, X(23), KW, [[self class] cellHeight] - X(23)) collectionViewLayout:layout];
        _collectionView.backgroundColor = UIColor.redColor;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[ZTMXFMineFirstSectionItem class] forCellWithReuseIdentifier:K_Cell];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        //        _collectionView.scrollEnabled = NO;
        _collectionView.backgroundColor = [UIColor whiteColor];
    }
    return _collectionView;
}

#pragma mark ====== UICollectionViewDelegate ======
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    //    if (self.dataAry.count == 0) {
    //        return 1;
    //    } else {
    return self.dataAry.count;
    //    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ZTMXFMineFirstSectionItem *cell = [collectionView dequeueReusableCellWithReuseIdentifier:K_Cell forIndexPath:indexPath];
    cell.dict = self.dataAry[indexPath.row];
    [self updateCollectionViewHeight:self.collectionView.collectionViewLayout.collectionViewContentSize.height];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.itemSeletedBlock) {
        self.itemSeletedBlock([[self.dataAry[indexPath.row] allKeys]firstObject]);
    }
}

- (void)updateCollectionViewHeight:(CGFloat)height {
    if (self.heightED != height) {
        self.heightED = height;
        self.collectionView.frame = CGRectMake(0, X(23), self.collectionView.frame.size.width, height);
    }
}

+ (CGFloat)cellHeight{
    return X(118);
}

- (void)setDataAry:(NSArray *)dataAry {
    self.heightED = 0;
    _dataAry = dataAry;
    [_collectionView reloadData];
}

@end

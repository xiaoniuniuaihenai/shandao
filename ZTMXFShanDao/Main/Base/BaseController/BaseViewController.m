//
//  BaseViewController.m
//  MobileProject
//
//  Created by wujunyang on 16/1/5.
//  Copyright © 2016年 wujunyang. All rights reserved.
//

#import "BaseViewController.h"
#import "TabBarControllerConfig.h"
#import "LSBorrowMoneyViewModel.h"
#import "ZTMXFServerStatisticalHelper.h"

@interface BaseViewController ()
{
    CGFloat navigationY;
    CGFloat navBarY;
    CGFloat verticalY;
    BOOL _isShowMenu;
}
@property CGFloat original_height;
@end

@implementation BaseViewController

-(id)init
{
    if (self= [super init]) {
        navBarY = 0;
        navigationY = 0;
    }
    return self;
}


-(void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.barTintColor = K_NavColor;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]}];
    self.extendedLayoutIncludesOpaqueBars = YES;
    [self.navigationController.navigationBar setTranslucent:NO];
    [self.navigationController setNavigationBarHidden:NO];
    self.view.backgroundColor = [UIColor whiteColor];
    if (self.navigationController.viewControllers.count > 1) {
        [self addReturnBackButton];
    }
    
    if ([self respondsToSelector:@selector(backgroundImage)]) {
        UIImage *bgimage = [self navBackgroundImage];
        [self setNavigationBack:bgimage];
    }
    if ([self respondsToSelector:@selector(setTitle)]) {
        NSMutableAttributedString *titleAttri = [self setTitle];
        [self set_Title:titleAttri];
    }
    if (![self leftButton]) {
        [self configLeftBaritemWithImage];
    }
    
    if (![self rightButton]) {
        [self configRightBaritemWithImage];
    }
    
    //监听网络变化
    Reachability *reach = [Reachability reachabilityWithHostName:kURL_Reachability__Address];
    self.hostReach = reach;
    [[NSNotificationCenter defaultCenter]addObserver:self  selector:@selector(netStatusChange:) name:kReachabilityChangedNotification object:nil];
    //实现监听
    [reach startNotifier];
    //设置侧滑的距离
    self.fd_interactivePopMaxAllowedInitialDistanceToLeftEdge = 120.0;
}




-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    if ([self respondsToSelector:@selector(set_colorBackground)]) {
        UIColor *backgroundColor =  [self set_colorBackground];
        UIImage *bgimage = [UIImage imageWithColor:backgroundColor];
        [self.navigationController.navigationBar setBackgroundImage:bgimage forBarMetrics:UIBarMetricsDefault];
    }
    
    UIImageView* blackLineImageView = [self findHairlineImageViewUnder:self.navigationController.navigationBar];
    //默认显示黑线
    blackLineImageView.hidden = NO;
    if ([self respondsToSelector:@selector(hideNavigationBottomLine)]) {
        if ([self hideNavigationBottomLine]) {
            //隐藏黑线
            blackLineImageView.hidden = YES;
        }
    }
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [ZTMXFServerStatisticalHelper loanStatisticalApiWithIntoTime:[NSDate date] CurrentClassName:NSStringFromClass([self class]) PageName:self.pageName];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [ZTMXFServerStatisticalHelper loanStatisticalApiWithIoutTime:[NSDate date] CurrentClassName:NSStringFromClass([self class]) PageName:self.pageName];
}

- (NSDate *)creatTime{
    if (!_creatTime) {
        _creatTime = [NSDate date];
    }
    return _creatTime;
}

-(void)dealloc
{
    //移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

//通知监听回调 网络状态发送改变 系统会发出一个kReachabilityChangedNotification通知，然后会触发此回调方法
- (void)netStatusChange:(NSNotification *)noti{
//    NSLog(@"-----%@",noti.userInfo);
    //判断网络状态
    switch (self.hostReach.currentReachabilityStatus) {
        case NotReachable:
            break;
        case ReachableViaWiFi:
            [LSBorrowMoneyViewModel changeTabBarTextAndImage];
//            NSLog(@"wifi上网2");
            break;
        case ReachableViaWWAN:
//            NSLog(@"手机上网2");
            [LSBorrowMoneyViewModel changeTabBarTextAndImage];
            break;
        default:
            break;
    }
}

-(void)setNavigationBack:(UIImage*)image
{
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
    [self.navigationController.navigationBar setBackIndicatorTransitionMaskImage:image ];
    [self.navigationController.navigationBar setShadowImage:image];
}

#pragma mark --- NORMAl

-(void)set_Title:(NSMutableAttributedString *)title
{
    UILabel *navTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 120, 44)];
    navTitleLabel.numberOfLines=0;//可能出现多行的标题
    [navTitleLabel setAttributedText:title];
    navTitleLabel.textAlignment = NSTextAlignmentCenter;
    navTitleLabel.backgroundColor = [UIColor clearColor];
    navTitleLabel.userInteractionEnabled = YES;
    navTitleLabel.textColor = [UIColor blackColor];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(titleClick:)];
    [navTitleLabel addGestureRecognizer:tap];
    self.navigationItem.titleView = navTitleLabel;
}


-(void)titleClick:(UIGestureRecognizer*)Tap
{
    UIView *view = Tap.view;
    if ([self respondsToSelector:@selector(title_click_event:)]) {
        [self title_click_event:view];
    }
}

#pragma mark -- left_item
-(void)configLeftBaritemWithImage
{
    if ([self respondsToSelector:@selector(set_leftBarButtonItemWithImage)]) {
        UIImage *image = [self set_leftBarButtonItemWithImage];
        UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithImage:image style:UIBarButtonItemStylePlain target:self  action:@selector(left_click:)];
        self.navigationItem.backBarButtonItem = item;
    }
}

-(void)configRightBaritemWithImage
{
    if ([self respondsToSelector:@selector(set_rightBarButtonItemWithImage)]) {
        UIImage *image = [self set_rightBarButtonItemWithImage];
        UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithImage:image style:UIBarButtonItemStylePlain target:self  action:@selector(right_click:)];
        self.navigationItem.rightBarButtonItem = item;
    }
}


#pragma mark -- left_button
-(BOOL)leftButton
{
    BOOL isleft =  [self respondsToSelector:@selector(set_leftButton)];
    if (isleft) {
        UIButton *leftbutton = [self set_leftButton];
        [leftbutton addTarget:self action:@selector(left_click:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:leftbutton];
        self.navigationItem.leftBarButtonItem = item;
    }
    return isleft;
}

- (void)addReturnBackButton{
    UIButton *returnBack = [UIButton buttonWithType:UIButtonTypeCustom];
    returnBack. frame=CGRectMake(15, 5, 38, 38);
    [returnBack setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
    returnBack.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [returnBack addTarget:self action:@selector(clickReturnBackEvent)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *returnBackItem=[[UIBarButtonItem alloc] initWithCustomView:returnBack];
    //设置导航栏的leftButton
    self.navigationItem.leftBarButtonItem = returnBackItem;
}

//  点击返回上一个页面
- (void)clickReturnBackEvent{
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -- right_button
-(BOOL)rightButton
{
    BOOL isright = [self respondsToSelector:@selector(set_rightButton)];
    if (isright) {
        UIButton *right_button = [self set_rightButton];
        [right_button addTarget:self action:@selector(right_click:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:right_button];
        self.navigationItem.rightBarButtonItem = item;
    }
    return isright;
}


-(void)left_click:(id)sender
{
    if ([self respondsToSelector:@selector(left_button_event:)]) {
        [self left_button_event:sender];
    }
}

-(void)right_click:(id)sender
{
    if ([self respondsToSelector:@selector(right_button_event:)]) {
        [self right_button_event:sender];
    }
}

-(void)changeNavigationBarHeight:(CGFloat)offset
{
    [UIView animateWithDuration:0.3f animations:^{
        self.navigationController.navigationBar.frame  = CGRectMake(
                                                                    self.navigationController.navigationBar.frame.origin.x,
                                                                    navigationY,
                                                                    self.navigationController.navigationBar.frame.size.width,
                                                                    offset
                                                                    );
    }];
    
}

-(void)changeNavigationBarTranslationY:(CGFloat)translationY
{
    self.navigationController.navigationBar.transform = CGAffineTransformMakeTranslation(0, translationY);
}

//找查到Nav底部的黑线
- (UIImageView *)findHairlineImageViewUnder:(UIView *)view
{
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0)
    {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        imageView.image = [UIImage imageNamed:@"navBar_bottom_line"];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}

/** 设置右侧导航栏的右侧title按钮 */
- (void)setNavgationBarRightTitle:(NSString *)title{
    self.navigationItem.rightBarButtonItem = nil;
    if (title) {
        UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        rightButton.titleLabel.font = [UIFont systemFontOfSize:15];
        CGFloat titleWidth = [title sizeWithFont:rightButton.titleLabel.font maxW:MAXFLOAT].width;
        [rightButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
        rightButton.frame = CGRectMake(0.0, 0.0, titleWidth, 44.0);
        [rightButton setTitle:title forState:UIControlStateNormal];
        [rightButton addTarget:self action:@selector(right_click:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
        self.navigationItem.rightBarButtonItem = item;
    }
}

/** 设置右侧导航栏的右侧图片按钮 */
- (void)setNavgationBarRightImageStr:(NSString *)imageStr{
    self.navigationItem.rightBarButtonItem = nil;
    UIImage *rightImage = [UIImage imageNamed:imageStr];
    if (rightImage) {
        UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [rightButton setImage:rightImage forState:UIControlStateNormal];
        [rightButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
        rightButton.frame = CGRectMake(0.0, 0.0, 40.0, 44.0);
        [rightButton addTarget:self action:@selector(right_click:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
        self.navigationItem.rightBarButtonItem = item;
    }
}

/** 设置右侧导航栏的左侧title按钮 */
- (void)setNavgationBarLeftTitle:(NSString *)title{
    self.navigationItem.leftBarButtonItem = nil;
    if (title) {
        UIButton *leftbutton = [UIButton buttonWithType:UIButtonTypeCustom];
        [leftbutton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        leftbutton.titleLabel.font = [UIFont systemFontOfSize:15];
        [leftbutton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        leftbutton.frame = CGRectMake(0.0, 0.0, 120.0, 44.0);
        [leftbutton setTitle:title forState:UIControlStateNormal];
        [leftbutton addTarget:self action:@selector(left_click:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:leftbutton];
        self.navigationItem.leftBarButtonItem = item;
    }

}
/** 设置右侧导航栏的左侧图片按钮 */
- (void)setNavgationBarLeftImageStr:(NSString *)imageStr{
    self.navigationItem.leftBarButtonItem = nil;
    UIImage *leftImage = [UIImage imageNamed:imageStr];
    if (leftImage) {
        UIButton *leftbutton = [UIButton buttonWithType:UIButtonTypeCustom];
        [leftbutton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        leftbutton.titleLabel.font = [UIFont systemFontOfSize:15];
        [leftbutton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        leftbutton.frame = CGRectMake(0.0, 0.0, 120.0, 44.0);
        [leftbutton setImage:leftImage forState:UIControlStateNormal];
        [leftbutton addTarget:self action:@selector(left_click:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:leftbutton];
        self.navigationItem.leftBarButtonItem = item;
    }
}


@end

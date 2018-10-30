//
//  TabBarControllerConfig.m
//  CoreFrame
//
//  Created by yangpenghua on 2017/8/29.
//  Copyright © 2017年 yangpenghua. All rights reserved.
//

#import "TabBarControllerConfig.h"
#import "ShanDaoH5ChangePageViewController.h"
static CGFloat const CYLTabBarControllerHeight = 40.f;

@implementation CYLBaseNavigationController

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        //  设置状态栏颜色
//        UIStatusBarStyleLightContent
        if ([UIApplication sharedApplication].statusBarStyle != UIStatusBarStyleDefault) {
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
        }
    }
    [super pushViewController:viewController animated:animated];
}

@end

#import "ZTMXFHomePageViewController.h"
#import "LSCreditAmountViewController.h"
#import "HWNewfeatureViewController.h"
#import "ShanDaoLoanPageViewController.h"
#import "AppDelegate.h"
#import "LoginManager.h"

#import "XLMineViewController.h"

@interface TabBarControllerConfig ()<UITabBarControllerDelegate>

@property (nonatomic, readwrite, strong) CYLTabBarController *tabBarController;

@end

@implementation TabBarControllerConfig

/**
 *  lazy load tabBarController
 *
 *  @return CYLTabBarController
 */
- (CYLTabBarController *)tabBarController {
    if (_tabBarController == nil) {
        /**
         * 以下两行代码目的在于手动设置让TabBarItem只显示图标，不显示文字，并让图标垂直居中。
         * 等效于在 `-tabBarItemsAttributesForController` 方法中不传 `CYLTabBarItemTitle` 字段。
         * 更推荐后一种做法。
         */
        UIEdgeInsets imageInsets = UIEdgeInsetsZero;//UIEdgeInsetsMake(4.5, 0, -4.5, 0);
//        UIOffset titlePositionAdjustment = UIOffsetZero;//UIOffsetMake(0, MAXFLOAT);
        UIOffset titlePositionAdjustment = UIOffsetMake(0, -3);//UIOffsetMake(0, MAXFLOAT);

        CYLTabBarController *tabBarController = [CYLTabBarController tabBarControllerWithViewControllers:self.viewControllers
                                                                                   tabBarItemsAttributes:self.tabBarItemsAttributesForController
                                                                                             imageInsets:imageInsets
                                                                                 titlePositionAdjustment:titlePositionAdjustment];

        [self customizeTabBarAppearance:tabBarController];
        _tabBarController = tabBarController;
    }
    return _tabBarController;
}



- (NSArray *)tabBarItemsAttributesForController {
    NSDictionary *firstTabBarItemsAttributes = @{
                                                 CYLTabBarItemTitle :@"闪到",
                                                 CYLTabBarItemImage : @"XL_TAB_ShangCheng_W",  /* NSString and UIImage are supported*/
                                                 CYLTabBarItemSelectedImage : @"XL_TAB_ShangCheng", /* NSString and UIImage are supported*/
                                                 };
    NSDictionary *loanTabBarItemsAttributes;
    if ([LoginManager appReviewState]) {
        loanTabBarItemsAttributes = @{
                                                    CYLTabBarItemTitle : @"推荐",
                                                    CYLTabBarItemImage : @"XL_TAB_FenLei_W",
                                                    CYLTabBarItemSelectedImage : @"XL_TAB_FenLei",
                                                    };
    }else{
        loanTabBarItemsAttributes = @{
                                      CYLTabBarItemTitle :@"提现",
                                      CYLTabBarItemImage : @"XL_TAB_JieQian_W",  /* NSString and UIImage are supported*/
                                      CYLTabBarItemSelectedImage : @"XL_TAB_JieQian", /* NSString and UIImage are supported*/
                                      };
    }
    
    
    
    NSDictionary *thirdTabBarItemsAttributes =  @{
                                                  CYLTabBarItemTitle : @"我的",
                                                  CYLTabBarItemImage : @"XL_TAB_GeRen_W",
                                                  CYLTabBarItemSelectedImage : @"XL_TAB_GeRen"
                                                  };
    NSArray *tabBarItemsAttributes = @[
                                       firstTabBarItemsAttributes,
                                       loanTabBarItemsAttributes,
                                       thirdTabBarItemsAttributes
                                       ];
    return tabBarItemsAttributes;
}
- (NSArray *)viewControllers {
    ZTMXFHomePageViewController *firstViewController = [[ZTMXFHomePageViewController alloc] init];
    UIViewController *firstNavigationController = [[CYLBaseNavigationController alloc] initWithRootViewController:firstViewController];
    //    LSLoanViewController
    ShanDaoH5ChangePageViewController *secondViewController = [[ShanDaoH5ChangePageViewController alloc] init];
    UIViewController *secondNavigationController = [[CYLBaseNavigationController alloc] initWithRootViewController:secondViewController];
    
    XLMineViewController *thirdViewController = [[XLMineViewController alloc] init];
    UIViewController *thirdNavigationController = [[CYLBaseNavigationController alloc] initWithRootViewController:thirdViewController];
    
    NSArray *viewControllers = @[
                                 firstNavigationController,
                                 secondNavigationController,
                                 thirdNavigationController,
                                 ];
    return viewControllers;
}
/**
 *  更多TabBar自定义设置：比如：tabBarItem 的选中和不选中文字和背景图片属性、tabbar 背景图片属性等等
 */
- (void)customizeTabBarAppearance:(CYLTabBarController *)tabBarController {
#warning CUSTOMIZE YOUR TABBAR APPEARANCE
    // Customize UITabBar height
    // 自定义 TabBar 高度
//         tabBarController.tabBarHeight = CYLTabBarControllerHeight;
    
    // set the text color for unselected state
    // 普通状态下的文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSForegroundColorAttributeName] = [UIColor colorWithHexString:COLOR_GRAY_STR];
    
    // set the text color for selected state
    // 选中状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = K_MainColor;
    
    // set the text Attributes
    // 设置文字属性
    UITabBarItem *tabBar = [UITabBarItem appearance];
    [tabBar setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [tabBar setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    
    // Set the dark color to selected tab (the dimmed background)
    // TabBarItem选中后的背景颜色
    // [self customizeTabBarSelectionIndicatorImage];
    
    // update TabBar when TabBarItem width did update
    // If your app need support UIDeviceOrientationLandscapeLeft or UIDeviceOrientationLandscapeRight，
    // remove the comment '//'
    // 如果你的App需要支持横竖屏，请使用该方法移除注释 '//'
    // [self updateTabBarCustomizationWhenTabBarItemWidthDidUpdate];
    
    // set the bar shadow image
    // This shadow image attribute is ignored if the tab bar does not also have a custom background image.So at least set somthing.
    [[UITabBar appearance] setBackgroundImage:[[UIImage alloc] init]];
    [[UITabBar appearance] setBackgroundColor:[UIColor whiteColor]];
    [[UITabBar appearance] setShadowImage:[UIImage imageNamed:@"tapbar_top_line"]];
    
    // set the bar background image
    // 设置背景图片
    //     UITabBar *tabBarAppearance = [UITabBar appearance];
    //     [tabBarAppearance setBackgroundImage:[UIImage imageNamed:@"tab_bar"]];
    
    // remove the bar system shadow image
    // 去除 TabBar 自带的顶部阴影
    // [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
}



- (void)customizeTabBarSelectionIndicatorImage {
    ///Get initialized TabBar Height if exists, otherwise get Default TabBar Height.
    CGFloat tabBarHeight = CYLTabBarControllerHeight;
    CGSize selectionIndicatorImageSize = CGSizeMake(CYLTabBarItemWidth, tabBarHeight);
    //Get initialized TabBar if exists.
    UITabBar *tabBar = [self cyl_tabBarController].tabBar ?: [UITabBar appearance];
    [tabBar setSelectionIndicatorImage:
     [[self class] imageWithColor:[UIColor yellowColor]
                             size:selectionIndicatorImageSize]];
}
- (void)updateTabBarCustomizationWhenTabBarItemWidthDidUpdate {
    void (^deviceOrientationDidChangeBlock)(NSNotification *) = ^(NSNotification *notification) {
        UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
        if ((orientation == UIDeviceOrientationLandscapeLeft) || (orientation == UIDeviceOrientationLandscapeRight)) {
            NSLog(@"Landscape Left or Right !");
        } else if (orientation == UIDeviceOrientationPortrait) {
            NSLog(@"Landscape portrait!");
        }
        [self customizeTabBarSelectionIndicatorImage];
    };
    [[NSNotificationCenter defaultCenter] addObserverForName:CYLTabBarItemWidthDidChangeNotification
                                                      object:nil
                                                       queue:[NSOperationQueue mainQueue]
                                                  usingBlock:deviceOrientationDidChangeBlock];
}
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    if (!color || size.width <= 0 || size.height <= 0) return nil;
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width + 1, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

+(void)changeTabBar
{
    [self configIntroducePage];
}

+ (void)configIntroducePage
{
    AppDelegate * app = (AppDelegate *)[UIApplication sharedApplication].delegate;
        // 版本号相同：这次打开和上次打开的是同一个版本
    if (![LoginManager appReviewState]) {
        UIViewController * vc = (UIViewController *)app.window.rootViewController.childViewControllers[1];
        app.tabBarController.selectedIndex = 1;
        vc.tabBarItem.image =[[UIImage imageNamed:@"XL_TAB_JieQian_W"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        vc.tabBarItem.selectedImage = [[UIImage imageNamed:@"XL_TAB_JieQian"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        vc.title = @"提现";
        [[NSNotificationCenter defaultCenter] postNotificationName:kAppReviewState object:nil];
    }
}


@end

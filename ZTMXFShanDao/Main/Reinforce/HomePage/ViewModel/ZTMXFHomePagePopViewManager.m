//
//  HomePagePopViewManager.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/12/11.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "ZTMXFHomePagePopViewManager.h"
#import "HomePagePopupView.h"
#import "UIViewController+Visible.h"

@interface ZTMXFHomePagePopViewManager ()<HomePagePopupViewDelegate>

@property (nonatomic, copy)     NSString *jumpUrl;
@property (nonatomic, copy)     NSString *className;

@end

@implementation ZTMXFHomePagePopViewManager



- (instancetype)init
{
    self = [super init];
    if (self) {
        //  监听跳转到H5的推送
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(jumpToWebViewController:) name:kJumpToWebViewController object:nil];
        //  监听跳转到原生的推送
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(jumpToNativeViewController:) name:kJumpToNativeViewController object:nil];
    }
    return self;
}



#pragma mark - 只在首页接收到应用内推送消息
//  监听跳转到H5的推送
- (void)jumpToWebViewController:(NSNotification *)sender{
    NSDictionary *infoDict = sender.userInfo;
    NSString *jumpUrl = [infoDict[@"jumpUrl"] description];
    NSString *imageUrl = [infoDict[@"url"] description];
    if ([self remainInHomePage]) {
        //  停留在首页
        [self dealWithPopupWithImageUrl:imageUrl jumpUrl:jumpUrl className:nil];
    } else {
        //  存储204推送
        [[NSUserDefaults standardUserDefaults] setValue:infoDict forKey:kJumpToWebViewControllerKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

//  监听跳转到原生页面的推送
- (void)jumpToNativeViewController:(NSNotification *)sender{
    NSDictionary *infoDict = sender.userInfo;
    NSString *className = [infoDict[@"className"] description];
    NSString *imageUrl = [infoDict[@"url"] description];
    if ([self remainInHomePage]) {
        [self dealWithPopupWithImageUrl:imageUrl jumpUrl:nil className:className];
    } else {
        //  存储205推送
        [[NSUserDefaults standardUserDefaults] setValue:infoDict forKey:kJumpToNativeViewControllerKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

#pragma mark - 判断当前页面是否停留在首页
- (BOOL)remainInHomePage{
    UIViewController *currentController = [UIViewController currentViewController];
    NSString *currentControllerString = NSStringFromClass([currentController class]);
    if ([currentControllerString isEqualToString:@"LSHomePageViewController"]) {
        return YES;
    } else {
        return NO;
    }
}
#pragma mark - 是否显示首页弹框
- (void)dealWithPopupWithImageUrl:(NSString *)imageUrl jumpUrl:(NSString *)jumpUrl className:(NSString *)className{
    //  移除原有的弹框
    for (UIView *view in kKeyWindow.subviews) {
        if ([view isKindOfClass:[HomePagePopupView class]]) {
            [view removeFromSuperview];;
        }
    }
    self.jumpUrl = jumpUrl;
    self.className = className;
    
    if (jumpUrl.length > 0) {
        //  清除H5推送内容
        if ([[NSUserDefaults standardUserDefaults] objectForKey:kJumpToWebViewControllerKey]) {
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:kJumpToWebViewControllerKey];
        }
    } else if (className.length > 0) {
        //  清除原生的推送内容
        if ([[NSUserDefaults standardUserDefaults] objectForKey:kJumpToNativeViewControllerKey]) {
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:kJumpToNativeViewControllerKey];
        }
    }
    if ([LoginManager appReviewState]) {
        //  在骨头状态不弹出
        return;
    }
    
    HomePagePopupView *popupView = [HomePagePopupView popupView];
    popupView.delegate = self;
    [popupView.adImageView sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
}

#pragma mark - 下面是不停留在首页收到的通知处理情况
- (void)handleNotInHomePagePopupView{
    if ([LoginManager appReviewState]) {
        //  骨头状态不弹
        return;
    }
    //  204 的值
    if ([[NSUserDefaults standardUserDefaults] objectForKey:kJumpToWebViewControllerKey]) {
        //  获取204推送内容
        NSDictionary *infoDict = [[NSUserDefaults standardUserDefaults] objectForKey:kJumpToWebViewControllerKey];
        NSString *jumpUrl = [infoDict[@"jumpUrl"] description];
        NSString *imageUrl = [infoDict[@"url"] description];
        if (imageUrl.length > 0) {
            [self dealWithPopupWithImageUrl:imageUrl jumpUrl:jumpUrl className:nil];
        }
    } else if ([[NSUserDefaults standardUserDefaults] objectForKey:kJumpToNativeViewControllerKey]) {
        //  获取205推送内容
        NSDictionary *infoDict = [[NSUserDefaults standardUserDefaults] objectForKey:kJumpToNativeViewControllerKey];
        NSString *className = [infoDict[@"className"] description];
        NSString *imageUrl = [infoDict[@"url"] description];
        if (imageUrl.length > 0) {
            [self dealWithPopupWithImageUrl:imageUrl jumpUrl:nil className:className];
        }
    }
}

#pragma mark - 首页弹窗点击事件
- (void)homePagePopupViewClickAdImageView{
    UIViewController *currentController = [UIViewController currentViewController];
    if (self.jumpUrl.length > 0) {
        //  跳转到H5
        LSWebViewController *webVC = [[LSWebViewController alloc] init];
        webVC.webUrlStr = self.jumpUrl;
        [currentController.navigationController pushViewController:webVC animated:YES];
    } else if (self.className.length > 0) {
        //  跳转到原生类
        NSString *viewControllName = [NSString stringWithFormat:@"LS%@ViewController",self.className];
        Class viewControllerClass = NSClassFromString(viewControllName);
        UIViewController *viewController = [[viewControllerClass alloc] init];
        [currentController.navigationController pushViewController:viewController animated:YES];
    }
}


@end

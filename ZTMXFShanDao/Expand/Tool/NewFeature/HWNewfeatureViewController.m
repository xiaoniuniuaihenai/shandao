//
//  HWNewfeatureViewController.m
//  黑马微博2期
//
//  Created by apple on 14-10-10.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "HWNewfeatureViewController.h"
#import "TAPageControl.h"
#define HWNewfeatureCount 3

@interface HWNewfeatureViewController () <UIScrollViewDelegate>
@property (nonatomic, weak) TAPageControl *pageControl;

@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, assign) NSInteger  currentIndex;

@end

@implementation HWNewfeatureViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    // 1.创建一个scrollView：显示所有的新特性图片
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = self.view.bounds;
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    
    // 2.添加图片到scrollView中
    CGFloat scrollW = scrollView.width;
    CGFloat scrollH = scrollView.height;
    NSString * imgStr = @"XL_YinDao";
    if (![LoginManager appReviewState]) {
        imgStr = @"XL_XianShangYinDao";
    }
    for (int i = 0; i<HWNewfeatureCount; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake(i * scrollW, 0.0, scrollW, scrollH);
        NSString *imageName = [NSString stringWithFormat:@"%@%d", imgStr, i + 1];
        imageView.image = [UIImage imageNamed:imageName];
        [scrollView addSubview:imageView];
        
        // 如果是最后一个imageView，就往里面添加其他内容
        if (i == HWNewfeatureCount - 1) {
            [self setupLastImageView:imageView];
        }
    }
    
    // 3.设置scrollView的其他属性
    // 如果想要某个方向上不能滚动，那么这个方向对应的尺寸数值传0即可
    scrollView.contentSize = CGSizeMake(HWNewfeatureCount * scrollW, 0);
    scrollView.bounces = NO; // 去除弹簧效果
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.delegate = self;
    
    // 4.添加pageControl：分页，展示目前看的是第几页
//    TAPageControl *pageControl = [[TAPageControl alloc] init];
//    pageControl.numberOfPages = HWNewfeatureCount;
//    pageControl.dotColor = [UIColor whiteColor];
//    pageControl.userInteractionEnabled = NO;
//    pageControl.centerX = scrollW * 0.5;
//    pageControl.centerY = scrollH - 40;
//    [pageControl setDotImage:[UIImage imageNamed:@"a0yindaoyed-0"]];
//    [pageControl setCurrentDotImage:[UIImage imageNamed:@"a0yindaoye"]];
//    [self.view addSubview:pageControl];
//    self.pageControl = pageControl;
    
    self.currentIndex = 0;
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    double page = scrollView.contentOffset.x / scrollView.width;
    // 四舍五入计算出页码
    self.currentIndex = (int)page;

}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    double page = scrollView.contentOffset.x / scrollView.width;
    // 四舍五入计算出页码
    self.pageControl.currentPage = (int)(page + 0.5);
}

/**
 *  初始化最后一个imageView
 *
 *  @param imageView 最后一个imageView
 */
- (void)setupLastImageView:(UIImageView *)imageView
{
    // 开启交互功能
    imageView.userInteractionEnabled = YES;
    
    // 2.开始微博
    UIButton *startBtn = [[UIButton alloc] init];
    startBtn.frame = [UIScreen mainScreen].bounds;
//    startBtn.frame = CGRectMake(KW / 2  - 100, KH - 80, 200, 40);
//    startBtn.backgroundColor = K_MainColor;
    startBtn.backgroundColor = [UIColor clearColor];

//    [startBtn setTitle:@"立即体验" forState:UIControlStateNormal];
//    startBtn.layer.cornerRadius = startBtn.height / 2;
    [startBtn addTarget:self action:@selector(startClick) forControlEvents:UIControlEventTouchUpInside];
//    startBtn.backgroundColor = [UIColor clearColor];
    [imageView addSubview:startBtn];
}

//  立即体验按钮点击
- (void)startClick
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(newfeatureViewControllerClickStart)]) {
        [self.delegate newfeatureViewControllerClickStart];
    }
}

/*
 1.程序启动会自动加载叫做Default的图片
 1> 3.5inch 非retain屏幕：Default.png
 2> 3.5inch retina屏幕：Default@2x.png
 3> 4.0inch retain屏幕: Default-568h@2x.png

 2.只有程序启动时自动去加载的图片, 才会自动在4inch retina时查找-568h@2x.png
 */

@end

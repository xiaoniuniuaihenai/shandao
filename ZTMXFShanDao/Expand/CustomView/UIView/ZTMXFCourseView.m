//
//  CourseView.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2018/1/3.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "ZTMXFCourseView.h"
#import <SDCycleScrollView/TAPageControl.h>

#define kCourseCount 7
@interface ZTMXFCourseView ()<UIScrollViewDelegate>

/** 蒙版 view */
@property (nonatomic, strong) UIView        *maskView;
@property (nonatomic, strong) UIImageView   *firstImageView;
@property (nonatomic, strong) TAPageControl *pageControl;

@end

@implementation ZTMXFCourseView

- (instancetype)initWithFrame:(CGRect)frame andType:(LSAlipayType)alipayType
{
    self = [super initWithFrame:frame];
    if (self) {
        //  添加子控件
        [self setupViewsWithType:alipayType];
    }
    return self;
}

#pragma mark  添加子控件
- (void)setupViewsWithType:(LSAlipayType)alipayType{
    /** 蒙版view */
    self.maskView = [[UIView alloc] init];
    self.maskView.backgroundColor = [UIColor clearColor];
    self.maskView.frame = [UIScreen mainScreen].bounds;
    [self addSubview:self.maskView];
    
    CGFloat scrollW = SCREEN_WIDTH;
    CGFloat scrollH = SCREEN_HEIGHT;
    CGFloat leftMargin = 0.0;
    CGFloat topMargin = 0.0;
    
    // 1.创建一个scrollView：显示所有的新特性图片
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = CGRectMake(leftMargin, topMargin, scrollW, scrollH);
    scrollView.center = self.maskView.center;
    scrollView.delegate = self;
    [self addSubview:scrollView];
    self.scrollView = scrollView;
    
    // 2.添加图片到scrollView中
    
    for (int i = 0; i < kCourseCount; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake(i * scrollW, 0.0, scrollW, scrollH);
        NSString *imageName = [NSString stringWithFormat:@"XL_Zf_jiaocheng%d", i + 1];
//        if (alipayType == LSAlipayProofType) {
//            imageName = [NSString stringWithFormat:@"alipay_course_old_%d", i + 1];
//        }
        imageView.image = [UIImage imageNamed:imageName];
        imageView.userInteractionEnabled = YES;
        [scrollView addSubview:imageView];
        if (i == 0) {
            self.firstImageView = imageView;
        }

        UIButton *nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
        if (i == kCourseCount - 1) {
            [nextButton addTarget:self action:@selector(hiddenView) forControlEvents:UIControlEventTouchUpInside];
        } else {
            [nextButton addTarget:self action:@selector(nextButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        }
        nextButton.backgroundColor = [UIColor clearColor];
        nextButton.frame = CGRectMake(0.0, 0.0, scrollW, scrollH);
        [imageView addSubview:nextButton];
        
    }
    
    // 3.设置scrollView的其他属性
    // 如果想要某个方向上不能滚动，那么这个方向对应的尺寸数值传0即可
    scrollView.contentSize = CGSizeMake(kCourseCount * scrollW, 0);
    scrollView.bounces = NO; // 去除弹簧效果
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.delegate = self;
    
    
    // 4.添加pageControl：分页，展示目前看的是第几页
    TAPageControl *pageControl = [[TAPageControl alloc] init];
    pageControl.numberOfPages = kCourseCount;
    pageControl.dotColor = [UIColor whiteColor];
    pageControl.userInteractionEnabled = NO;
    pageControl.centerX = scrollW * 0.5;
    pageControl.centerY = scrollH - 80;
    [pageControl setDotImage:[UIImage imageNamed:@"course_normal_dot"]];
    [pageControl setCurrentDotImage:[UIImage imageNamed:@"course_current_dot"]];
    [self addSubview:pageControl];
    self.pageControl = pageControl;

}

//  点击下一步
- (void)nextButtonAction:(UIButton *)sender{
    double page = self.scrollView.contentOffset.x / self.scrollView.width;
    // 四舍五入计算出页码
    if (kCourseCount - 1 == page) {
        [self hiddenView];
    } else {
        [UIView animateWithDuration:0.38 animations:^{
            self.scrollView.contentOffset = CGPointMake(self.scrollView.width * ((int)page + 1), 0);
        }];
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    double page = scrollView.contentOffset.x / scrollView.width;
    // 四舍五入计算出页码
    self.pageControl.currentPage = (int)page;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    double page = scrollView.contentOffset.x / scrollView.width;
    // 四舍五入计算出页码
    self.pageControl.currentPage = (int)(page + 0.5);
}



#pragma mark  隐藏优惠view
+ (instancetype)popupCourseViewType:(LSAlipayType)alipayType{
    ZTMXFCourseView *courseView = [[ZTMXFCourseView alloc] initWithFrame:[UIScreen mainScreen].bounds andType:alipayType];
    courseView.backgroundColor = [UIColor clearColor];
    [kKeyWindow addSubview:courseView];
    CGFloat originViewHeight = AdaptedHeight(268.0);
    CGFloat originViewWidth = AdaptedWidth(155.0);
    courseView.firstImageView.frame = CGRectMake((Main_Screen_Width - originViewWidth) / 2.0, k_Navigation_Bar_Height + AdaptedHeight(204.0), originViewWidth, originViewHeight);
    [UIView animateWithDuration:0.38 animations:^{
        CGFloat leftMargin = 0.0;
        CGFloat topMargin = 0.0;
        courseView.firstImageView.frame = CGRectMake(leftMargin, topMargin, Main_Screen_Width, Main_Screen_Height);
    }];
    return courseView;
}
- (void)hiddenView{
    [self endEditing:YES];
    [UIView animateWithDuration:0.28 animations:^{
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        for (UIView *view in self.subviews) {
            [view removeFromSuperview];
        }
        [self removeFromSuperview];
    }];
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

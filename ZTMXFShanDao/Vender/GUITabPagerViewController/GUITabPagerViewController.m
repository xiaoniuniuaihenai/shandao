//
//  GUITabPagerViewController.m
//  GUITabPagerViewController
//
//  Created by Guilherme Araújo on 26/02/15.
//  Copyright (c) 2015 Guilherme Araújo. All rights reserved.
//

#import "GUITabPagerViewController.h"
#import "GUITabScrollView.h"

@interface GUITabPagerViewController () <GUITabScrollDelegate, UIPageViewControllerDataSource, UIPageViewControllerDelegate>

@property (strong, nonatomic) UIPageViewController *pageViewController;
@property (strong, nonatomic) GUITabScrollView *header;
@property (assign, nonatomic) NSInteger selectedIndex;

@property (strong, nonatomic) NSMutableArray *viewControllers;
@property (strong, nonatomic) NSMutableArray *tabTitles;
@property (strong, nonatomic) UIColor *headerColor;
@property (strong, nonatomic) UIColor *tabBackgroundColor;
@property (assign, nonatomic) CGFloat headerHeight;

@end

@implementation GUITabPagerViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  [self setEdgesForExtendedLayout:UIRectEdgeNone];

  [self setPageViewController:[[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                                                              navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                                                            options:nil]];

  for (UIView *view in [[[self pageViewController] view] subviews]) {
    if ([view isKindOfClass:[UIScrollView class]]) {
      [(UIScrollView *)view setCanCancelContentTouches:YES];
      [(UIScrollView *)view setDelaysContentTouches:NO];
    }
  }

  [[self pageViewController] setDataSource:self];
  [[self pageViewController] setDelegate:self];

  [self addChildViewController:self.pageViewController];
  [self.view addSubview:self.pageViewController.view];
  [self.pageViewController didMoveToParentViewController:self];
}

#pragma mark - Page View Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController
      viewControllerBeforeViewController:(UIViewController *)viewController {
  #pragma unused (pageViewController)

  NSUInteger pageIndex = [[self viewControllers] indexOfObject:viewController];
  return pageIndex > 0 ? [self viewControllers][pageIndex - 1]: nil;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController
       viewControllerAfterViewController:(UIViewController *)viewController {
  #pragma unused (pageViewController)

  NSUInteger pageIndex = [[self viewControllers] indexOfObject:viewController];
  return (pageIndex < [[self viewControllers] count] - 1) ?
    [self viewControllers][pageIndex + 1] : nil;
}

#pragma mark - Page View Delegate

- (void)pageViewController:(UIPageViewController *)pageViewController
willTransitionToViewControllers:(NSArray *)pendingViewControllers {
  #pragma unused (pageViewController)

  NSInteger index = [[self viewControllers] indexOfObject:pendingViewControllers[0]];
  [[self header] selectTabAtIndex:index];

  if ([[self delegate] respondsToSelector:@selector(tabPager:willTransitionToTabAtIndex:)]) {
    [[self delegate] tabPager:self willTransitionToTabAtIndex:index];
  }
}

- (void)pageViewController:(UIPageViewController *)pageViewController
        didFinishAnimating:(BOOL)finished
   previousViewControllers:(NSArray *)previousViewControllers
       transitionCompleted:(BOOL)completed {
  #pragma unused (pageViewController, finished, previousViewControllers, completed)

  UIPageViewController *selectedViewController = [[self pageViewController] viewControllers][0];

  [self setSelectedIndex:[[self viewControllers] indexOfObject:selectedViewController]];
  [[self header] selectTabAtIndex:[self selectedIndex]];

  if ([[self delegate] respondsToSelector:@selector(tabPager:didTransitionToTabAtIndex:)]) {
    [[self delegate] tabPager:self didTransitionToTabAtIndex:[self selectedIndex]];
  }
}

#pragma mark - Tab Scroll View Delegate

- (void)tabScrollView:(GUITabScrollView *)tabScrollView didSelectTabAtIndex:(NSInteger)index {
  #pragma unused (tabScrollView)

  if (index != [self selectedIndex]) {
    if ([[self delegate] respondsToSelector:@selector(tabPager:willTransitionToTabAtIndex:)]) {
      [[self delegate] tabPager:self willTransitionToTabAtIndex:index];
    }

    UIPageViewControllerNavigationDirection direction = (index > [self selectedIndex]) ?
      UIPageViewControllerNavigationDirectionForward :
      UIPageViewControllerNavigationDirectionReverse;

    void (^completionBlock)(BOOL) = ^(BOOL finished) {
      if (finished) {
        dispatch_async(dispatch_get_main_queue(), ^{
          // bug fix for UIPageViewController http://stackoverflow.com/a/17330606
          [self.pageViewController setViewControllers:@[[self viewControllers][index]]
                                            direction:direction
                                             animated:NO
                                           completion:nil];
        });
      }
      [self setSelectedIndex:index];

      if ([[self delegate] respondsToSelector:@selector(tabPager:didTransitionToTabAtIndex:)]) {
        [[self delegate] tabPager:self didTransitionToTabAtIndex:[self selectedIndex]];
      }
    };

    [[self pageViewController] setViewControllers:@[[self viewControllers][index]]
                                        direction:direction
                                         animated:YES
                                       completion:completionBlock];
  }
}

- (void)reloadData {
  [self setViewControllers:[NSMutableArray array]];
  [self setTabTitles:[NSMutableArray array]];

  [self.view removeConstraints:[self.view constraints]];

  for (int i = 0; i < [[self dataSource] numberOfViewControllers]; i++) {
    UIViewController *viewController;

    if ((viewController = [[self dataSource] viewControllerForIndex:i]) != nil) {
      [[self viewControllers] addObject:viewController];
    }

    if ([[self dataSource] respondsToSelector:@selector(titleForTabAtIndex:)]) {
      NSString *title;
      if ((title = [[self dataSource] titleForTabAtIndex:i]) != nil) {
        [[self tabTitles] addObject:title];
      }
    }
  }

  [self reloadTabs];

  CGRect frame = [[self view] bounds];
  frame.origin.y = [self headerHeight];
  frame.size.height -= [self headerHeight];

  [[[self pageViewController] view] setFrame:frame];

  [self.pageViewController setViewControllers:@[[self viewControllers][0]]
                                    direction:UIPageViewControllerNavigationDirectionReverse
                                     animated:NO
                                   completion:nil];
  [self setSelectedIndex:0];

  [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[header]-0-[pager]-0-|"
                                                                    options:0
                                                                    metrics:nil
                                                                      views:@{
                                                                              @"header": self.header,
                                                                              @"pager": self.pageViewController.view
                                                                              }]];

  [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[pager]-0-|"
                                                                    options:0
                                                                    metrics:nil
                                                                      views:@{@"pager": self.pageViewController.view}]];

  [self.pageViewController.view setTranslatesAutoresizingMaskIntoConstraints:NO];
}

- (void)reloadTabs {
  if ([[self dataSource] numberOfViewControllers] == 0)
    return;

  [self setupUI];

  NSMutableArray *tabViews;

  if ([[self dataSource] respondsToSelector:@selector(viewForTabAtIndex:)]) {
    tabViews = [self addTabsFromViews];
  } else {
    tabViews = [self addTabsFromTitles];
  }

  if ([self header]) {
    [[self header] removeFromSuperview];
  }

  CGRect frame = self.view.bounds;
  frame.size.height = [self headerHeight];

  CGFloat bottomLineHeight;
  if ([[self dataSource] respondsToSelector:@selector(bottomLineHeight)]) {
    bottomLineHeight = [[self dataSource] bottomLineHeight];
  } else {
    bottomLineHeight = 2.0f;
  }

  self.header = [[GUITabScrollView alloc] initWithFrame:frame
                                               tabViews:tabViews
                                                  color:[self headerColor]
                                       bottomLineHeight: bottomLineHeight
                                       selectedTabIndex:self.selectedIndex];

//  [self.header setTranslatesAutoresizingMaskIntoConstraints:NO];
  self.header.autoresizingMask = UIViewAutoresizingFlexibleWidth;
  self.header.backgroundColor = [self tabBackgroundColor];
  self.header.tabScrollDelegate = self;
  [self.view addSubview:self.header];

  [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[header(headerHeight)]"
                                                                    options:0
                                                                    metrics:@{@"headerHeight": @(self.headerHeight)}
                                                                      views:@{@"header": self.header}]];

  [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[header]-0-|"
                                                                    options:0
                                                                    metrics:nil
                                                                      views:@{@"header": self.header}]];
}

#pragma mark - Public Methods

- (void)selectTabbarIndex:(NSInteger)index {
  [self selectTabbarIndex:index animation:NO];
}

- (void)selectTabbarIndex:(NSInteger)index animation:(BOOL)animation {
  [self.pageViewController setViewControllers:@[[self viewControllers][index]]
                                    direction:UIPageViewControllerNavigationDirectionReverse
                                     animated:animation
                                   completion:nil];
  [[self header] selectTabAtIndex:index animated:animation];
  [self setSelectedIndex:index];
}

#pragma mark - Private Methods

- (void)setupUI {
  if ([[self dataSource] respondsToSelector:@selector(tabHeight)]) {
    [self setHeaderHeight:[[self dataSource] tabHeight]];
  } else {
    [self setHeaderHeight:44.0f];
  }

  if ([[self dataSource] respondsToSelector:@selector(tabColor)]) {
    [self setHeaderColor:[[self dataSource] tabColor]];
  } else {
    [self setHeaderColor:[UIColor orangeColor]];
  }

  if ([[self dataSource] respondsToSelector:@selector(tabBackgroundColor)]) {
    [self setTabBackgroundColor:[[self dataSource] tabBackgroundColor]];
  } else {
    [self setTabBackgroundColor:[UIColor colorWithWhite:0.95f alpha:1.0f]];
  }
}

- (NSMutableArray *)addTabsFromViews {
  NSMutableArray *tabViews = [NSMutableArray array];

  for (int i = 0; i < [[self viewControllers] count]; i++) {
    UIView *view;
    if ((view = [[self dataSource] viewForTabAtIndex:i]) != nil) {
      [tabViews addObject:view];
    }
  }

  return tabViews;
}

- (NSMutableArray *)addTabsFromTitles {
  NSMutableArray *tabViews = [NSMutableArray array];

  UIFont *font;
  if ([[self dataSource] respondsToSelector:@selector(titleFont)]) {
    font = [[self dataSource] titleFont];
  } else {
    font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:20.0f];
  }

  UIColor *color;
  if ([[self dataSource] respondsToSelector:@selector(titleColor)]) {
    color = [[self dataSource] titleColor];
  } else {
    color = [UIColor blackColor];
  }

  for (NSString *title in [self tabTitles]) {
    UILabel *label = [UILabel new];
    [label setText:title];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setFont:font];
    [label setTextColor:color];
    [label sizeToFit];

    CGRect frame = [label frame];
    frame.size.width = MAX(frame.size.width + 20, 85);
    [label setFrame:frame];
    [tabViews addObject:label];
  }
  
  return tabViews;
}
  
@end

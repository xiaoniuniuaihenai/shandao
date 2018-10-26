//
//  UIView+EaseBlankPage.h
//  Blossom
//  配置空白页

#import <UIKit/UIKit.h>
#import "EaseBlankPageView.h"

@interface UIView(EaseBlankPage)

@property (strong, nonatomic) EaseBlankPageView *blankPageView;

- (void)configBlankPage:(EaseBlankPageType)blankPageType hasData:(BOOL)hasData hasError:(BOOL)hasError reloadButtonBlock:(void(^)(id sender))block;
@end

//
//  HWNewfeatureViewController.h
//  黑马微博2期
//
//  Created by apple on 14-10-10.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NewfeatureViewControllerDelegate <NSObject>

- (void)newfeatureViewControllerClickStart;

@end

@interface HWNewfeatureViewController : BaseViewController

@property (nonatomic, weak) id<NewfeatureViewControllerDelegate> delegate;

@end

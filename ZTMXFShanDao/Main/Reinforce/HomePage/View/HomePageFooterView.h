//
//  HomePageFooterView.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/12/7.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LSBorrowHomeInfoModel;

@protocol HomePageFooterViewDelegate <NSObject>

@optional


@end

@interface HomePageFooterView : UIView

@property (nonatomic, weak) id<HomePageFooterViewDelegate> delegate;


@end

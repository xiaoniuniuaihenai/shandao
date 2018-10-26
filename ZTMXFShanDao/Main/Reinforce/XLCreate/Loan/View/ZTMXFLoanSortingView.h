//
//  ZTMXFLoanSortingView.h
//  ZTMXFXunMiaoiOS
//
//  Created by 陈传亮 on 2018/5/3.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^clickCompleteHandle)(NSInteger selectIndex);

@interface ZTMXFLoanSortingView : UIView

//+ (void)loanSortingViewWith:(NSArray *)items;
+ (void)loanSortingViewWith:(NSArray *)items index:(NSInteger)index completeHandle:(clickCompleteHandle)completeHandle;
;

@end

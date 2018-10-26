//
//  LSBarrageView.h
//  ALAFanBei
//
//  Created by Try on 2017/7/27.
//  Copyright © 2017年 讯秒. All rights reserved.
//  左右滚动 弹幕

#import <UIKit/UIKit.h>
@class  LSBorrowGoodsScrollBarModel;
@interface LSBarrageView : UIView
-(instancetype)initWithBarrageWithDelegate:(id)delegate andFrame:(CGRect)frame;
@property (nonatomic,copy) NSString * colorStr;
@property (nonatomic,strong) LSBorrowGoodsScrollBarModel * barModel;
@property (nonatomic,assign) CGFloat fontSize;
@end
@protocol LSBarrageViewDelegate<NSObject>
@optional
-(void)didCloseBarrageViewWithBarrageView:(LSBarrageView*)barrageView;
@end

//
//  LSBrwMoneyGoodsHeadView.h
//  ZTMXFXunMiaoiOS
//
//  Created by 朱吉达 on 2017/9/25.
//  Copyright © 2017年 LSCredit. All rights reserved.
//  借款超市头部

#import <UIKit/UIKit.h>
#import "LSLoanSupermarketLabelModel.h"
@interface LSBrwMoneyGoodsHeadView : UIView
-(instancetype)initWithGoodsHeadView;

-(void)btnClasseStateWith:(NSUInteger)page;

@property (nonatomic, weak) id delegate;

@property (nonatomic, strong)UIButton * sortingBtn;

@property (nonatomic, assign) NSInteger currentMenuIndex;

-(void)updateBrwMoneyGoodsHeadViewWith:(NSArray *)arrList;
@end
@protocol LSBrwMoneyGoodsHeadViewDelegate <NSObject>
@optional
-(void)brwMoneyGoodsUpdateDataWithGoodsData:(LSLoanSupermarketLabelModel*)goodsModel;

-(void)brwMoneyGoodsHeadView:(LSBrwMoneyGoodsHeadView *)brwMoneyGoodsHeadView  currentMenuIndex:(NSInteger)currentMenuIndex;



@end

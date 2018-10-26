//
//  AddNumberView.h
//  ShoppingCarDemo
//
//  Created by huanglianglei on 15/11/6.
//  Copyright © 2015年 huanglianglei. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol AddNumberViewDelegate;

@interface AddNumberView : UICollectionReusableView

@property (nonatomic, strong) UILabel  *purchaseLabel;

/** 购买数量 默认是隐藏的，只有购物页面弹出选择框的时候显示，并且下面的加减不让按钮隐藏 */
@property (nonatomic, strong) UILabel  *goodsCountLabel;
/** 数量 */
@property (nonatomic, assign) NSInteger  goodsCount;

@property (strong, nonatomic) UIButton *minusBtn;
@property (strong, nonatomic) UIButton *addBtn;
@property (nonatomic, strong) UITextField  *numberTextField;
@property (nonatomic, strong) UIView  *line1View;
@property (nonatomic, strong) UIView  *line2View;

@property (nonatomic, strong) UIView  *inputAccessoryView;

@property (nonatomic,assign) id<AddNumberViewDelegate> delegate;

@end

@protocol AddNumberViewDelegate <NSObject>

@optional

- (void)addNumberViewDelegateBecomeFirstResponder:(AddNumberView *)addNumberView;
- (void)addNumberViewDelegateResignFirstResponder:(AddNumberView *)addNumberView;

- (void)addNumberViewDelegateAddGoodsCount:(AddNumberView *)addNumberView;
- (void)addNumberViewDelegateMinusGoodsCount:(AddNumberView *)addNumberView;

- (void)addNumberViewDelegateNumberCountDidChange:(AddNumberView *)addNumberView;

@end


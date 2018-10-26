//
//  GoodsChoiseView.h
//  Himalaya
//
//  Created by 杨鹏 on 16/8/2.
//  Copyright © 2016年 ala. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GoodsDetailModel;
@class ChoiseGoodsByStageView;
@class AddNumberView;
@class CustomTool;
@class GoodsPriceInfoModel;


#define whiteViewHeight                 (460.0/667.0 * SCREEN_HEIGHT)
#define addNumberViewH                  60.0
#define confirmButtonH                  49.0
#define styleCollectionViewH            (whiteViewHeight - confirmButtonH - 102.0 - TabBar_Addition_Height)

@protocol GoodsChoiseViewDelegate <NSObject>

/** 立即购买 */
- (void)goodsChoiseViewBuyNowWithSku:(GoodsPriceInfoModel *)skuModel goodsCount:(NSString *)goodsCount goodsProperty:(NSString *)goodsProperty;

/** 选中规格 */
- (void)goodsChoiseViewSelectSkuModel:(GoodsPriceInfoModel *)skuModel goodsCount:(NSString *)goodsCount goodsPropertyName:(NSString *)propertyName;

/** 取消选中规格 */
- (void)goodsChoiseViewCancelGoodsProperty;

@end

@interface GoodsChoiseView : UIView

@property (nonatomic, strong) UIButton          *cancelButton;
/** 蒙版 view */
@property (nonatomic, strong) UIView            *maskView;
@property (nonatomic, strong) UIView            *whiteBackView;
@property (nonatomic, strong) UIImageView       *productImageView;
/** 商品价格 */
@property (nonatomic, strong) UILabel           *goodsPriceLabel;
/** 商品规格 */
@property (nonatomic, strong) UILabel           *goodsPropertyLabel;
/** 细线 */
@property (nonatomic, strong) UIView            *lineView;
/** 规格背景view */
@property (nonatomic, strong) UICollectionView  *styleCollectionView;

/** 底部细线 */
@property (nonatomic, strong) UIView            *bottomLine;
/** 月供 */
@property (nonatomic, strong) UILabel           *monthPayLabel;
/** 立即购买 */
@property (nonatomic, strong) UIButton          *buyNowButton;

/** 点击蒙版手势 */
@property (nonatomic, strong) UITapGestureRecognizer *tapMaskViewGesture;
/** 商品数量 */
@property (nonatomic, assign) NSInteger              goodsCount;
/** 商品详情model */
@property (nonatomic, strong)  GoodsDetailModel      *goodsDetailModel;
/** 代理 */
@property (nonatomic, weak) id<GoodsChoiseViewDelegate> delegate;

/** 商品属性数组 */
@property (nonatomic, strong) NSArray  *goodsPropertyModelArray;
/** 商品价格数组 */
@property (nonatomic, strong) NSArray  *goodsPriceModelArray;

/** 显示弹出框 */
+ (instancetype)popGoodsChoiseView;
/** 隐藏弹出框 */
- (void)hideWithAnimated:(BOOL)animated;

@end

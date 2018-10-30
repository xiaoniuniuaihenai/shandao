//
//  GoodsChoiseView.m
//  Himalaya
//
//  Created by 杨鹏 on 16/8/2.
//  Copyright © 2016年 ala. All rights reserved.
//

#import "GoodsChoiseView.h"
#import "GoodsDetailModel.h"
#import "GoodsPropertyCollectionViewLayout.h"
#import "StyleCollectionViewCell.h"
#import "StyleHeaderCollectionReusableView.h"
#import "StyleFooterCollectionReusableView.h"
#import "GoodsSkuPropertyModel.h"
#import "AddNumberView.h"
#import "UILabel+Attribute.h"

#define kLineHeight 0.5

@interface GoodsChoiseView ()<AddNumberViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) NSMutableArray  *selectedGoodsPropertyValueArray;
@property (nonatomic, strong) NSMutableArray  *sizeArray;
/** 选中的cell index 数组*/
@property (nonatomic, strong) NSMutableArray  *selectedCellIndexPathArray;
@property (nonatomic, strong) GoodsPriceInfoModel  *selectedGoodsPriceModel;

/** footerReusableView */
@property (nonatomic, strong) StyleFooterCollectionReusableView *footerReusableView;

/** 最少购买数量 */
@property (nonatomic, assign) NSInteger  minCount;
/** 最大购买数量 */
@property (nonatomic, assign) NSInteger  maxCount;

@end

@implementation GoodsChoiseView



- (NSMutableArray *)sizeArray{
    if (_sizeArray == nil) {
        _sizeArray = [NSMutableArray array];
    }
    return _sizeArray;
}

- (NSMutableArray *)selectedGoodsPropertyValueArray
{
    if (_selectedGoodsPropertyValueArray == nil) {
        _selectedGoodsPropertyValueArray = [NSMutableArray array];
    }
    return _selectedGoodsPropertyValueArray;
}

- (UITapGestureRecognizer *)tapMaskViewGesture
{
    if (_tapMaskViewGesture == nil) {
        _tapMaskViewGesture = [[UITapGestureRecognizer alloc] init];
        [_tapMaskViewGesture addTarget:self action:@selector(tapMaskViewGestureAction:)];
    }
    return _tapMaskViewGesture;
}

- (void)setMinCount:(NSInteger)minCount
{
    _minCount = minCount;
    if (_minCount < 1) {
        _minCount = 1;
    }
}

- (void)setMaxCount:(NSInteger)maxCount
{
    _maxCount = maxCount;
    if (_maxCount < 1) {
        _maxCount = 99;
    }
}
- (NSMutableArray *)selectedCellIndexPathArray
{
    if (_selectedCellIndexPathArray == nil) {
        _selectedCellIndexPathArray = [NSMutableArray array];
    }
    return _selectedCellIndexPathArray;
}


- (void)setGoodsCount:(NSInteger)goodsCount{
    _goodsCount = goodsCount;
    if (_goodsCount < 1) {
        _goodsCount = 1;
    }
    self.footerReusableView.addNumberView.numberTextField.text = [NSString stringWithFormat:@"%ld", _goodsCount];
}

- (void)setGoodsPriceModelArray:(NSArray *)goodsPriceModelArray
{
    _goodsPriceModelArray = goodsPriceModelArray;
}

//   设置商品规格属性
- (void)setGoodsPropertyModelArray:(NSArray *)goodsPropertyModelArray
{
    _goodsPropertyModelArray = goodsPropertyModelArray;
    
    for (int i = 0; i < self.goodsPropertyModelArray.count; i ++) {
        GoodsPropertyModel *goodsPropertyModel = self.goodsPropertyModelArray[i];
        NSMutableArray *propertySizeArray = [NSMutableArray array];
        for (GoodsPropertyValueModel *goodsPropertyValueModel in goodsPropertyModel.valueList) {
            CGSize size = [goodsPropertyValueModel.value sizeWithFont:[UIFont boldSystemFontOfSize:14] maxW:(SCREEN_WIDTH - 40.0)];
            CGSize newSize = CGSizeMake(size.width + 25.0, size.height + 15.0);
            [propertySizeArray addObject:[NSValue valueWithCGSize:newSize]];
        }
        [self.sizeArray addObject:propertySizeArray];
    }
    
    [self.styleCollectionView reloadData];
}




+ (instancetype)popGoodsChoiseView{
    GoodsChoiseView *choiseView = [[GoodsChoiseView alloc] init];
    [kKeyWindow addSubview:choiseView];
    CGRect whiteBackViewFrame = choiseView.whiteBackView.frame;
    whiteBackViewFrame.origin.y = SCREEN_HEIGHT - whiteViewHeight;
    [UIView animateWithDuration:0.38 animations:^{
        choiseView.maskView.alpha = 0.4;
        choiseView.whiteBackView.frame = whiteBackViewFrame;
    }];
    return choiseView;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSLog(@"super initwithframe");
        self.backgroundColor = [UIColor clearColor];
        self.minCount = 1;
        self.maxCount = 99;
        [self setupViews];
    }
    return self;
}


//  添加子控件
- (void)setupViews{
    
    self.maskView = [[UIView alloc] init];
    self.maskView.backgroundColor = [UIColor blackColor];
    self.maskView.alpha = 0.0;
    [self addSubview:self.maskView];
    
    //   *whiteBackView;
    self.whiteBackView = [[UIView alloc] init];
    self.whiteBackView.backgroundColor = [UIColor whiteColor];
    self.whiteBackView.frame = CGRectMake(0.0, SCREEN_HEIGHT, SCREEN_WIDTH, whiteViewHeight);
    _whiteBackView.layer.cornerRadius = 8;
    [self addSubview:self.whiteBackView];
    
    //   *productImageView;
    self.productImageView = [[UIImageView alloc] init];
    self.productImageView.backgroundColor = [UIColor whiteColor];
    self.productImageView.layer.cornerRadius = 4.0;
    self.productImageView.clipsToBounds = YES;
    self.productImageView.layer.borderWidth = 1.0;
    self.productImageView.layer.borderColor = [UIColor colorWithHexString:@"e5e5e5"].CGColor;
    [self.whiteBackView addSubview:self.productImageView];
    
    /** 规格属性 */
    self.goodsPropertyLabel = [UILabel labelWithTitleColorStr:COLOR_BLACK_STR fontSize:14 alignment:NSTextAlignmentLeft];
    self.goodsPropertyLabel.backgroundColor = [UIColor whiteColor];
    [self.whiteBackView addSubview:self.goodsPropertyLabel];

    //   商品价格
    self.goodsPriceLabel = [[UILabel alloc] init];
    self.goodsPriceLabel.backgroundColor = [UIColor whiteColor];
    self.goodsPriceLabel.font = [UIFont systemFontOfSize:16];
    self.goodsPriceLabel.textColor = [UIColor colorWithHexString:COLOR_RED_STR];
    [self.whiteBackView addSubview:self.goodsPriceLabel];
   
    
    /** 细线 */
    self.lineView = [UIView setupViewWithSuperView:self.whiteBackView withBGColor:COLOR_BORDER_STR];
    
    /** UICollectionView */
    GoodsPropertyCollectionViewLayout *layout = [[GoodsPropertyCollectionViewLayout alloc] init];
    layout.sectionInset = UIEdgeInsetsMake(0.0, 12.0, 0, 12.0);
    layout.headerReferenceSize = CGSizeMake(SCREEN_WIDTH, collectionHeaderH);
    layout.footerReferenceSize = CGSizeMake(SCREEN_WIDTH, collectionFooterH);
    self.styleCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0.0, CGRectGetMaxY(self.productImageView.frame), SCREEN_WIDTH, 400.0) collectionViewLayout:layout];
    self.styleCollectionView.showsVerticalScrollIndicator = NO;
    self.styleCollectionView.dataSource = self;
    self.styleCollectionView.delegate   = self;
    self.styleCollectionView.backgroundColor = [UIColor whiteColor];
    self.styleCollectionView.bounces = YES;
    self.styleCollectionView.scrollEnabled = YES;
    [self.styleCollectionView registerClass:[StyleCollectionViewCell class] forCellWithReuseIdentifier:@"StyleCollectionViewCell"];
    [self.whiteBackView addSubview:self.styleCollectionView];
    
    [self.styleCollectionView registerClass:[StyleHeaderCollectionReusableView class] forSupplementaryViewOfKind:GoodsPropertyCollectionViewHeader withReuseIdentifier:GoodsPropertyCollectionViewHeaderReuseIdentifier];
    [self.styleCollectionView registerClass:[StyleFooterCollectionReusableView class] forSupplementaryViewOfKind:GoodsPropertyCollectionViewFooter withReuseIdentifier:GoodsPropertyCollectionViewFooterReuseIdentifier];
    [self.styleCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:GoodsPropertyCollectionViewFooter withReuseIdentifier:GoodsPropertyCollectionViewFooterLineReuseIdentifier];
    
    //  取消按钮
    self.cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.cancelButton setImage:[UIImage imageNamed:@"goods_close"] forState:UIControlStateNormal];
    [self.cancelButton addTarget:self action:@selector(cancelButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    self.cancelButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    self.cancelButton.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [self.whiteBackView addSubview:self.cancelButton];
    
    
    /** 底部显现 */
    self.bottomLine = [UIView setupViewWithSuperView:self.whiteBackView withBGColor:COLOR_BORDER_STR];
    [self.whiteBackView addSubview:self.bottomLine];
    
    //  月供
    self.monthPayLabel = [[UILabel alloc] init];
    self.monthPayLabel.textColor = [UIColor colorWithHexString:COLOR_GRAY_STR];
    self.monthPayLabel.font = FONT_Regular(16 * PX);
    self.monthPayLabel.lineBreakMode = 0;
    [self.whiteBackView addSubview:self.monthPayLabel];
    if ([LoginManager appReviewState]) {
        _monthPayLabel.hidden = YES;
    }
    //  立即购买
    self.buyNowButton = [self setupButtonWithSuperView:self.whiteBackView withTitle:@"立即购买"];
    self.buyNowButton.backgroundColor = K_MainColor;
    [self.buyNowButton setTitleColor:K_BtnTitleColor forState:UIControlStateNormal];
    [self.buyNowButton addTarget:self action:@selector(buyNowButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    //  1秒以后添加手势防止快速点击两次弹出一点就缩回来
    [self performSelector:@selector(addTagGesture) withObject:nil afterDelay:1.0];
    
}

- (void)addTagGesture{
    [self.maskView addGestureRecognizer:self.tapMaskViewGesture];
}

//  设置加入购物车按钮
- (UIButton *)setupButtonWithSuperView:(UIView *)superView withTitle:(NSString *)title{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:16];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [superView addSubview:button];
    return button;
}

//  立即购买
- (void)buyNowButtonAction:(UIButton *)sender{
    if (self.selectedGoodsPriceModel) {
        //  判断库存是否充足
        if (self.goodsCount == 0 || self.goodsCount > self.selectedGoodsPriceModel.stock) {
            return;
        }

        [self hideWithAnimated:NO];
        if (self.delegate && [self.delegate respondsToSelector:@selector(goodsChoiseViewBuyNowWithSku:goodsCount:goodsProperty:)]) {
            NSString *goodsCount = [NSString stringWithFormat:@"%ld", self.goodsCount];
            NSString *propertyString = [NSString string];
            for (GoodsPropertyValueModel *goodsPropertyValueModel in self.selectedGoodsPropertyValueArray) {
                if (goodsPropertyValueModel.value) {
                    propertyString = [propertyString stringByAppendingString:[NSString stringWithFormat:@" %@",goodsPropertyValueModel.value]];
                }
            }
            
            [self.delegate goodsChoiseViewBuyNowWithSku:self.selectedGoodsPriceModel goodsCount:goodsCount goodsProperty:propertyString];
        }
    }
}

//  点击取消按钮
- (void)cancelButtonAction:(UIButton *)sender
{
    [self hideWithAnimated:YES];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.frame = CGRectMake(0.0, 0.0, SCREEN_WIDTH, SCREEN_HEIGHT);
    self.maskView.frame = CGRectMake(0.0, 0.0, SCREEN_WIDTH, SCREEN_HEIGHT);
    
    //    *productImageView;
    CGFloat productImageViewX = 12.0;
    CGFloat productImageViewY = 22.0;
    CGFloat productImageViewW = 100.0;
    CGFloat productImageViewH = 100.0;
    self.productImageView.frame = CGRectMake(productImageViewX, productImageViewY, productImageViewW, productImageViewH);
    
    //  选择规格;
    CGFloat goodsPropertyLabelX = CGRectGetMaxX(self.productImageView.frame) + 12.0;
    CGFloat goodsPropertyLabelY = 10.0;
    CGFloat goodsPropertyLabelW = SCREEN_WIDTH - 180.0;
    CGFloat goodsPropertyLabelH = 38.0;
    self.goodsPropertyLabel.frame = CGRectMake(goodsPropertyLabelX, goodsPropertyLabelY, goodsPropertyLabelW, goodsPropertyLabelH);
    
    //    *priceLabel;
    CGFloat priceLabelX = CGRectGetMaxX(self.productImageView.frame) + 12.0;
    CGFloat priceLabelY = CGRectGetMaxY(self.productImageView.frame) - 32.0;
    CGFloat priceLabelW = SCREEN_WIDTH - 140.0;
    CGFloat priceLabelH = 32.0;
    self.goodsPriceLabel.frame = CGRectMake(priceLabelX, priceLabelY, priceLabelW, priceLabelH);
    
    //  细线
    self.lineView.frame = CGRectMake(10.0, CGRectGetMaxY(self.productImageView.frame) + 20.0, SCREEN_WIDTH - 20.0, kLineHeight);
    
    //  UICollectionView
    CGFloat styleBackViewX = 0.0;
    CGFloat styleBackViewY = CGRectGetMaxY(self.lineView.frame);
    CGFloat styleBackViewW = SCREEN_WIDTH;
    self.styleCollectionView.frame = CGRectMake(styleBackViewX, styleBackViewY, styleBackViewW, styleCollectionViewH);

    //  取消按钮
    CGFloat cancelButtonWH = 40.0;
    self.cancelButton.frame = CGRectMake(SCREEN_WIDTH - 40, 0, cancelButtonWH, cancelButtonWH);
  
    /** 底部细线 */
    self.bottomLine.frame = CGRectMake(0.0, CGRectGetHeight(self.whiteBackView.frame) - confirmButtonH - kLineHeight - TabBar_Addition_Height, Main_Screen_Width, kLineHeight);
    
    CGFloat buyNowButtonW = AdaptedWidth(140.0);
    CGFloat monthPayLabelW = Main_Screen_Width - buyNowButtonW;
    CGFloat buyNowButtonY = CGRectGetHeight(self.whiteBackView.frame) - confirmButtonH - TabBar_Addition_Height;
    self.monthPayLabel.frame = CGRectMake(0.0, buyNowButtonY, monthPayLabelW, confirmButtonH);
    _monthPayLabel.backgroundColor = [UIColor whiteColor];
    self.buyNowButton.frame = CGRectMake(CGRectGetMaxX(self.monthPayLabel.frame), buyNowButtonY, buyNowButtonW, confirmButtonH);
}

- (void)hideWithAnimated:(BOOL)animated{
    CGRect whiteBackViewFrame = self.whiteBackView.frame;
    whiteBackViewFrame.origin.y = SCREEN_HEIGHT;

    if (animated) {
        [UIView animateWithDuration:0.38 animations:^{
            self.whiteBackView.frame = whiteBackViewFrame;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.38 animations:^{
                self.alpha = 0.0;
            } completion:^(BOOL finished) {
                [self removeFromSuperview];
            }];
        }];
    } else {
        self.whiteBackView.frame = whiteBackViewFrame;
        self.alpha = 0.0;
        [self removeFromSuperview];
    }
}

- (void)tapMaskViewGestureAction:(UITapGestureRecognizer *)sender
{
    [self hideWithAnimated:YES];
}

//  设置商品详情model
- (void)setGoodsDetailModel:(GoodsDetailModel *)goodsDetailModel{
    if (_goodsDetailModel != goodsDetailModel) {
        _goodsDetailModel = goodsDetailModel;
    }
    
    if (_goodsDetailModel.skuId > 0) {
        //  默认选中
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSMutableArray *selectPropertyIds = [NSMutableArray array];
            for (GoodsPriceInfoModel *goodsPriceModel in self.goodsPriceModelArray) {
                if (goodsPriceModel.skuId == _goodsDetailModel.skuId) {
                    NSMutableArray *filterPropertyIds = [NSMutableArray array];
                    NSArray *propertyValueIds = [goodsPriceModel.propertyValueIds componentsSeparatedByString:@","];
                    for (int i = 0; i < propertyValueIds.count; i ++) {
                        NSString *propertyValueId = propertyValueIds[i];
                        if (!kStringIsEmpty(propertyValueId)) {
                            [filterPropertyIds addObject:propertyValueId];
                        }
                    }
                    [selectPropertyIds addObjectsFromArray:filterPropertyIds];
                    break;
                }
            }
            
            //  得到选中Id组合
            if (selectPropertyIds.count == self.goodsPropertyModelArray.count) {
                //  组合对应
                for (int i = 0; i < self.goodsPropertyModelArray.count; i ++) {
                    GoodsPropertyModel *goodsPropertyModel = self.goodsPropertyModelArray[i];
                    for (int j = 0; j < goodsPropertyModel.valueList.count; j ++) {
                        GoodsPropertyValueModel *goodsPropertyValueModel = goodsPropertyModel.valueList[j];
                        if ([selectPropertyIds[i] isEqualToString:goodsPropertyValueModel.pid]) {
                            NSIndexPath *currentIndexPath = [NSIndexPath indexPathForItem:j inSection:i];
                            [self collectionView:self.styleCollectionView didSelectItemAtIndexPath:currentIndexPath];
                            break;
                        }
                    }
                }
            }
        });
    } else {
        //  设置未选择规格状态
        [self setupUnselectedState];
    }
}

#pragma mark - AddNumberView 代理方法
//  输入购买数量UITextField失去第一响应者
- (void)addNumberViewDelegateResignFirstResponder:(AddNumberView *)addNumberView
{
    NSInteger addNumberText = [addNumberView.numberTextField.text integerValue];

    if (self.minCount > addNumberText) {
        addNumberView.numberTextField.text = [NSString stringWithFormat:@"%ld",(long)self.minCount];
        [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:@"该商品数量不能小于%ld",(long)self.minCount]];
    }
    //  设置商品数量
    [self setupGoodsCount];
}


//  添加购买的数量
- (void)addNumberViewDelegateAddGoodsCount:(AddNumberView *)addNumberView
{
    NSString *number = addNumberView.numberTextField.text;
    NSInteger oldCount = number.integerValue;
    if (oldCount == self.maxCount) {
        if (self.maxCount > 0) {
            [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:@"该商品数量不能大于%ld",(long)self.maxCount]];
        }
    } else {
        NSInteger newCount = oldCount + 1;
        addNumberView.numberTextField.text = [NSString stringWithFormat:@"%ld",(long)newCount];
    }
    
    //  设置商品数量
    [self setupGoodsCount];
}

//  减少购买的数量
- (void)addNumberViewDelegateMinusGoodsCount:(AddNumberView *)addNumberView
{
    NSString *number = addNumberView.numberTextField.text;
    NSInteger oldCount = number.integerValue;
    if (oldCount == self.minCount) {
        if (self.minCount > 1) {
            [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:@"该商品数量不能小于%ld",(long)self.minCount]];
        }
    } else {
        NSInteger newCount = oldCount - 1;
        addNumberView.numberTextField.text = [NSString stringWithFormat:@"%ld",(long)newCount];
    }
    
    //  设置商品数量
    [self setupGoodsCount];
}

//  购买的数量改变的
- (void)addNumberViewDelegateNumberCountDidChange:(AddNumberView *)addNumberView{

    NSString *numberText = addNumberView.numberTextField.text;
    if (numberText.integerValue > self.maxCount){
        addNumberView.numberTextField.text = [NSString stringWithFormat:@"%ld",(long)self.maxCount];
    }
    //  设置商品数量
    [self setupGoodsCount];
}

//  设置商品数量
- (void)setupGoodsCount{
    NSInteger goodsCount = [self.footerReusableView.addNumberView.numberTextField.text integerValue];
    self.goodsCount = goodsCount;
    if (self.goodsCount < self.minCount) {
        self.goodsCount = self.minCount;
    } else if (self.goodsCount > self.maxCount){
        self.goodsCount = self.maxCount;
    } else if (self.goodsCount < 1) {
        self.goodsCount = 1;
    }

    //  如果有选中的规格
    if (self.selectedGoodsPriceModel) {
        if (self.goodsCount > self.selectedGoodsPriceModel.stock) {
            //  判断库存不足
            [self setupGoodsStockNotEnoughState];
        } else {
            //  选中商品规格状态
            [self setupGoodsSelectedState];
        }
    } else {
        //  设置未选中商品规格状态
        [self setupUnselectedState];
    }
}

//  获取选中规格name
- (NSString *)selectGoodsPropertyName{
    NSString *propertyNameString = [NSString string];
    for (GoodsPropertyValueModel *goodsPropertyValueModel in self.selectedGoodsPropertyValueArray) {
        if (goodsPropertyValueModel.value) {
            propertyNameString = [propertyNameString stringByAppendingString:[NSString stringWithFormat:@" %@",goodsPropertyValueModel.value]];
        }
    }
    return propertyNameString;
}
//  设置未选择规格状态
- (void)setupUnselectedState{
    if (self.selectedGoodsPriceModel) {
        self.selectedGoodsPriceModel = nil;
    }
    //  选中商品名称
    self.goodsPropertyLabel.text = self.goodsDetailModel.goodsInfo.name;
    //  设置月供
    NSString *monthPayStr = [NSString stringWithFormat:@"￥0.00"];
    NSString *payString = [NSString stringWithFormat:@"  月供 %@ 起", monthPayStr];
    UIColor *redColor = [UIColor colorWithHexString:COLOR_RED_STR];
    [UILabel attributeWithLabel:self.monthPayLabel text:payString textColor:COLOR_GRAY_STR attributes:@[monthPayStr] attributeColors:@[redColor]];

//    NSString *monthPayStr = @"0.00元";
//    NSString *payString = [NSString stringWithFormat:@"  最高减免 %@", monthPayStr];
//    NSArray * arr =[payString componentsSeparatedByString:@"."];
//    NSString * lastStr = arr.count > 1?[arr lastObject]:@"";
//    [UILabel attributeWithLabel:self.monthPayLabel text:payString textColor:COLOR_GRAY_STR attributesOriginalColorStrs:@[monthPayStr] attributeNewColors:@[K_MainColor] textFont:16 * PX attributesOriginalFontStrs:@[lastStr] attributeNewFonts:@[FONT_Regular(12 * PX)]];
//
    
    //  设置立即购买按钮颜色
    if (![self.buyNowButton.currentTitle isEqualToString:@"立即购买"]) {
        [self.buyNowButton setTitle:@"立即购买" forState:UIControlStateNormal];
    }
    self.buyNowButton.backgroundColor = [UIColor colorWithHexString:COLOR_UNUSABLE_BUTTON];
    //  选择规格失败
    if (self.delegate && [self.delegate respondsToSelector:@selector(goodsChoiseViewCancelGoodsProperty)]) {
        [self.delegate goodsChoiseViewCancelGoodsProperty];
    }
}

//  设置选中商品库存不足规格状态
- (void)setupGoodsStockNotEnoughState{
    if (self.selectedGoodsPriceModel) {
        //  获取选中的规格的价格
        NSString *priceStr = [NSString stringWithFormat:@"￥%.2f",self.selectedGoodsPriceModel.actualAmount];
        self.goodsPriceLabel.text = priceStr;
        //  选中商品名称
        self.goodsPropertyLabel.text = self.goodsDetailModel.goodsInfo.name;
        // 商品图片
        [self.productImageView sd_setImageWithURL:[NSURL URLWithString:self.selectedGoodsPriceModel.picUrl]];
        //  月供数据
        double monthPay = self.selectedGoodsPriceModel.monthPay * self.goodsCount;
        NSString *monthPayStr = [NSString stringWithFormat:@"￥%.2f", monthPay];
        NSString *payString = [NSString stringWithFormat:@"  月供 %@ 起", monthPayStr];
        UIColor *redColor = [UIColor colorWithHexString:COLOR_RED_STR];
        [UILabel attributeWithLabel:self.monthPayLabel text:payString textColor:COLOR_GRAY_STR attributes:@[monthPayStr] attributeColors:@[redColor]];
        
        
//        NSString *monthPayStr = [NSString stringWithFormat:@"%.2f元", monthPay];
//
//        NSString *payString = [NSString stringWithFormat:@"  最高减免 %@", monthPayStr];
//        NSArray * arr =[payString componentsSeparatedByString:@"."];
//        NSString * lastStr = arr.count > 1?[arr lastObject]:@"";
//        [UILabel attributeWithLabel:self.monthPayLabel text:payString textColor:COLOR_GRAY_STR attributesOriginalColorStrs:@[monthPayStr] attributeNewColors:@[K_MainColor] textFont:16 * PX attributesOriginalFontStrs:@[lastStr] attributeNewFonts:@[FONT_Regular(12 * PX)]];
        
        
        
        //  设置立即购买按钮颜色
        self.buyNowButton.backgroundColor = [UIColor colorWithHexString:COLOR_UNUSABLE_BUTTON];
        if (![self.buyNowButton.currentTitle isEqualToString:@"库存不足"]) {
            [self.buyNowButton setTitle:@"库存不足" forState:UIControlStateNormal];
        }
        NSString *propertyNameString = [self selectGoodsPropertyName];
        //  选中商品规格
        if (self.delegate && [self.delegate respondsToSelector:@selector(goodsChoiseViewSelectSkuModel:goodsCount:goodsPropertyName:)]) {
            [self.delegate goodsChoiseViewSelectSkuModel:self.selectedGoodsPriceModel goodsCount:[NSString stringWithFormat:@"%ld",self.goodsCount] goodsPropertyName:propertyNameString];
        }
    }
}


//  设置选中商品规格状态
- (void)setupGoodsSelectedState{
    if (self.selectedGoodsPriceModel) {
        
        //  获取选中的规格的价格
        NSString *priceStr = [NSString stringWithFormat:@"￥%.2f",self.selectedGoodsPriceModel.actualAmount];
        self.goodsPriceLabel.text = priceStr;
        //  选中商品名称
        self.goodsPropertyLabel.text = self.goodsDetailModel.goodsInfo.name;
        // 商品图片
        [self.productImageView sd_setImageWithURL:[NSURL URLWithString:self.selectedGoodsPriceModel.picUrl]];
        //  月供数据
        double monthPay = self.selectedGoodsPriceModel.monthPay * self.goodsCount;
        NSString *monthPayStr = [NSString stringWithFormat:@"￥%.2f", monthPay];
        NSString *payString = [NSString stringWithFormat:@"  月供 %@ 起", monthPayStr];
        UIColor *redColor = [UIColor colorWithHexString:COLOR_RED_STR];
        [UILabel attributeWithLabel:self.monthPayLabel text:payString textColor:COLOR_GRAY_STR attributes:@[monthPayStr] attributeColors:@[redColor]];
        
        
//        NSString *monthPayStr = [NSString stringWithFormat:@"%.2f元", monthPay];
//
//        NSString *payString = [NSString stringWithFormat:@"  最高减免 %@", monthPayStr];
//        NSArray * arr =[payString componentsSeparatedByString:@"."];
//        NSString * lastStr = arr.count > 1?[arr lastObject]:@"";
//        [UILabel attributeWithLabel:self.monthPayLabel text:payString textColor:COLOR_GRAY_STR attributesOriginalColorStrs:@[monthPayStr] attributeNewColors:@[K_MainColor] textFont:16 * PX attributesOriginalFontStrs:@[lastStr] attributeNewFonts:@[FONT_Regular(12 * PX)]];
        
        //  设置立即购买按钮颜色
        self.buyNowButton.backgroundColor = K_MainColor;
        if (![self.buyNowButton.currentTitle isEqualToString:@"立即购买"]) {
            [self.buyNowButton setTitle:@"立即购买" forState:UIControlStateNormal];
        }
        //  选中商品规格
        //  商品规格名称
        NSString *propertyNameString = [self selectGoodsPropertyName];
        if (self.delegate && [self.delegate respondsToSelector:@selector(goodsChoiseViewSelectSkuModel:goodsCount:goodsPropertyName:)]) {
            [self.delegate goodsChoiseViewSelectSkuModel:self.selectedGoodsPriceModel goodsCount:[NSString stringWithFormat:@"%ld",self.goodsCount] goodsPropertyName:propertyNameString];
        }
    }
}

#pragma mark - UICollectionView代理方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    GoodsPropertyModel *goodsPropertyModel = self.goodsPropertyModelArray[section];
    return goodsPropertyModel.valueList.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.goodsPropertyModelArray.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section >= 0 && indexPath.section < self.sizeArray.count) {
        NSArray *array = self.sizeArray[indexPath.section];
        if (indexPath.row >= 0 && indexPath.row < array.count) {
            CGSize size = [array[indexPath.row] CGSizeValue];
            return size;
        }
    }
    return CGSizeMake(60.0, 30.0);
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GoodsPropertyModel *goodsPropertyModel = self.goodsPropertyModelArray[indexPath.section];
    GoodsPropertyValueModel *goodsPropertyValueModel = goodsPropertyModel.valueList[indexPath.row];
    
    StyleCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"StyleCollectionViewCell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[StyleCollectionViewCell alloc] init];
    }
    cell.titleLabel.text = goodsPropertyValueModel.value;
    if ([self.selectedCellIndexPathArray containsObject:indexPath]) {
        cell.selectedState = YES;
    } else {
        cell.selectedState = NO;
    }
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    StyleCollectionViewCell *cell = (StyleCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    [self selectCollectionViewCellItem:cell indexPath:indexPath];
}

//  选中规格属性的操作
- (void)selectCollectionViewCellItem:(UICollectionViewCell *)cell indexPath:(NSIndexPath *)indexPath{
    
    StyleCollectionViewCell *selectedCell = (StyleCollectionViewCell *)cell;
    if (selectedCell.selectedState) {
        //  取消选中状态
//        selectedCell.selectedState = NO;
//        if ([self.selectedCellIndexPathArray containsObject:indexPath]) {
//            [self.selectedCellIndexPathArray removeObject:indexPath];
//        }
//        [self setupUnselectedState];
        return;
    } else {
        //  设置选中样式
        [self.selectedCellIndexPathArray addObject:indexPath];
        selectedCell.titleLabel.layer.borderColor = [UIColor colorWithHexString:COLOR_RED_STR].CGColor;
        selectedCell.titleLabel.textColor = [UIColor colorWithHexString:COLOR_RED_STR];
    }
    
    //  当前section下如果有其他选中的cell则置灰
    NSInteger currentRowsCount = [self.styleCollectionView numberOfItemsInSection:indexPath.section];
    for (int i = 0; i < currentRowsCount; i ++) {
        NSIndexPath *currentIndexPath = [NSIndexPath indexPathForItem:i inSection:indexPath.section];
        StyleCollectionViewCell *currentCell = (StyleCollectionViewCell *)[self.styleCollectionView cellForItemAtIndexPath:currentIndexPath];
        if (currentCell.selectedState) {
            if ([self.selectedCellIndexPathArray containsObject:currentIndexPath]) {
                [self.selectedCellIndexPathArray removeObject:currentIndexPath];
            }
            currentCell.selectedState = NO;
        }
    }
    //  设置选中状态
    selectedCell.selectedState = YES;
    //  先清除所有的选中cell对应的GoodsPropertyValueModel ,然后从上到下装所有选中的cell对应的GoodsPropertyValueModel
    [self.selectedGoodsPropertyValueArray removeAllObjects];;
    
    //  查找所有选中的属性
    for (int selectIndex = 0; selectIndex < self.selectedCellIndexPathArray.count; selectIndex ++) {
        NSIndexPath *selectIndexPath = self.selectedCellIndexPathArray[selectIndex];
        GoodsPropertyModel *goodsPropertyModel = self.goodsPropertyModelArray[selectIndexPath.section];
        GoodsPropertyValueModel *goodsPropertyValueModel = goodsPropertyModel.valueList[selectIndexPath.row];
        [self.selectedGoodsPropertyValueArray addObject:goodsPropertyValueModel];
    }
    
    //  做一个判断，如果所有选中的cell对应的GoodsPropertyValueModel的个数与规格个数不匹配也不对
    if (self.selectedGoodsPropertyValueArray.count != self.goodsPropertyModelArray.count) {
        [self setupUnselectedState];
        return;
    }
    
    //  获取与之匹配的GoodsPriceModel
    NSMutableArray *selectedPropertyIDArray = [NSMutableArray array];
    for (GoodsPropertyValueModel *goodsPropertyValueModel in self.selectedGoodsPropertyValueArray) {
        if (goodsPropertyValueModel.pid) {
            [selectedPropertyIDArray addObject:goodsPropertyValueModel.pid];
        }
    }
    
    for (GoodsPriceInfoModel *goodsPriceModel in self.goodsPriceModelArray) {
        NSArray *idGroup = [goodsPriceModel.propertyValueIds componentsSeparatedByString:@","];
        NSMutableArray *filterIdGroup = [NSMutableArray array];
        for (NSString *idStr in idGroup) {
            if (idStr.length > 0) {
                [filterIdGroup addObject:[idStr stringByReplacingOccurrencesOfString:@" " withString:@""]];
            }
        }
        //  判断选中规格和规格列表的数量做对比
        if (filterIdGroup.count == selectedPropertyIDArray.count) {
            BOOL matchPriceId = YES;
            for (NSString *idStr in filterIdGroup) {
                if (![selectedPropertyIDArray containsObject:idStr]) {
                    matchPriceId = NO;
                    break;
                }
            }
            //  规格匹配
            if (matchPriceId) {
                //  设置选中的GoodsPriceModel
                self.selectedGoodsPriceModel = goodsPriceModel;
                //  设置商品数量
                [self setupGoodsCount];
                break;
            } else {
                //  设置未选择状态
                [self setupUnselectedState];
            }
        } else {
            //  设置未选择状态
            [self setupUnselectedState];
        }
    }
}

//  创建 分区头尾视图调用
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    //创建/获取头尾视图的时候也要用复用队列
    //判断kind 来区分头尾
    if ([kind isEqualToString:GoodsPropertyCollectionViewHeader]) {
        //头视图
        //(如果满足不了需要那么就定制)
        StyleHeaderCollectionReusableView *reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:GoodsPropertyCollectionViewHeader withReuseIdentifier:GoodsPropertyCollectionViewHeaderReuseIdentifier forIndexPath:indexPath];
        reusableView.backgroundColor = [UIColor whiteColor];
        
        GoodsPropertyModel *goodsPropertyModel = self.goodsPropertyModelArray[indexPath.section];
        reusableView.titleLabel.text = goodsPropertyModel.name;
        
        return reusableView;
    } else if([kind isEqualToString:GoodsPropertyCollectionViewFooter]) {
        
        NSInteger sectionCount = self.goodsPropertyModelArray.count;
        if (indexPath.section == sectionCount - 1) {
            //尾视图
            StyleFooterCollectionReusableView *footerReusableView = [collectionView dequeueReusableSupplementaryViewOfKind:GoodsPropertyCollectionViewFooter withReuseIdentifier:GoodsPropertyCollectionViewFooterReuseIdentifier forIndexPath:indexPath];
            self.footerReusableView = footerReusableView;
            footerReusableView.backgroundColor = [UIColor whiteColor];
            footerReusableView.addNumberView.delegate = self;
            if (self.goodsCount < 1) {
                self.goodsCount = 1;
            }
            footerReusableView.addNumberView.numberTextField.text = [NSString stringWithFormat:@"%ld",(long)self.goodsCount];

            return footerReusableView;
        } else {
            
            UICollectionReusableView *footer =  [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:GoodsPropertyCollectionViewFooterLineReuseIdentifier forIndexPath:indexPath];
            footer.backgroundColor = [UIColor colorWithHexString:COLOR_BORDER_STR];
            return footer;
        }
    } else {
        return nil;
    }
}

@end

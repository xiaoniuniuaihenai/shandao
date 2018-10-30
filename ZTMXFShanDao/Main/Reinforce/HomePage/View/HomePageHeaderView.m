//
//  HomePageHeaderView.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/12/7.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "HomePageHeaderView.h"
#import "SDCycleScrollView.h"
#import "CategoryMenuView.h"
#import "HotSaleView.h"
#import "HomePageMallModel.h"
#import "CategoryCollectionViewCell.h"

@interface HomePageHeaderView ()<SDCycleScrollViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate>

/** 轮播图 */
@property (nonatomic,strong) SDCycleScrollView *cycleScrollView;
/** 分类UICollectionView */
@property (nonatomic, strong) UICollectionView *categoryCollectionView;
/** 活动推广banner */
@property (nonatomic,strong) SDCycleScrollView *promotionScrollView;

/** 间隔view */
@property (nonatomic, strong) UIView *gapView;

@end

@implementation HomePageHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

//  添加子控件
- (void)setupViews{
    [self addSubview:self.cycleScrollView];
    [self addSubview:self.categoryCollectionView];
    [self addSubview:self.promotionScrollView];
    [self addSubview:self.gapView];
}


/** 轮播网络图片 */
-(SDCycleScrollView *)cycleScrollView{
    if (!_cycleScrollView) {
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero delegate:self placeholderImage:[UIImage imageNamed:@"banner_placeholder_155"]];
        [_cycleScrollView setBackgroundColor:[UIColor whiteColor]];
        _cycleScrollView.autoScrollTimeInterval = 5;
        _cycleScrollView.layer.masksToBounds = YES;
        _cycleScrollView.layer.cornerRadius = 12;
        //设置轮播视图的分页控件的显示
        _cycleScrollView.showPageControl = YES;
        _cycleScrollView.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        //设置轮播视图分也控件的位置
        _cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
        //其他分页控件小圆标图片
        _cycleScrollView.pageControlDotSize = CGSizeMake(8, 3);
        _cycleScrollView.pageDotImage = [UIImage imageNamed:@"XL_first_qiu"];
        _cycleScrollView.currentPageDotImage = [UIImage imageNamed:@"XL_first_qiushi"];
        _cycleScrollView.frame = CGRectMake(10.0 * PX, 0, Main_Screen_Width - 20 * PX, 155 * PX);
    }
    return _cycleScrollView;
}


- (void)layoutSubviews{
    [super layoutSubviews];
}



- (UICollectionView *)categoryCollectionView{
    if (_categoryCollectionView == nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        _categoryCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _categoryCollectionView.backgroundColor = [UIColor whiteColor];
        _categoryCollectionView.showsVerticalScrollIndicator = NO;
        _categoryCollectionView.dataSource = self;
        _categoryCollectionView.delegate   = self;
        [_categoryCollectionView registerClass:[CategoryCollectionViewCell class] forCellWithReuseIdentifier:@"CategoryCollectionViewCell"];
        _categoryCollectionView.showsHorizontalScrollIndicator = NO;
    }
    return _categoryCollectionView;
}

- (SDCycleScrollView *)promotionScrollView{
    if (_promotionScrollView == nil) {
        _promotionScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero delegate:self placeholderImage:[UIImage imageNamed:@"banner_placeholder_180"]];
        [_promotionScrollView setBackgroundColor:[UIColor whiteColor]];
        _promotionScrollView.autoScrollTimeInterval = 8;
        //设置轮播视图的分页控件的显示
        _promotionScrollView.showPageControl = NO;
        _promotionScrollView.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        //设置轮播视图分也控件的位置
        _promotionScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
//        _promotionScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;

        //其他分页控件小圆标图片
        _promotionScrollView.pageControlDotSize = CGSizeMake(8, 3);
        _promotionScrollView.pageDotImage = [UIImage imageNamed:@"XL_first_qiu"];
        _promotionScrollView.currentPageDotImage = [UIImage imageNamed:@"XL_first_qiushi"];
    }
    return _promotionScrollView;
}

- (UIView *)gapView{
    if (_gapView == nil) {
        _gapView = [[UIView alloc] init];
        _gapView.backgroundColor = [UIColor colorWithHexString:COLOR_LIGHTBG_STR];
    }
    return _gapView;
}

/** 设置轮播图数组 */
- (void)setBannerImageArray:(NSArray *)bannerImageArray{
    if (_bannerImageArray != bannerImageArray) {
        _bannerImageArray = bannerImageArray;
    }
    
    if (!kArrayIsEmpty(_bannerImageArray)) {
        NSMutableArray *imageUrlArray = [NSMutableArray array];
        for (MallBannerModel *bannerModel in _bannerImageArray) {
            if (!kStringIsEmpty(bannerModel.image)) {
                [imageUrlArray addObject:bannerModel.image];
            }
        }
        
        self.cycleScrollView.imageURLStringsGroup = imageUrlArray;
    }
}

/** 设置分类菜单背景色 */
- (void)setCategoryBgColor:(NSString *)categoryBgColor{
    _categoryBgColor = categoryBgColor;
}

- (void)setCategoryFontColor:(NSString *)categoryFontColor{
    _categoryFontColor = categoryFontColor;
}

/** 设置分类菜单view */
- (void)setCategoryArray:(NSArray *)categoryArray{
    if (_categoryArray != categoryArray) {
        _categoryArray = categoryArray;
    }
    
    CGFloat cellWidth = AdaptedWidth(50.0);
    CGFloat cellHeight = cellWidth + AdaptedHeight(22.0);
    NSInteger categoryCount = _categoryArray.count;
    CGFloat categoryCollectionViewH = 0.0;
    if (categoryCount == 0) {
        //  不显示
        categoryCollectionViewH = 0.0;
    } else if (categoryCount >= 1 && categoryCount <= 5) {
        //  显示一行
        UIEdgeInsets contentInset = [self categoryContentEdgeInsetsWithCategoryCount:categoryCount];
        categoryCollectionViewH = contentInset.top + cellHeight + contentInset.bottom;
    } else {
        //  显示两行
        UIEdgeInsets contentInset = [self categoryContentEdgeInsetsWithCategoryCount:categoryCount];
        CGFloat lineSpacing = [self categoryLineSpaceWithCategoryCount:categoryCount];
        categoryCollectionViewH = contentInset.top + cellHeight * 2 + lineSpacing + contentInset.bottom;
    }
    self.categoryCollectionView.frame = CGRectMake(0.0, CGRectGetMaxY(self.cycleScrollView.frame), Main_Screen_Width, categoryCollectionViewH);
    if (self.categoryBgColor.length >0) {
        self.categoryCollectionView.backgroundColor = [UIColor colorWithHexString:self.categoryBgColor];
    }
    [self.categoryCollectionView reloadData];
    
    self.gapView.frame = CGRectMake(0.0, CGRectGetMaxY(self.categoryCollectionView.frame), Main_Screen_Width, AdaptedHeight(10.0));
    
    self.frame = CGRectMake(0.0, 0.0, Main_Screen_Width, CGRectGetMaxY(self.gapView.frame));
}

- (void)setPromotionImageArray:(NSArray *)promotionImageArray{
    if (_promotionImageArray != promotionImageArray) {
        _promotionImageArray = promotionImageArray;
    }
    
    if (!kArrayIsEmpty(_promotionImageArray)) {
        NSMutableArray *imageUrlArray = [NSMutableArray array];
        for (MallBannerModel *bannerModel in _promotionImageArray) {
            if (!kStringIsEmpty(bannerModel.image)) {
                [imageUrlArray addObject:bannerModel.image];
            }
        }
        
        self.promotionScrollView.imageURLStringsGroup = imageUrlArray;
        self.promotionScrollView.frame = CGRectMake(0.0, CGRectGetMaxY(self.categoryCollectionView.frame), Main_Screen_Width, (Main_Screen_Width * (200.0 / 375.0)));
        self.gapView.frame = CGRectMake(0.0, CGRectGetMaxY(self.promotionScrollView.frame), Main_Screen_Width, 0.001);
        
        self.frame = CGRectMake(0.0, 0.0, Main_Screen_Width, CGRectGetMaxY(self.promotionScrollView.frame));
    } else {
        self.promotionScrollView.frame = CGRectMake(0.0, CGRectGetMaxY(self.categoryCollectionView.frame), Main_Screen_Width, 0.001);
        self.gapView.frame = CGRectMake(0.0, CGRectGetMaxY(self.categoryCollectionView.frame), Main_Screen_Width, AdaptedHeight(10.0));
        
        self.frame = CGRectMake(0.0, 0.0, Main_Screen_Width, CGRectGetMaxY(self.gapView.frame));
    }
}

#pragma mark - SDCycleScrollViewDelegate 轮播图点击事件
/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    
    MallBannerModel *bannerModel;
    if (cycleScrollView == _cycleScrollView) {
        bannerModel = self.bannerImageArray[index];
        [ZTMXFUMengHelper mqEvent:k_super_banner_click parameter:@{@"index":@(index)}];
    } else if (cycleScrollView == _promotionScrollView) {
        bannerModel = self.promotionImageArray[index];
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(homePageHeaderViewClickBannerImage:)]) {
        [self.delegate homePageHeaderViewClickBannerImage:bannerModel];
    }
    
}

#pragma mark - UICollectionView代理方法
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.categoryArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CategoryCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CategoryCollectionViewCell" forIndexPath:indexPath];
    MallCategoryModel *mallCategoryModel = self.categoryArray[indexPath.row];
    if (self.categoryFontColor.length > 0) {
        mallCategoryModel.categoryFontColor = self.categoryFontColor;
    }
    cell.mallCategoryModel = mallCategoryModel;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    MallCategoryModel *categoryModel = self.categoryArray[indexPath.row];
    if (categoryModel) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(homePageHeaderViewClickCategory:)]) {
            [self.delegate homePageHeaderViewClickCategory:categoryModel];
        }
    }
}

#pragma mark - UICollectionViewDelegateFlowLayout 布局
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat cellWidth = AdaptedWidth(50.0);
    CGFloat cellHeight = cellWidth + AdaptedHeight(22.0);
    return CGSizeMake(cellWidth, cellHeight);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return [self categoryContentEdgeInsetsWithCategoryCount:self.categoryArray.count];
}
//  如果是水平布局: 设置Item左右间距.  如果是垂直布局: 设置Item上下间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return [self categoryLineSpaceWithCategoryCount:self.categoryArray.count];
}

//  垂直布局: 设置Item左右间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return [self categoryItemSpaceWithCategoryCount:self.categoryArray.count];
}

//  通过分类个数获取 content 的 UIEdgeInsets
- (UIEdgeInsets)categoryContentEdgeInsetsWithCategoryCount:(NSInteger)categoryCount{
    if (categoryCount <= 0) {
        return UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0);
    }
    if (categoryCount == 1) {
        //  一行排一个
        return UIEdgeInsetsMake(AdaptedHeight(15.0), AdaptedWidth(34.0), AdaptedHeight(12.0), AdaptedWidth(34));
    } else if (categoryCount == 2) {
        //  一行排两个
        return UIEdgeInsetsMake(AdaptedHeight(15.0), AdaptedWidth(34.0), AdaptedHeight(12.0), AdaptedWidth(34));
    } else if (categoryCount == 3 || categoryCount == 6) {
        //  一行排三个
        return UIEdgeInsetsMake(AdaptedHeight(15.0), AdaptedWidth(34.0), AdaptedHeight(12.0), AdaptedWidth(34));
    } else if (categoryCount == 4 || categoryCount == 7 || categoryCount == 8) {
        //  一行排四个
        return UIEdgeInsetsMake(AdaptedHeight(15.0), AdaptedWidth(22.0), AdaptedHeight(12.0), AdaptedWidth(22.0));
    } else if (categoryCount == 5 || categoryCount == 9 || categoryCount == 10) {
        //  一行排五个
        return UIEdgeInsetsMake(AdaptedHeight(18.0), AdaptedWidth(16.0), AdaptedHeight(20.0), AdaptedWidth(16.0));
    } else {
        //   一行排五个
        return UIEdgeInsetsMake(AdaptedHeight(18.0), AdaptedWidth(16.0), AdaptedHeight(20.0), AdaptedWidth(16.0));
    }
}

//  通过分类个数获取分类Item左右的间距
- (CGFloat)categoryItemSpaceWithCategoryCount:(NSInteger)categoryCount{
    if (categoryCount <= 1) {
        return 1.0;
    }

    //  边距
    UIEdgeInsets contentEdgeInsets = [self categoryContentEdgeInsetsWithCategoryCount:categoryCount];
    CGFloat cellWidth = AdaptedWidth(50.0);
    //  每行展示截个
    CGFloat rowItemCount = [self rowItemCountWithCategoryCount:categoryCount];
    CGFloat itemSpacing = (Main_Screen_Width - contentEdgeInsets.left - contentEdgeInsets.right - rowItemCount * cellWidth) / (rowItemCount - 1);
    return itemSpacing;
}

//  通过分类个数获取分类Item上下的间距
- (CGFloat)categoryLineSpaceWithCategoryCount:(NSInteger)categoryCount{
    if (categoryCount <= 0) {
        return 1.0;
    }
    
    if (categoryCount == 1) {
        //  一行排一个
        return AdaptedHeight(16.0);
    } else if (categoryCount == 2) {
        //  一行排两个
        return AdaptedHeight(16.0);
    } else if (categoryCount == 3 || categoryCount == 6) {
        //  一行排三个
        return AdaptedHeight(16.0);
    } else if (categoryCount == 4 || categoryCount == 7 || categoryCount == 8) {
        //  一行排四个
        return AdaptedHeight(16.0);
    } else if (categoryCount == 5 || categoryCount == 9 || categoryCount == 10) {
        //  一行排五个
        return AdaptedHeight(12.0);
    } else {
        //   一行排五个
        return AdaptedHeight(12.0);
    }
}

//  一行显示几个
- (NSInteger)rowItemCountWithCategoryCount:(NSInteger)categoryCount{
    if (categoryCount <= 1) {
        //  一行排一个
        return 1;
    } else if (categoryCount == 2) {
        //  一行排两个
        return 2;
    } else if (categoryCount == 3 || categoryCount == 6) {
        //  一行排三个
        return 3;
    } else if (categoryCount == 4 || categoryCount == 7 || categoryCount == 8) {
        //  一行排四个
        return 4;
    } else if (categoryCount == 5 || categoryCount == 9 || categoryCount == 10) {
        //  一行排五个
        return 5;
    } else {
        //   一行排五个
        return 5;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

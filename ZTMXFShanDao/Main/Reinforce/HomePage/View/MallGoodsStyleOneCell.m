//
//  MallGoodsStyleOneCell.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2018/1/13.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "MallGoodsStyleOneCell.h"
#import "ALATitleValueCellView.h"
#import "SDCycleScrollView.h"
#import "GoodsCategoryCollectionViewCell.h"
#import "HomePageMallModel.h"
#import "ZTMXFBannerGoodsFrame.h"

@interface MallGoodsStyleOneCell ()<SDCycleScrollViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
/** title */
@property (nonatomic, strong) ALATitleValueCellView *titleCellView;
/** 轮播图 */
@property (nonatomic, strong) SDCycleScrollView     *cycleScrollView;
/** 商品CollectionView */
@property (nonatomic, strong) UICollectionView      *goodsCollectionView;
/** 间隔view */
@property (nonatomic, strong) UIView                *gapView;

@end

@implementation MallGoodsStyleOneCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"MallGoodsStyleOneCell";
    MallGoodsStyleOneCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[MallGoodsStyleOneCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

/**
 *  cell的初始化方法，一个cell只会调用一次
 *  一般在这里添加所有可能显示的子控件，以及子控件的一次性设置
 */
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        // 点击cell的时候不要变色
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self setupViews];
        
    }
    return self;
}



- (void)layoutSubviews{
    [super layoutSubviews];
}

- (ALATitleValueCellView *)titleCellView{
    if (_titleCellView == nil) {
        _titleCellView = [[ALATitleValueCellView alloc] initWithTitle:@"" value:@"" target:self action:nil];
        _titleCellView.showRowImageView = NO;
        _titleCellView.showBottomLineView = NO;
        _titleCellView.backgroundColor = [UIColor whiteColor];
        _titleCellView.titleFont = [UIFont boldSystemFontOfSize:16];
        _titleCellView.titleColorStr = COLOR_BLACK_STR;
        _titleCellView.valueFont = [UIFont systemFontOfSize:13];
        _titleCellView.valueColorStr = COLOR_LIGHT_GRAY_STR;
    }
    return _titleCellView;
}


//  添加子控件
- (void)setupViews{
    /** title */
    [self.contentView addSubview:self.titleCellView];
    /** 轮播图 */
    [self.contentView addSubview:self.cycleScrollView];
    /** 商品CollectionView */
    [self.contentView addSubview:self.goodsCollectionView];
    /** 间隔view */
    [self.contentView addSubview:self.gapView];
}


/** 轮播网络图片 */
-(SDCycleScrollView *)cycleScrollView{
    if (!_cycleScrollView) {
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero delegate:self placeholderImage:[UIImage imageNamed:@"banner_placeholder_180"]];
        [_cycleScrollView setBackgroundColor:[UIColor whiteColor]];
        _cycleScrollView.autoScrollTimeInterval = 5;
        //设置轮播视图的分页控件的显示
        _cycleScrollView.showPageControl = YES;
        _cycleScrollView.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        //设置轮播视图分也控件的位置
        _cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
        //其他分页控件小圆标图片
        _cycleScrollView.pageControlDotSize = CGSizeMake(8, 3);

        _cycleScrollView.pageDotImage = [UIImage imageNamed:@"XL_first_qiu"];
        _cycleScrollView.currentPageDotImage = [UIImage imageNamed:@"XL_first_qiushi"];
        _cycleScrollView.layer.cornerRadius = 4.0;
        _cycleScrollView.clipsToBounds = YES;
    }
    return _cycleScrollView;
}

- (UICollectionView *)goodsCollectionView{
    if (_goodsCollectionView == nil) {
        CGFloat cellTopPadding = AdaptedHeight(2.0);
        CGFloat cellBottomPadding = AdaptedHeight(0.0);
        CGFloat cellLeftPadding = AdaptedWidth(12.0);
        CGFloat cellRightMarging = AdaptedWidth(12.0);
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.sectionInset = UIEdgeInsetsMake(cellTopPadding, cellLeftPadding, cellBottomPadding, cellRightMarging);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _goodsCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _goodsCollectionView.backgroundColor = [UIColor whiteColor];
        _goodsCollectionView.showsVerticalScrollIndicator = NO;
        _goodsCollectionView.dataSource = self;
        _goodsCollectionView.delegate   = self;
        [_goodsCollectionView registerClass:[GoodsCategoryCollectionViewCell class] forCellWithReuseIdentifier:@"GoodsCategoryCollectionViewCell"];
        _goodsCollectionView.showsHorizontalScrollIndicator = NO;
    }
    return _goodsCollectionView;
}

- (UIView *)gapView{
    if (_gapView == nil) {
        _gapView = [[UIView alloc] init];
        _gapView.backgroundColor = [UIColor colorWithHexString:COLOR_LIGHTBG_STR];
    }
    return _gapView;
}

//  设置页面数据
- (void)setBannerGoodsFrame:(ZTMXFBannerGoodsFrame *)bannerGoodsFrame{
    _bannerGoodsFrame = bannerGoodsFrame;
    _bannerGoodsModel = _bannerGoodsFrame.bannerGoodsModel;
    
    //  设置控件frame
    self.titleCellView.frame = _bannerGoodsFrame.titleCellViewFrame;
    self.cycleScrollView.frame = _bannerGoodsFrame.cycleScrollViewFrame;
    self.goodsCollectionView.frame = _bannerGoodsFrame.goodsCollectionViewFrame;
    self.gapView.frame = _bannerGoodsFrame.gapViewFrame;
    
    /** title */
    self.titleCellView.titleStr = _bannerGoodsModel.name;
    self.titleCellView.valueStr = @"精选优质好货";
    
    /** banner */
    if (!kArrayIsEmpty(_bannerGoodsModel.bannerList)) {
        NSMutableArray *imageUrlArray = [NSMutableArray array];
        for (MallBannerModel *bannerModel in _bannerGoodsModel.bannerList) {
            if (!kStringIsEmpty(bannerModel.image)) {
                [imageUrlArray addObject:bannerModel.image];
            }
        }
        self.cycleScrollView.imageURLStringsGroup = imageUrlArray;
    }
    
    //  商品
    [self.goodsCollectionView reloadData];
}

#pragma mark - UICollectionView代理方法
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.bannerGoodsModel.goodsList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    GoodsCategoryCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GoodsCategoryCollectionViewCell" forIndexPath:indexPath];
    NSArray *goodsArray = self.bannerGoodsModel.goodsList;
    MallGoodsModel *mallGoodsModel = goodsArray[indexPath.row];
    mallGoodsModel.goodsCount = goodsArray.count;
    cell.mallGoodsModel = mallGoodsModel;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *goodsArray = self.bannerGoodsModel.goodsList;
    MallGoodsModel *mallGoodsModel = goodsArray[indexPath.row];
    if (mallGoodsModel) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(mallGoodsStyleOneCellClickGoods:)]) {
            [self.delegate mallGoodsStyleOneCellClickGoods:mallGoodsModel];
        }
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat leftMargin = AdaptedWidth(12.0);
    NSArray *goodsArray = self.bannerGoodsModel.goodsList;
    if (goodsArray.count == 1) {
        CGFloat goodsImageWidth = Main_Screen_Width - leftMargin * 2;
        CGFloat goodsImageHeight = goodsImageWidth * 135.0 / 351.0;
        CGFloat goodsDescribeHeight = AdaptedHeight(52.0);
        return CGSizeMake(goodsImageWidth, goodsImageHeight + goodsDescribeHeight);
    } else if (goodsArray.count == 2) {
        CGFloat goodsImageWidth = (Main_Screen_Width - leftMargin * 2 - AdaptedWidth(2.0)) / 2.0;
        CGFloat goodsImageHeight = goodsImageWidth * 138.0 / 175.0;
        CGFloat goodsDescribeHeight = AdaptedHeight(52.0);
        return CGSizeMake(goodsImageWidth, goodsImageHeight + goodsDescribeHeight);
    } else if (goodsArray.count == 3) {
        CGFloat goodsImageWidth = (Main_Screen_Width - leftMargin * 2 - AdaptedWidth(30) * 2) / 3.0;
        CGFloat goodsImageHeight = goodsImageWidth;
        CGFloat goodsDescribeHeight = AdaptedHeight(40.0);
        return CGSizeMake(goodsImageWidth, goodsImageHeight + goodsDescribeHeight);
    } else if (goodsArray.count >= 4) {
        CGFloat goodsImageWidth = (Main_Screen_Width - leftMargin * 2 - AdaptedWidth(30) * 2) / 3.0;
        CGFloat goodsImageHeight = goodsImageWidth;
        CGFloat goodsDescribeHeight = AdaptedHeight(40.0);
        return CGSizeMake(goodsImageWidth, goodsImageHeight + goodsDescribeHeight);
    } else {
        return CGSizeMake(1.0, 1.0);
    }
}

//  如果是水平布局: 设置Item左右间距.  如果是垂直布局: 设置Item上下间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    NSArray *goodsArray = self.bannerGoodsModel.goodsList;
    if (goodsArray.count == 1) {
        return 1.0;
    } else if (goodsArray.count == 2) {
        return AdaptedWidth(2.0);
    } else if (goodsArray.count == 3) {
        return AdaptedWidth(30.0);
    } else if (goodsArray.count >= 4) {
        return AdaptedWidth(12.0);
    } else {
        return 1.0;
    }
}
#pragma mark - 轮播页代理方法
/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    if (index >= 0 && index < self.bannerGoodsModel.bannerList.count) {
        MallBannerModel *bannerModel = self.bannerGoodsModel.bannerList[index];
        if (bannerModel) {
            if (self.delegate && [self.delegate respondsToSelector:@selector(mallGoodsStyleOneCellClickBanner:cell:)]) {
                [self.delegate mallGoodsStyleOneCellClickBanner:bannerModel cell:self];
            }
        }
    }
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

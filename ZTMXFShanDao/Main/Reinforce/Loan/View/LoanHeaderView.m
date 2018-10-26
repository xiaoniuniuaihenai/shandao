//
//  LoanHeaderView.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2018/1/9.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "LoanHeaderView.h"
#import "SDCycleScrollView.h"
#import "ZTMXFTextLoopView.h"
#import "LSBorrowBannerModel.h"
#import "LSHornBarModel.h"

@interface LoanHeaderView ()<SDCycleScrollViewDelegate,TextLoopViewDelegate>

/** 轮播图 */
@property (nonatomic,strong) SDCycleScrollView *cycleScrollView;
/** 通知小icon */
@property (nonatomic, strong) UIImageView      *noticeImageView;
/** 通知 */
@property (nonatomic, strong) ZTMXFTextLoopView     *textLoopView;

@end

@implementation LoanHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}



- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat viewWidth = self.bounds.size.width;
    
    self.cycleScrollView.frame = CGRectMake(0.0,0.0,viewWidth, AdaptedHeight(180.0));
    self.noticeImageView.frame = CGRectMake(0.0, CGRectGetMaxY(self.cycleScrollView.frame), AdaptedWidth(30.0), AdaptedHeight(45.0));
    self.textLoopView.frame = CGRectMake(AdaptedWidth(30.0), AdaptedHeight(180.0) + AdaptedHeight(10.0), Main_Screen_Width - AdaptedWidth(50), AdaptedHeight(25.0));
}
//  添加子控件
- (void)setupViews{
    [self addSubview:self.cycleScrollView];
    [self addSubview:self.textLoopView];
    [self addSubview:self.noticeImageView];
}


/** 轮播网络图片 */
-(SDCycleScrollView *)cycleScrollView{
    if (!_cycleScrollView) {
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero delegate:self placeholderImage:[UIImage imageNamed:@"banner_placeholder_180"]];
        [_cycleScrollView setBackgroundColor:[UIColor colorWithHexString:COLOR_LIGHTBG_STR]];
        _cycleScrollView.autoScrollTimeInterval = 5;
        //设置轮播视图的分页控件的显示
        _cycleScrollView.showPageControl = YES;
        _cycleScrollView.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        //设置轮播视图分也控件的位置
        _cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
        //其他分页控件小圆标图片
        _cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
        _cycleScrollView.pageControlDotSize = CGSizeMake(8, 3);
        _cycleScrollView.pageDotImage = [UIImage imageNamed:@"XL_first_qiu"];
        _cycleScrollView.currentPageDotImage = [UIImage imageNamed:@"XL_first_qiushi"];
    }
    return _cycleScrollView;
}

- (UIImageView *)noticeImageView{
    if (_noticeImageView == nil) {
        _noticeImageView = [[UIImageView alloc] init];
        _noticeImageView.contentMode = UIViewContentModeCenter;
        _noticeImageView.hidden = YES;
    }
    return _noticeImageView;
}

- (ZTMXFTextLoopView *)textLoopView{
    if (_textLoopView == nil) {
        CGRect textLoopViewRect = CGRectMake(AdaptedWidth(30.0), AdaptedHeight(180.0), Main_Screen_Width - AdaptedWidth(50), AdaptedHeight(45.0));
        _textLoopView = [ZTMXFTextLoopView textLoopViewWith:nil loopInterval:4.0 initWithFrame:textLoopViewRect];
        _textLoopView.delegate = self;
    }
    return _textLoopView;
}

/** 设置轮播图数组 */
- (void)setBannerImageArray:(NSArray *)bannerImageArray{
    if (_bannerImageArray != bannerImageArray) {
        _bannerImageArray = bannerImageArray;
    }
    
    if (!kArrayIsEmpty(_bannerImageArray)) {
        NSMutableArray *imageUrlArray = [NSMutableArray array];
        for (LSBorrowBannerModel *bannerModel in _bannerImageArray) {
            if (!kStringIsEmpty(bannerModel.imageUrl)) {
                [imageUrlArray addObject:bannerModel.imageUrl];
            }
        }
        
        self.cycleScrollView.imageURLStringsGroup = imageUrlArray;
    }
}

/** 设置跑马灯数组 */
- (void)setNoticeTextArray:(NSArray *)noticeTextArray{
    if (noticeTextArray.count > 0) {
        NSMutableArray *textArray = [NSMutableArray array];
        NSMutableArray * nowArr = [NSMutableArray array];
        for (int i =0 ; i<noticeTextArray.count; i++) {
            LSHornBarModel * model = noticeTextArray[i];
            if (!kStringIsEmpty(model.content)) {
                [nowArr addObject:model];
                [textArray addObject:model.content];
            }
        }
        _noticeTextArray = [NSArray arrayWithArray:nowArr];
        self.noticeImageView.hidden = NO;
        [self.textLoopView configTextLoopArray:textArray];
    }
}

#pragma mark - SDCycleScrollViewDelegate 轮播图点击事件
/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    LSBorrowBannerModel *bannerModel = self.bannerImageArray[index];
    if (self.delegate && [self.delegate respondsToSelector:@selector(loanHeaderViewClickBannerImage:)]) {
        [self.delegate loanHeaderViewClickBannerImage:bannerModel];
    }
}
#pragma mark --
-(void)textLoopViewClickWithIndex:(NSInteger)index{
    LSHornBarModel * horModel = self.noticeTextArray[index];
    if ([_delegate respondsToSelector:@selector(loanHeaderViewClickTextLoopView:)]) {
        [_delegate loanHeaderViewClickTextLoopView:horModel];
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

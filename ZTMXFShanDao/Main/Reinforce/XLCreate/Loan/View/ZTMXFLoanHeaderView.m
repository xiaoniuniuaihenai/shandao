//
//  ZTMXFLoanHeaderView.m
//  ZTMXFXunMiaoiOS
//
//  Created by 陈传亮 on 2018/3/8.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "ZTMXFLoanHeaderView.h"
#import "SDCycleScrollView.h"
#import "LoanModel.h"
#import "UIViewController+Visible.h"
#import "LSMyMessageListViewController.h"
#import "UIViewController+Visible.h"
#import "LSNotificationModel+Persistence.h"
#import "UIButton+Attribute.h"
@interface ZTMXFLoanHeaderView ()<SDCycleScrollViewDelegate>

/** 轮播图 */
@property (nonatomic,strong) SDCycleScrollView * topCycleScrollView;
/** 跑马灯*/
@property (nonatomic,strong) SDCycleScrollView * bottomCycleScrollView;

@property (nonatomic, strong) UIView * whiteView;

@property (nonatomic, strong) UIView * lineView;

@property (nonatomic, strong) UIView * tzView;

@property (nonatomic, strong) UIButton * leftBtn;

@property (nonatomic, strong) UIButton * rigthBtn;
    
@property (nonatomic, strong) UIButton * arrowImg;


@property (nonatomic, assign) NSInteger  currentIndex;

@property (nonatomic, strong) UIImageView * laba;
    
    
@property (nonatomic, strong) UIView * bottomView;



@end


@implementation ZTMXFLoanHeaderView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.topCycleScrollView];
        _whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, self.height - 45 * PX, KW, 45 * PX)];
        _whiteView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_whiteView];
        self.clipsToBounds = YES;
        
        _bottomView =  [[UIView alloc] initWithFrame:CGRectMake(0, 0, KW, 45 * PX)];
        [_whiteView addSubview:_bottomView];
        _bottomView.backgroundColor = [UIColor whiteColor];
        [_bottomView addSubview:self.bottomCycleScrollView];
        _laba = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 28, 45 * PX)];
        _laba.image = [UIImage imageNamed:@"JQ_Message"];
        _laba.contentMode = UIViewContentModeCenter;
        [_bottomView addSubview:_laba];
        
        _arrowImg = [UIButton buttonWithType:UIButtonTypeCustom];
        _arrowImg.frame = CGRectMake(KW - 40, 0, 40, self.bottomCycleScrollView.height);
        [_arrowImg setImage:[UIImage imageNamed:@"mine_right_arrow"] forState:UIControlStateNormal];
        _arrowImg.hidden = YES;
        [_arrowImg addTarget:self action:@selector(pushOtherPage) forControlEvents:UIControlEventTouchUpInside];
        [_bottomView addSubview:_arrowImg];
        
        _tzView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _whiteView.width, _whiteView.height)];
        _tzView.backgroundColor = [UIColor whiteColor];
//        [_whiteView addSubview:_tzView];
        
        _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftBtn.frame = CGRectMake(10, 0, KW / 2, _tzView.height);
        [_leftBtn setImage:[UIImage imageNamed:@"JQ_Message"] forState:UIControlStateNormal];
        _leftBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_leftBtn setTitleColor:K_666666 forState:UIControlStateNormal];
        _leftBtn.titleLabel.font = FONT_Regular(14 * PX);
        [_tzView addSubview:_leftBtn];
        
        _rigthBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _rigthBtn.frame = CGRectMake(KW - 65, 0, 65, _tzView.height);
        [_rigthBtn setImage:[UIImage imageNamed:@"mine_right_arrow"] forState:UIControlStateNormal];
        _rigthBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
        [_rigthBtn setTitleColor:COLOR_SRT(@"9B9B9B") forState:UIControlStateNormal];
        _rigthBtn.titleLabel.font = FONT_Regular(14 * PX);
        [_rigthBtn addTarget:self action:@selector(pushMessagePage) forControlEvents:UIControlEventTouchUpInside];
        [_tzView addSubview:_rigthBtn];
        
        
        
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.height - 1, KW, 1)];
        _lineView.backgroundColor = COLOR_SRT(@"#F2F4F5");
        [self addSubview:_lineView];

//        [self showMeaageCount];
    }
    return self;
}


- (void)showMeaageCount
{
//    NSInteger count = [LSNotificationModel notifi_updateAllNumNotificationInfoNotRead];
//    if (count) {
//        _lineView.hidden = NO;
//        _tzView.hidden = NO;
//        _bottomView.hidden = YES;
//        NSString * countStr = [NSString stringWithFormat:@"%ld条", count];
//        NSString * str = [NSString stringWithFormat:@" 您有%@未读消息!", countStr];
//        [UIButton attributeWithBUtton:_leftBtn title:str titleColor:@"666666" forState:UIControlStateNormal attributes:@[countStr] attributeColors:@[K_GoldenColor]];
//    }else{
//        _lineView.hidden = YES;
//        _tzView.hidden = YES;
//        _bottomView.hidden = NO;
//
//    }
}

- (void)pushMessagePage
{
    if (![LoginManager loginState]) {
        [LoginManager presentLoginVCWithController:[UIViewController currentViewController]];
    } else {
        LSMyMessageListViewController *messageListVC = [[LSMyMessageListViewController alloc] init];
        [[UIViewController currentViewController].navigationController pushViewController:messageListVC animated:YES];
    }
}



- (void)bannerPushToNextPage:(NSInteger)index
{
    if (index < _loanModel.bannerList.count) {
        BannerList * bannerModel = _loanModel.bannerList[index];
        if (!bannerModel.titleName) {
            bannerModel.titleName = @"";
        }
        [ZTMXFUMengHelper mqEvent:k_banner_click parameter:@{@"index":[@(index) stringValue], @"titleName":bannerModel.titleName}];
        if (bannerModel.isNeedLogin == 1 && ![LoginManager loginState]) {
            //        需要登录的未登录 弹出登录
            [LoginManager presentLoginVCWithController:[UIViewController currentViewController]];
        }else{
            if ([bannerModel.type isEqualToString:@"H5_URL"]) {
                //    进入H5
                LSWebViewController * webVc = [[LSWebViewController alloc]init];
                // 去除字符串左右空格
                bannerModel.content = [bannerModel.content stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
                webVc.webUrlStr = bannerModel.content;
                [[UIViewController currentViewController].navigationController pushViewController:webVc animated:YES];
            }
        }
    }
}
/** 轮播网络图片 */
-(SDCycleScrollView *)topCycleScrollView{
    if (!_topCycleScrollView) {
        @WeakObj(self);
        _topCycleScrollView = [[SDCycleScrollView alloc] initWithFrame:CGRectMake(X(8), 0, KW - X(16), 121 * PX)];
        [_topCycleScrollView setBackgroundColor:[UIColor whiteColor]];
        _topCycleScrollView.layer.cornerRadius = X(12);
        _topCycleScrollView.layer.masksToBounds = YES;
        _topCycleScrollView.autoScrollTimeInterval = 5;
        //设置轮播视图的分页控件的显示
        _topCycleScrollView.placeholderImage = [UIImage imageNamed:@"banner_placeholder_155"];
        _topCycleScrollView.showPageControl = YES;
        _topCycleScrollView.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        //设置轮播视图分也控件的位置
        _topCycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
        _topCycleScrollView.pageControlDotSize = CGSizeMake(8, 3);
        _topCycleScrollView.pageDotImage = [UIImage imageNamed:@"XL_first_qiu"];
        _topCycleScrollView.currentPageDotImage = [UIImage imageNamed:@"XL_first_qiushi"];
        _topCycleScrollView.clickItemOperationBlock = ^(NSInteger currentIndex) {
            [selfWeak bannerPushToNextPage:currentIndex];
        };
    }
    return _topCycleScrollView;
}
- (void)messagePushToNextPage:(NSInteger)index
{
//    if (index < _loanModel.bannerList.count) {
    if (_loanModel.scrollbarList.count == 1) {
        index = 0;
    }
    ScrollbarList * bannerModel = _loanModel.scrollbarList[index];
    
    if (bannerModel.isNeedLogin==1&&![LoginManager loginState]) {
        //        需要登录的未登录 弹出登录
        [LoginManager presentLoginVCWithController:[UIViewController currentViewController]];
    }else{
        if (bannerModel.type && [bannerModel.type isEqualToString:@"H5_URL"]) {
            //    进入H5
            LSWebViewController * webVc = [[LSWebViewController alloc]init];
            webVc.webUrlStr = bannerModel.wordUrl;//http://tapi.666pano.com/h5/identifyResult.html 服务端返回
//            webVc.appInfoIgnore = YES;
            [[UIViewController currentViewController].navigationController pushViewController:webVc animated:YES];
        }
    }
}


-(SDCycleScrollView *)bottomCycleScrollView
{
    if (!_bottomCycleScrollView) {
        @WeakObj(self);
        _bottomCycleScrollView = [[SDCycleScrollView alloc] initWithFrame:CGRectMake(48, 0, KW - 90, 45 * PX)];
        _bottomCycleScrollView.titleLabelBackgroundColor = [UIColor clearColor];
        [_bottomCycleScrollView setBackgroundColor:[UIColor clearColor]];
        _bottomCycleScrollView.autoScrollTimeInterval = 4;
        _bottomCycleScrollView.titleLabelTextColor = COLOR_SRT(@"#666666");
        _bottomCycleScrollView.titleLabelTextFont = FONT_Regular(13);
        _bottomCycleScrollView.titleLabelTextAlignment = NSTextAlignmentLeft;
        //设置轮播视图的分页控件的显示
        _bottomCycleScrollView.showPageControl = NO;
        _bottomCycleScrollView.scrollDirection = UICollectionViewScrollDirectionVertical;
        _bottomCycleScrollView.hidesForSinglePage = NO;
        _bottomCycleScrollView.onlyDisplayText = YES;
        [_bottomCycleScrollView disableScrollGesture];

        _bottomCycleScrollView.clickItemOperationBlock = ^(NSInteger currentIndex) {
            [selfWeak messagePushToNextPage:currentIndex];
        };
        _bottomCycleScrollView.itemDidScrollOperationBlock = ^(NSInteger currentIndex) {
            [selfWeak showArrowImgWithIndex:currentIndex];
        };
    }
    return _bottomCycleScrollView;
}
    
- (void)pushOtherPage
{
    [self messagePushToNextPage:_currentIndex];
}
    
- (void)showArrowImgWithIndex:(NSInteger)index
{
    _currentIndex = index;
    if (_loanModel.scrollbarList.count == 1) {
        index = 0;
    }
    ScrollbarList * bannerModel = _loanModel.scrollbarList[index];
    if([bannerModel.type  isEqualToString:@"H5_URL"]){
        _arrowImg.hidden = NO;
    }else{
        _arrowImg.hidden = YES;
    }
}
    

- (void)setLoanModel:(LoanModel *)loanModel
{
    _loanModel = loanModel;
    _topCycleScrollView.imageURLStringsGroup = loanModel.bannerImgs;
        _bottomCycleScrollView.titlesGroup = loanModel.titles;
        if (loanModel.titles.count) {
            _bottomView.hidden = NO;
            _lineView.hidden = NO;
        }else{
            _lineView.hidden = YES;
            _bottomView.hidden = YES;
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

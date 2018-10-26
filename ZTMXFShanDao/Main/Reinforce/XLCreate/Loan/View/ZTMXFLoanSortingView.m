//
//  ZTMXFLoanSortingView.m
//  ZTMXFXunMiaoiOS
//
//  Created by 陈传亮 on 2018/5/3.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "ZTMXFLoanSortingView.h"
#import "ProductTagCell.h"
@interface ZTMXFLoanSortingView ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong)UIButton * whiteView;

@property (nonatomic, strong)UIButton * resetBtn;

@property (nonatomic, strong)UIButton * confirmBtn;

@property (nonatomic, strong)UILabel * titleLabel;

@property (nonatomic, copy)NSArray * items;

@property (nonatomic, strong)UICollectionView * tagView;

@property (nonatomic, assign)NSInteger index;


@property (nonatomic, copy)void(^loanSortingViewClickBtn)(void);



@end

@implementation ZTMXFLoanSortingView


+ (void)loanSortingViewWith:(NSArray *)items index:(NSInteger)index completeHandle:(clickCompleteHandle)completeHandle
{
    ZTMXFLoanSortingView * loanSortingView = [[ZTMXFLoanSortingView alloc] initWithFrame:CGRectMake(0, 0, KW, KH)];
    loanSortingView.items = @[@"额度最高",@"利率最低",@"期限最长"];
    loanSortingView.index = index;
    @WeakObj(loanSortingView);
    loanSortingView.loanSortingViewClickBtn = ^{
        completeHandle(loanSortingViewWeak.index);
    };
    [kKeyWindow addSubview:loanSortingView];
    [loanSortingView show];
    
}

- (void)show
{
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];

    [UIView animateWithDuration:.3f animations:^{
        self.whiteView.transform = CGAffineTransformMakeTranslation(-_whiteView.width, 0);
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.3f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [UIView animateWithDuration:.3 delay:0.3 usingSpringWithDamping:0.6 initialSpringVelocity:0.8 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            [UIView animateWithDuration:.3f animations:^{
                self.titleLabel.transform = CGAffineTransformMakeTranslation(-_whiteView.width + 25, 0);
                self.tagView.transform = CGAffineTransformMakeTranslation(-_whiteView.width + 25, 0);

            }];
        } completion:^(BOOL finished) {
            
        }];
       
    });
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.7f];
        self.whiteView = [UIButton buttonWithType:UIButtonTypeCustom];
        _whiteView.frame = CGRectMake(KW, 0, KW / 3 * 2, self.height);
        _whiteView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_whiteView];
        
        self.resetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _resetBtn.frame = CGRectMake(0, KH - 44, _whiteView.width / 2, 44);
        [_resetBtn setTitleColor:COLOR_SRT(@"#4A4A4A") forState:UIControlStateNormal];
        [_resetBtn setTitle:@"重置" forState:UIControlStateNormal];
        _resetBtn.titleLabel.font = FONT_Medium(16);
        [_whiteView addSubview:_resetBtn];
        [_resetBtn addTarget:self action:@selector(sortingResetBtn) forControlEvents:UIControlEventTouchUpInside];

        UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, _resetBtn.top + 1, _resetBtn.width, 1)];
        lineView.backgroundColor = K_BackgroundColor;
        [_whiteView addSubview:lineView];
        
        self.confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _confirmBtn.frame = CGRectMake(_resetBtn.right, KH - 44, _whiteView.width / 2, 44);
        _confirmBtn.backgroundColor = K_MainColor;
        [_confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
        _confirmBtn.titleLabel.font = FONT_Medium(16);
        [_whiteView addSubview:_confirmBtn];
        [_confirmBtn addTarget:self action:@selector(sortingConfirmBtn) forControlEvents:UIControlEventTouchUpInside];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(_whiteView.width, 20, 200, 25 * PX  )];
        _titleLabel.textColor = COLOR_SRT(@"#4A4A4A");
        _titleLabel.text = @"请选择排序方式";
        _titleLabel.font = FONT_Regular(18 * PX);
        [_whiteView addSubview:_titleLabel];
        
        
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumInteritemSpacing = 20;
        layout.minimumLineSpacing = 20;
        layout.itemSize = CGSizeMake(90, 38);
        _tagView = [[UICollectionView alloc] initWithFrame:CGRectMake(_whiteView.width, _titleLabel.bottom + 25 * PX, _whiteView.width - 50, KH - 150) collectionViewLayout:layout];
        _tagView.dataSource = self;
        _tagView.delegate = self;
//        [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        _tagView.backgroundColor = [UIColor whiteColor];
        [_tagView registerClass:[ProductTagCell class] forCellWithReuseIdentifier:@"cell"];
        _tagView.showsHorizontalScrollIndicator = NO;
        _tagView.scrollsToTop = NO;
        if (@available(iOS 11.0, *)) {
            _tagView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        
        [_whiteView addSubview:_tagView];
        
    }
    return self;
}



- (void)sortingResetBtn
{
    _index = 0;
    if (_loanSortingViewClickBtn) {
        _loanSortingViewClickBtn();
    }
    [self remove];

}
- (void)sortingConfirmBtn
{
    if (_loanSortingViewClickBtn) {
        _loanSortingViewClickBtn();
    }
    [self remove];
    
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _items.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ProductTagCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.tagLabel.text = _items[indexPath.row];
    if (indexPath.item  != (_index - 1)) {
        cell.tagLabel.textColor  = COLOR_SRT(@"#D9D9D9");
        cell.contentView.layer.borderColor = COLOR_SRT(@"#D9D9D9").CGColor;
        cell.tagLabel.textColor = COLOR_SRT(@"#D9D9D9");
    }else{
        cell.tagLabel.textColor  = K_GoldenColor;
        cell.tagLabel.textColor = K_GoldenColor;
        cell.contentView.layer.borderColor = K_GoldenColor.CGColor;
    }
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    _index = indexPath.item + 1;
    [_tagView reloadData];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
//
//    [UIView animateWithDuration:.3f animations:^{
//        self.whiteView.transform = CGAffineTransformIdentity;
//    } completion:^(BOOL finished) {
//        [self removeFromSuperview];
//    }];
    
    [self remove];
}

- (void)remove
{
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
    
    [UIView animateWithDuration:.3f animations:^{
        self.whiteView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end

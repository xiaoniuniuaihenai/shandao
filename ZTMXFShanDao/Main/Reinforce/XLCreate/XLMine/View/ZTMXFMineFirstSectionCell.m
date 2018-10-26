//
//  ZTMXFMineFirstSectionCell.m
//  ZTMXFXunMiaoiOS
//
//  Created by 余金超 on 2018/5/15.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "ZTMXFMineFirstSectionCell.h"
#import "ZTMXFMineFirstSectionItem.h"

#define K_Cell @"cell"
@interface ZTMXFMineFirstSectionCell ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, assign) CGFloat heightED;

@end

@implementation ZTMXFMineFirstSectionCell

+ (CGFloat)cellHeight{
    return X(118);
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self.heightED = 0;
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubview:self.collectionView];
//        self.collectionView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.frame.size.height);
    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
#pragma mark ====== UICollectionViewDelegate ======
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//    if (self.dataAry.count == 0) {
//        return 1;
//    } else {
        return self.dataAry.count;
//    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ZTMXFMineFirstSectionItem *cell = [collectionView dequeueReusableCellWithReuseIdentifier:K_Cell forIndexPath:indexPath];
    cell.dict = self.dataAry[indexPath.row];
    [self updateCollectionViewHeight:self.collectionView.collectionViewLayout.collectionViewContentSize.height];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.itemSeletedBlock) {
        self.itemSeletedBlock([[self.dataAry[indexPath.row] allKeys]firstObject]);
    }
}

- (void)updateCollectionViewHeight:(CGFloat)height {
    if (self.heightED != height) {
        self.heightED = height;
        self.collectionView.frame = CGRectMake(0, X(23), self.collectionView.frame.size.width, height);
    }
}

#pragma mark ====== init ======
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.itemSize = CGSizeMake((KW - X(33)) / 4 - 8, X(72));
        layout.minimumInteritemSpacing = 6.8;
//        layout.sectionInset = UIEdgeInsetsMake(X(5), X(3.5), X(5), X(3.5));
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, X(23), KW, [[self class] cellHeight] - X(23)) collectionViewLayout:layout];
        _collectionView.backgroundColor = UIColor.redColor;
        _collectionView.contentInset = UIEdgeInsetsMake(0, X(16.5), 0, X(16.5));
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[ZTMXFMineFirstSectionItem class] forCellWithReuseIdentifier:K_Cell];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
//        _collectionView.scrollEnabled = NO;
        _collectionView.backgroundColor = [UIColor whiteColor];
    }
    return _collectionView;
}

- (void)setDataAry:(NSArray *)dataAry {
    self.heightED = 0;
    _dataAry = dataAry;
    [_collectionView reloadData];
}

@end

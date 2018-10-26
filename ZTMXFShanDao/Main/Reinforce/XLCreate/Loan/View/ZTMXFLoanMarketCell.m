//
//  ZTMXFLoanMarketCell.m
//  ZTMXFXunMiaoiOS
//
//  Created by 陈传亮 on 2018/3/20.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "ZTMXFLoanMarketCell.h"
#import "ZTMXFLoanCollectionViewCell.h"

@interface ZTMXFLoanMarketCell ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong)UICollectionView * collectionView;

@end


@implementation ZTMXFLoanMarketCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        //设置CollectionView的属性
        flowLayout.itemSize = CGSizeMake(KW,KH);
//        _collectionView = [[UICollectionView alloc] init];
//        _collectionView.collectionViewLayout = flowLayout;
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, KW, KH) collectionViewLayout:flowLayout];
        self.collectionView.backgroundColor = [UIColor whiteColor];
        self.collectionView.pagingEnabled = YES;
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        self.collectionView.scrollEnabled = YES;
        [self.collectionView registerClass:[ZTMXFLoanCollectionViewCell class] forCellWithReuseIdentifier:@"ZTMXFLoanCollectionViewCell"];
        [self.contentView addSubview:self.collectionView];
        //注册Cell
        
        
        _collectionView.sd_layout
        .leftEqualToView(self.contentView)
        .rightEqualToView(self.contentView)
        .topEqualToView(self.contentView)
        .bottomEqualToView(self.contentView);
        
        
    }
    return self;
    
}

#pragma mark  设置CollectionView每组所包含的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataArray.count;
}

#pragma mark  设置CollectionCell的内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"ZTMXFLoanCollectionViewCell";
    ZTMXFLoanCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    cell.dataArr = _dataArray[indexPath.row];
    return cell;
}






- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setDataArray:(NSArray *)dataArray
{
    _dataArray = dataArray;
    [self.collectionView reloadData];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

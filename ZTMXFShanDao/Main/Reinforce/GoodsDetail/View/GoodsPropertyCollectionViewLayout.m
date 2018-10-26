//
//  GoodsPropertyCollectionViewLayout.m
//  Himalaya
//
//  Created by 杨鹏 on 16/8/17.
//  Copyright © 2016年 ala. All rights reserved.
//

#import "GoodsPropertyCollectionViewLayout.h"
#import "GoodsChoiseView.h"

@interface GoodsPropertyCollectionViewLayout ()

@property (nonatomic, weak) id<UICollectionViewDelegateFlowLayout> delegate;
@property (strong, nonatomic) NSMutableArray *itemAttributes;//保存cell的布局
@property (nonatomic, strong) NSMutableArray  *headerAttributes;
@property (nonatomic, strong) NSMutableArray  *footerAttributes;
@property (nonatomic, strong) NSMutableArray  *cellAttributes;
@property (nonatomic, strong) NSMutableArray  *attributes;

@end

@implementation GoodsPropertyCollectionViewLayout

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.headerViewHeight = collectionHeaderH;
        self.footViewHeight = collectionFooterH;
        self.startY = 0.0;
        self.minimumLineSpacing = 10.0;
        self.minimumInteritemSpacing = 10.0;
        
        self.itemAttributes = [NSMutableArray array];
        self.headerAttributes = [NSMutableArray array];
        self.footerAttributes = [NSMutableArray array];
        self.cellAttributes = [NSMutableArray array];
        self.attributes = [NSMutableArray array];
    }
    return self;
}


- (void)prepareLayout
{
    [super prepareLayout];
    
    //重新布局需要清空
    [self.itemAttributes removeAllObjects];
    [self.headerAttributes removeAllObjects];
    [self.footerAttributes removeAllObjects];
    [self.cellAttributes removeAllObjects];
    [self.attributes removeAllObjects];
    self.startY = 0.0;

    CGFloat originX = self.sectionInset.left;
    
    //取有多少个section
    NSInteger sectionsCount = [self.collectionView numberOfSections];
    
    for (NSInteger section = 0; section < sectionsCount; section++) {
        
        NSIndexPath *supplementaryViewIndexPath = [NSIndexPath indexPathForRow:0 inSection:section];
        //头视图的高度不为0并且根据代理方法能取到对应的头视图的时候，添加对应头视图的布局对象
        if (self.headerViewHeight>0 && [self.collectionView.dataSource respondsToSelector:@selector(collectionView: viewForSupplementaryElementOfKind: atIndexPath:)]) {
            
            UICollectionViewLayoutAttributes *attribute = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:GoodsPropertyCollectionViewHeader withIndexPath:supplementaryViewIndexPath];
            //设置frame
            attribute.frame = CGRectMake(0.0, self.startY, self.collectionView.frame.size.width, collectionHeaderH);
            self.startY += collectionHeaderH;
            
            NSLog(@"%@", NSStringFromCGRect(attribute.frame));
            
            //保存布局对象
            [self.itemAttributes addObject:attribute];
            [self.attributes addObject:attribute];
        } else {
            self.startY += self.topAndBottomDustance;
        }
        
        
        //取出section有多少个row
        NSInteger rowsCount = [self.collectionView numberOfItemsInSection:section];
        originX = self.sectionInset.left;
        NSMutableArray *sectionArray = [NSMutableArray array];
        //分别计算设置每个cell的布局对象
        for (NSInteger row = 0; row < rowsCount; row++) {
            NSIndexPath *cellIndePath =[NSIndexPath indexPathForItem:row inSection:section];
            UICollectionViewLayoutAttributes *attribute = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:cellIndePath];
            
            CGSize itemSize = [self itemSizeForIndexPath:cellIndePath];
            
            if ((originX + itemSize.width + self.sectionInset.right/2) > self.collectionView.frame.size.width) {
                originX = self.sectionInset.left;
                self.startY += itemSize.height + self.minimumLineSpacing;
                
            }
            attribute.frame = CGRectMake(originX, self.startY, itemSize.width, itemSize.height);
            
            if (row == (rowsCount - 1)) {
                self.startY += itemSize.height + 10.0;
            }
            
            [self.attributes addObject:attribute];
            [sectionArray addObject:attribute];
            
            originX += itemSize.width + self.minimumInteritemSpacing;
        }
        [self.itemAttributes addObject:sectionArray];

        
        //存储footView属性
        //尾视图的高度不为0并且根据代理方法能取到对应的尾视图的时候，添加对应尾视图的布局对象
        if (section == (sectionsCount - 1)) {
            if (self.footViewHeight>0 && [self.collectionView.dataSource respondsToSelector:@selector(collectionView: viewForSupplementaryElementOfKind: atIndexPath:)]) {
                
                UICollectionViewLayoutAttributes *attribute = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:GoodsPropertyCollectionViewFooter withIndexPath:supplementaryViewIndexPath];
                attribute.frame = CGRectMake(0, self.startY + self.minimumLineSpacing, self.collectionView.frame.size.width, collectionFooterH);
                [self.footerAttributes addObject:attribute];
                [self.attributes addObject:attribute];
                self.startY = self.startY + self.footViewHeight + self.sectionInset.bottom + self.minimumLineSpacing;
            }
        } else {
            
            if ([self.collectionView.dataSource respondsToSelector:@selector(collectionView: viewForSupplementaryElementOfKind: atIndexPath:)]) {
                
                UICollectionViewLayoutAttributes *attribute = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:GoodsPropertyCollectionViewFooter withIndexPath:supplementaryViewIndexPath];
                attribute.frame = CGRectMake(10.0, self.startY + 0.5 + self.topAndBottomDustance, self.collectionView.frame.size.width - 20.0, 0.5);
                [self.footerAttributes addObject:attribute];
                [self.attributes addObject:attribute];
                self.startY += (0.5 + self.topAndBottomDustance);
            }
            
        }
    }
}



- (CGSize)collectionViewContentSize
{
    CGFloat collectionWidth = self.collectionView.frame.size.width;
    if (self.startY < styleCollectionViewH) {
        return CGSizeMake(collectionWidth, self.startY + 20.0);
    } else {
        return CGSizeMake(collectionWidth, self.startY + 20.0);
    }
}


- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return self.attributes;
}

//插入cell的时候系统会调用改方法
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *attribute = self.itemAttributes[indexPath.section][indexPath.row];
    return attribute;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *attribute = nil;
    if ([elementKind isEqualToString:GoodsPropertyCollectionViewHeader]) {
        attribute = self.headerAttributes[indexPath.section];
    }else if ([elementKind isEqualToString:GoodsPropertyCollectionViewFooter]){
        attribute = self.footerAttributes[indexPath.section];
    }
    return attribute;
}


- (id<UICollectionViewDelegateFlowLayout>)delegate
{
    if (_delegate == nil) {
        _delegate =  (id<UICollectionViewDelegateFlowLayout>)self.collectionView.delegate;
    }
    
    return _delegate;
}

- (CGSize)itemSizeForIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(collectionView:layout:sizeForItemAtIndexPath:)]) {
        self.itemSize = [self.delegate collectionView:self.collectionView layout:self sizeForItemAtIndexPath:indexPath];
    }
    
    return self.itemSize;
}


@end

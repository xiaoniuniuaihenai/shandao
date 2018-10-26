//
//  ZTMXFLoanSupermarketCell.m
//  ZTMXFXunMiaoiOS
//
//  Created by 陈传亮 on 2018/3/10.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "ZTMXFLoanSupermarketCell.h"
#import "LSLoanSupermarketModel.h"
//#import "ProductTagCell.h"
#import "UILabel+Attribute.h"
#import "UIViewController+Visible.h"
#import "ZTMXFLoanSupermarketTagCell.h"
#import "UIImageView+OSS.h"

@interface ZTMXFLoanSupermarketCell ()
/**
 周期
 */
@property (nonatomic, strong)UILabel * cycleLabel;
/**
 利率
 */
@property (nonatomic, strong)UILabel * interestRateLabel;
/**
 额度
 */
@property (nonatomic, strong)UILabel * linesLabel;


@property (nonatomic, strong)UILabel * firstLabel;

@property (nonatomic, strong)UILabel * secondLabel;




@end


@implementation ZTMXFLoanSupermarketCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _iconView = [UIImageView new];
        _iconView.layer.masksToBounds = NO;
//        _iconView.contentMode = UIViewContentModeScaleAspectFill;
        _nameLabel = [UILabel new];
        _nameLabel.textColor = COLOR_SRT(@"#333333");
        _nameLabel.font = FONT_Regular(17 * PX);

//        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
//        layout.minimumInteritemSpacing = 0.1;
//        _tagView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
//        _tagView.dataSource = self;
//        _tagView.delegate = self;
//        [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
//        _tagView.backgroundColor = [UIColor whiteColor];
//        [_tagView registerClass:[ZTMXFLoanSupermarketTagCell class] forCellWithReuseIdentifier:@"cell"];
//        _tagView.showsHorizontalScrollIndicator = NO;
//        _tagView.scrollsToTop = NO;
//        if (@available(iOS 11.0, *)) {
//            _tagView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
//        }

        
        _firstLabel = [UILabel new];
        _firstLabel.font = FONT_Regular(12 * PX);
        _firstLabel.textColor  = K_2B91F0;
        _firstLabel.layer.borderColor = K_2B91F0.CGColor;
        _firstLabel.textAlignment = NSTextAlignmentCenter;
        _firstLabel.layer.borderWidth = 1;
        _firstLabel.layer.cornerRadius = 3;

        _secondLabel = [UILabel new];
        _secondLabel.font = FONT_Regular(12 * PX);
        _secondLabel.textColor  = K_GoldenColor;
        _secondLabel.layer.borderColor = K_GoldenColor.CGColor;
        _secondLabel.textAlignment = NSTextAlignmentCenter;
        _secondLabel.layer.cornerRadius = 3;
        _secondLabel.layer.borderWidth = 1;

        
        _interestRateLabel = [UILabel new];
        _interestRateLabel.numberOfLines = 2;
        _interestRateLabel.textAlignment = NSTextAlignmentCenter;
        
        _cycleLabel = [UILabel new];
        _cycleLabel.numberOfLines = 2;
        _cycleLabel.textAlignment = NSTextAlignmentCenter;
        
        _linesLabel = [UILabel new];
        _linesLabel.numberOfLines = 2;
        _linesLabel.textAlignment = NSTextAlignmentCenter;
        
        _angleImgView = [UIImageView new];
        
        
        
        UIView * bottomLine = [UIView new];
        bottomLine.backgroundColor = K_BackgroundColor;
        
        [self.contentView addSubview:_iconView];
        [self.contentView addSubview:_nameLabel];
        [self.contentView addSubview:_firstLabel];
        [self.contentView addSubview:_secondLabel];

//        [self.contentView addSubview:_tagView];
        [self.contentView addSubview:_interestRateLabel];
        [self.contentView addSubview:_cycleLabel];
        [self.contentView addSubview:_linesLabel];
        [self.contentView addSubview:_angleImgView];

        [self.contentView addSubview:bottomLine];


        _iconView.sd_layout
        .leftSpaceToView(self.contentView, 20 * PX)
        .widthIs(30 * PX)
        .heightIs(30 * PX)
        .topSpaceToView(self.contentView, 17.5 * PX);
        _iconView.sd_cornerRadius = @5;
        
        
        _angleImgView.sd_layout
        .rightEqualToView(self.contentView)
        .topEqualToView(self.contentView)
        .heightIs(60 * PX)
        .widthIs(74 * PX);

        _nameLabel.sd_layout
        .centerYEqualToView(_iconView)
        .leftSpaceToView(_iconView, 10)
        .heightIs(22);
        [_nameLabel setSingleLineAutoResizeWithMaxWidth:KW / 2];
        
        
//        _firstLabel.sd_layout
//        .leftSpaceToView(_nameLabel, 8 * PX )
//        .centerYEqualToView(_iconView)
//        .heightIs(18 * PX);
//
//        [_firstLabel setSingleLineAutoResizeWithMaxWidth:100];
//
//        _secondLabel.sd_layout
//        .leftSpaceToView(_firstLabel, 14)
//        .centerYEqualToView(_firstLabel)
//        .heightIs(18 * PX);
//
//        [_secondLabel setSingleLineAutoResizeWithMaxWidth:100];


//        _tagView.sd_layout
//        .leftSpaceToView(_nameLabel, 8 * PX )
//        .centerYEqualToView(_iconView)
//        .rightSpaceToView(self.contentView, 30)
//        .heightIs(18 * PX);
        
//        _tagView.backgroundColor = DEBUG_COLOR;
        _interestRateLabel.sd_layout
        .leftEqualToView(self.contentView)
        .topSpaceToView(self.contentView, 65 * PX)
        .heightIs(65 * PX)
        .widthIs(KW / 3);
        
        _cycleLabel.sd_layout
        .leftSpaceToView(_interestRateLabel, 5)
        .topEqualToView(_interestRateLabel)
        .bottomEqualToView(_interestRateLabel)
        .widthIs(KW / 3 - 10);
        
        _linesLabel.sd_layout
        .leftSpaceToView(_cycleLabel, 5)
        .topEqualToView(_interestRateLabel)
        .bottomEqualToView(_interestRateLabel)
        .widthIs(KW / 3);
    
        
        bottomLine.sd_layout
        .leftEqualToView(self.contentView)
        .rightEqualToView(self.contentView)
        .bottomEqualToView(self.contentView)
        .heightIs(5);
        [self drawDottedLine];
        
    }
    return self;
}


//- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
//{
//    return _loanSupermarketModel.marketLabel.count;
//}
//
//- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    ZTMXFLoanSupermarketTagCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
//    cell.tagLabel.text = _loanSupermarketModel.marketLabel[indexPath.row];
//    if (indexPath.item % 2 == 0) {
//        cell.tagLabel.textColor  = K_MainColor;
//        cell.tagLabel.layer.borderColor = K_MainColor.CGColor;
//        cell.tagLabel.textColor = K_MainColor;
//    }else{
//        cell.tagLabel.textColor  = K_GoldenColor;
//        cell.tagLabel.textColor = K_GoldenColor;
//        cell.tagLabel.layer.borderColor = K_GoldenColor.CGColor;
//    }
//    return cell;
//}
//
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    CGFloat w = [ZTMXFLoanSupermarketTagCell adaptionWidth:_loanSupermarketModel.marketLabel[indexPath.row]];
//    NSLog(@"======================%.2f",  w);
//    return CGSizeMake(w + 14, 18 * PX);
//}

- (void)setLoanSupermarketModel:(LSLoanSupermarketModel *)loanSupermarketModel
{
    _loanSupermarketModel = loanSupermarketModel;
//    [_iconView sd_setImageWithURL:[NSURL URLWithString:_loanSupermarketModel.iconUrl] placeholderImage:nil];
    [_iconView OSS_setImageWithString:_loanSupermarketModel.iconUrl h:100.f placeholderImage:nil];
    _nameLabel.text = _loanSupermarketModel.lsmName;
    _angleImgView.hidden = YES;
    if (_loanSupermarketModel.iconLabel == 1) {
        _angleImgView.hidden = NO;
        _angleImgView.image = [UIImage imageNamed:@"XL_recommend"];
    }else if (_loanSupermarketModel.iconLabel == 2){

    }else if (_loanSupermarketModel.iconLabel == 3){
        _angleImgView.hidden = NO;
        _angleImgView.image = [UIImage imageNamed:@"XL_welfare"];
    }else if (_loanSupermarketModel.iconLabel == 4){
        _angleImgView.hidden = NO;
        _angleImgView.image = [UIImage imageNamed:@"XL_king"];

    }
    
    if (!_loanSupermarketModel.interestRateStr) {
        _loanSupermarketModel.interestRateStr = @"";
    }
    _interestRateLabel.text = [NSString stringWithFormat:@"%@\n最低利率", _loanSupermarketModel.interestRateStr];
    [UILabel attributeWithLabel:_interestRateLabel text:_interestRateLabel.text textColor:@"#9B9B9B" attributesOriginalColorStrs:@[_loanSupermarketModel.interestRateStr] attributeNewColors:@[COLOR_SRT(@"333333")] textFont:12 * PX attributesOriginalFontStrs:@[_loanSupermarketModel.interestRateStr] attributeNewFonts:@[FONT_Regular(18 * PX)]];
    
    
    if (!_loanSupermarketModel.cycleDateStr) {
        _loanSupermarketModel.cycleDateStr = @"";
    }
    _linesLabel.text = [NSString stringWithFormat:@"%@\n最长周期", _loanSupermarketModel.cycleDateStr];
    [UILabel attributeWithLabel:_cycleLabel text:_linesLabel.text textColor:@"#9B9B9B" attributesOriginalColorStrs:@[_loanSupermarketModel.cycleDateStr] attributeNewColors:@[COLOR_SRT(@"333333")] textFont:12 * PX attributesOriginalFontStrs:@[_loanSupermarketModel.cycleDateStr] attributeNewFonts:@[FONT_Regular(18 * PX)]];
    if (!_loanSupermarketModel.maxLoanAmountStr) {
        _loanSupermarketModel.maxLoanAmountStr = @"";
    }
    _linesLabel.text = [NSString stringWithFormat:@"%@\n最高额度", _loanSupermarketModel.maxLoanAmountStr];
    [UILabel attributeWithLabel:_linesLabel text:_linesLabel.text textColor:@"#9B9B9B" attributesOriginalColorStrs:@[_loanSupermarketModel.maxLoanAmountStr] attributeNewColors:@[COLOR_SRT(@"#FD4014")] textFont:12 * PX attributesOriginalFontStrs:@[_loanSupermarketModel.maxLoanAmountStr] attributeNewFonts:@[FONT_Medium(18 * PX)]];
//
    _firstLabel.hidden = YES;
    _secondLabel.hidden = YES;
    if (!_loanSupermarketModel.marketLabel) {

    }else if (_loanSupermarketModel.marketLabel.count == 1) {
        _firstLabel.text = [NSString stringWithFormat:@"%@", _loanSupermarketModel.marketLabel[0]];
        _firstLabel.hidden = NO;
        _firstLabel.sd_layout
        .leftSpaceToView(_nameLabel, 10)
        .centerYEqualToView(_iconView)
        .heightIs(18 * PX)
        .widthIs([ZTMXFLoanSupermarketTagCell adaptionWidth:_loanSupermarketModel.marketLabel[0]]);

    }else if (_loanSupermarketModel.marketLabel.count > 1){
        _firstLabel.text = [NSString stringWithFormat:@"%@", _loanSupermarketModel.marketLabel[0]];
        _secondLabel.text = [NSString stringWithFormat:@"%@", _loanSupermarketModel.marketLabel[1]];
        _firstLabel.hidden = NO;
        _secondLabel.hidden = NO;

        _firstLabel.sd_layout
        .leftSpaceToView(_nameLabel, 10)
        .centerYEqualToView(_iconView)
        .heightIs(18 * PX)
        .widthIs([ZTMXFLoanSupermarketTagCell adaptionWidth:_loanSupermarketModel.marketLabel[0]]);

        _secondLabel.sd_layout
        .leftSpaceToView(_firstLabel, 10)
        .centerYEqualToView(_iconView)
        .heightIs(18 * PX)
        .widthIs([ZTMXFLoanSupermarketTagCell adaptionWidth:_loanSupermarketModel.marketLabel[1]]);
        
    }
    //    [_tagView reloadData];

}


-(void)drawDottedLine
{
    CAShapeLayer *dotteShapeLayer = [CAShapeLayer layer];
    CGMutablePathRef dotteShapePath =  CGPathCreateMutable();
    //设置虚线颜色为blackColor
    [dotteShapeLayer setStrokeColor:[K_BackgroundColor CGColor]];
    //设置虚线宽度
    dotteShapeLayer.lineWidth = 1.0f ;
    //10=线的宽度 5=每条线的间距
    NSArray *dotteShapeArr = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:7.0f],[NSNumber numberWithInt:3.5f], nil];
    [dotteShapeLayer setLineDashPattern:dotteShapeArr];
    CGPathMoveToPoint(dotteShapePath, NULL, 15 ,65 * PX);
    CGPathAddLineToPoint(dotteShapePath, NULL, KW - 15, 65 * PX);
    [dotteShapeLayer setPath:dotteShapePath];
    CGPathRelease(dotteShapePath);
    //把绘制好的虚线添加上来
    [self.layer addSublayer:dotteShapeLayer];
}





- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
@end

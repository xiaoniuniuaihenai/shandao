//
//  PFDropMenuView.h
//  WSDropMenuView
//
//  Created by panfei mao on 2018/1/1.
//  Copyright © 2018年 Senro Wong. All rights reserved.
//

#import <UIKit/UIKit.h>

#define WSNoFound (-1)

/**
 *  目前是写死的 左边三级－ 修改的话 挺简单的  只要 修改didselect 点到第二级收回  还有修改tableview的宽度 既可以了  －
 */

@interface PFIndexPath : NSObject

@property (nonatomic,assign) NSInteger row; //第一级的行
@property (nonatomic,assign) NSInteger item; //第二级的行
@property (nonatomic,assign) NSInteger rank; //第三级的行

+ (instancetype)twIndexPathWithColumn:(NSInteger )column
                                  row:(NSInteger )row
                                 item:(NSInteger )item
                                 rank:(NSInteger )rank;

@end


@class PFDropMenuView;

@protocol PFDropMenuViewDataSource <NSObject>


- (NSInteger )dropMenuView:(PFDropMenuView *)dropMenuView numberWithIndexPath:(PFIndexPath *)indexPath;

- (NSString *)dropMenuView:(PFDropMenuView *)dropMenuView titleWithIndexPath:(PFIndexPath *)indexPath;


@end



@protocol PFDropMenuViewDelegate <NSObject>


- (void)dropMenuView:(PFDropMenuView *)dropMenuView didSelectWithIndexPath:(PFIndexPath *)indexPath title:(NSString *)title;


@end

@interface PFDropMenuView : UIView

@property (nonatomic,weak) id<PFDropMenuViewDataSource> dataSource;
@property (nonatomic,weak) id<PFDropMenuViewDelegate> delegate;

@property (nonatomic, copy) NSString *industryName;

- (void)reloadLeftTableView;


@end

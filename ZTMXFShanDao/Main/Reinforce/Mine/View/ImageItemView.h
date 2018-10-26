//
//  ImageItemView.h
//  ZTMXFXunMiaoiOS
//
//  Created by 朱吉达 on 2018/1/30.
//  Copyright © 2018年 LSCredit. All rights reserved.
//  图片添加删除视图item

#import <UIKit/UIKit.h>

@interface ImageItemView : UIView
@property (nonatomic,weak) id delegate;
-(void)changeStateWithIsSelect:(BOOL)isSelect imageSelect:(UIImage *)image;
@end
@protocol ImageItemViewDelegate
@optional
-(void)didSelectImageItemView:(ImageItemView *)itemView;
-(void)removeImageItemView:(ImageItemView *)itemView;
@end

//
//  LSBorrowGoodsScrollBarModel.h
//  ALAFanBei
//
//  Created by Try on 2017/7/27.
//  Copyright © 2017年 讯秒. All rights reserved.
//  借贷超市 使用的弹幕

#import <Foundation/Foundation.h>

@interface LSBorrowGoodsScrollBarModel : NSObject
/** 文字地址*/
@property (nonatomic,copy) NSString * wordUrl;
/** 滚动条名字*/
@property (nonatomic,copy) NSString * name;
/** 分类的值类型 跳转普通H5地址, 如H5_URL,UN_URL*/
@property (nonatomic,copy) NSString * type;
/**文案*/
@property (nonatomic,copy) NSString * content;

@end

//
//  LSAreaModel.h
//  Himalaya
//
//  Created by 苏伟丽 on 16/8/19.
//  Copyright © 2016年 ala. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LSCustomBaseModel.h"

@interface LSAreaModel : LSCustomBaseModel

@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSString *firstletter;

@property (nonatomic, copy) NSString *rid;
@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *parentCode;
@property (nonatomic, copy) NSString *pinyin;

@property (nonatomic, copy) NSString *shengzhixia;
@property (nonatomic, copy) NSString *type;//省：PROVINCE，市：CITY, 区/县： COUNTY
@property (nonatomic, copy) NSString *zhixiashi;
@property (nonatomic, copy) NSString *isOpen;//0、未开通 1、已开通

@end


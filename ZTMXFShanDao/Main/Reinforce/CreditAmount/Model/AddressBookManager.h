//
//  AddressBookManager.h
//  JiBeiCreditConsume
//
//  Created by yangpenghua on 2017/11/27.
//  Copyright © 2017年 jibei. All rights reserved.
//  通讯录访问

#import <Foundation/Foundation.h>

@protocol AddressBookManagerDelegate <NSObject>

@optional
/** 是否允许访问通讯录 */
- (void)addressBookManagerAllowAccess:(BOOL)access;

/** 认证成功 */
- (void)addressBookManagerAuthSuccess;

@end

@interface AddressBookManager : NSObject

/** 通讯录认证 */
- (void)addressBookAuthWithContact;

@property (nonatomic, weak) id<AddressBookManagerDelegate> delegate;

@end

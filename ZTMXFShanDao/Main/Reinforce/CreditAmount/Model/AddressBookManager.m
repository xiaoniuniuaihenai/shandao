//
//  AddressBookManager.m
//  JiBeiCreditConsume
//
//  Created by yangpenghua on 2017/11/27.
//  Copyright © 2017年 jibei. All rights reserved.
//

#import "AddressBookManager.h"
#import "LSAuthContactsApi.h"
#import "WJYAlertView.h"
#import <Contacts/Contacts.h>
#import <ContactsUI/ContactsUI.h>
#import <AddressBookUI/AddressBookUI.h>

@implementation AddressBookManager


#pragma mark - 通讯录授权
-(void)authoriseAddressBook
{
    [WJYAlertView showOneButtonWithTitle:@"温馨提示" Message:@"请允许闪到访问手机通讯录" ButtonType:WJYAlertViewButtonTypeDefault ButtonTitle:@"去设置" Click:^{
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
    }];
}
/** 通讯录认证 */
- (void)addressBookAuthWithContact{
    NSLog(@"ddd");
    [self CheckAddressBookAuthorization:^(bool isAuthorized, bool isUp_ios_9) {
        if (isAuthorized) {
            [self accessAddressBook];
            [ZTMXFUMengHelper mqEvent:k_contactlist_get_xf];
            
        }else {
            //  通讯录授权
            [self authoriseAddressBook];
        }
        if (self.delegate && [self.delegate respondsToSelector:@selector(addressBookManagerAllowAccess:)]) {
            [self.delegate addressBookManagerAllowAccess:isAuthorized];
        }
    }];
}
#pragma mark 获取通讯录
- (void)CheckAddressBookAuthorization:(void (^)(bool isAuthorized , bool isUp_ios_9))block {
    if (isIOS9) {
        CNContactStore * contactStore = [[CNContactStore alloc]init];
        if ([CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts] == CNAuthorizationStatusNotDetermined) {
            [contactStore requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * __nullable error) {
                if (error)
                {
                    NSLog(@"Error: %@", error);
                }
                else if (!granted)
                {
                    
                    block(NO,YES);
                }
                else
                {
                    block(YES,YES);
                }
            }];
        } else if ([CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts] == CNAuthorizationStatusAuthorized){
            block(YES,YES);
        } else {
            block(NO,YES);
        }
    }else {
        ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
        ABAuthorizationStatus authStatus = ABAddressBookGetAuthorizationStatus();
        
        if (authStatus == kABAuthorizationStatusNotDetermined)
        {
            ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (error)
                    {
                        NSLog(@"Error: %@", (__bridge NSError *)error);
                    }
                    else if (!granted)
                    {
                        
                        block(NO,NO);
                    }
                    else
                    {
                        block(YES,NO);
                    }
                    //                    if(addressBook){
                    //                        CFRelease(addressBook);
                    //                    }
                });
            });
        } else if (authStatus == kABAuthorizationStatusAuthorized){
            block(YES,NO);
            //            if(addressBook){
            //                CFRelease(addressBook);
            //            }
        } else {
            block(NO,NO);
            //            if(addressBook){
            //                CFRelease(addressBook);
            //            }
        }
        
        
    }
    
}

#pragma mark 通讯录操作
- (void)accessAddressBook
{
    [SVProgressHUD showLoading];
    NSString *addressBookStr = @"";
    //创建通讯簿的引用
    ABAddressBookRef addBook = ABAddressBookCreateWithOptions(NULL, NULL);
    //获取所有联系人的数组
    CFArrayRef allLinkPeople = ABAddressBookCopyArrayOfAllPeople(addBook);
    //获取联系人总数
    CFIndex number = ABAddressBookGetPersonCount(addBook);
    //进行遍历
    for (NSInteger i=0; i<number; i++) {
        //获取联系人对象的引用
        ABRecordRef  people = CFArrayGetValueAtIndex(allLinkPeople, i);
        //获取当前联系人姓氏
        NSString*firstName=(__bridge NSString *)(ABRecordCopyValue(people,kABPersonLastNameProperty));
        //获取当前联系人名字
        NSString*lastName=(__bridge NSString *)(ABRecordCopyValue(people, kABPersonFirstNameProperty));
        firstName = [self isEmptyString:firstName]?@"":firstName;
        lastName = [self isEmptyString:lastName]?@"":lastName;
        NSString *name = [NSString stringWithFormat:@"%@%@",firstName,lastName];
        NSString *filterName = [NSString filterSymbol:name];
        if (filterName.length < 1) {
            filterName = @"xxx";
        }
        
        //获取当前联系人的电话 数组
        NSMutableArray * phoneArr = [[NSMutableArray alloc]init];
        ABMultiValueRef phones= ABRecordCopyValue(people, kABPersonPhoneProperty);
        for (NSInteger j=0; j<ABMultiValueGetCount(phones); j++) {
            [phoneArr addObject:(__bridge NSString *)(ABMultiValueCopyValueAtIndex(phones, j))];
        }
        NSString *phoneStr = [phoneArr componentsJoinedByString:@"&"];
        if (phoneStr.length < 1) {
            phoneStr = @"xxx";
        }
        NSString *personStr = [NSString stringWithFormat:@"%@:%@", filterName,phoneStr];
        if (i != (number - 1)) {
            personStr = [personStr stringByAppendingString:@","];
        }
        addressBookStr = [addressBookStr stringByAppendingString:personStr];
        
    }
    
    addressBookStr = [[addressBookStr stringByReplacingOccurrencesOfString:@" " withString:@""] stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
    //传通讯录
    [self matchAddressBookWithDataStr:addressBookStr];
}



#pragma mark 提交通信录
- (void)matchAddressBookWithDataStr:(NSString *)dataStr{
    LSAuthContactsApi * contactsApi = [[LSAuthContactsApi alloc]initWithContacts:dataStr];
    [contactsApi requestWithSuccess:^(NSDictionary *responseDict) {
        [SVProgressHUD dismiss];
        NSString * codeStr = [responseDict[@"code"]description];
        if ([codeStr isEqualToString:@"1000"]) {
            //    友盟统计通讯录认证完成
//            [kKeyWindow makeCenterToast:@"通讯录认证成功"];
            if (self.delegate && [self.delegate respondsToSelector:@selector(addressBookManagerAuthSuccess)]) {
                [self.delegate addressBookManagerAuthSuccess];
            }
            //  通讯录获取成功
            [self accesAddressBookSuccessStatistics];
        }
    } failure:^(__kindof YTKBaseRequest *request) {
        [SVProgressHUD dismiss];
    }];
}
#pragma mark 判断字符串是否为空
- (BOOL)isEmptyString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}
#pragma mark - 通讯录获取成功
- (void)accesAddressBookSuccessStatistics{
}


@end

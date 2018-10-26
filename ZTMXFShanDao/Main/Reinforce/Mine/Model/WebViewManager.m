//
//  WebViewManager.m
//  YWLTMeiQiiOS
//
//  Created by yangpenghua on 2017/9/26.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "WebViewManager.h"

@implementation WebViewManager

+(CYwebAddAppUINameType)addAppUINameTypeWithName:(NSString*)addUiName{
    if ([addUiName isEqualToString:@"SHOWSHARE"]) {
        return CYwebAddAppUINameTypeShare;
    } else if ([addUiName isEqualToString:@"COUPONS"]) {
        return CYwebAddAppUINameTypeMyCoupon;
    } else if ([addUiName isEqualToString:@"WIN_RANK"]) {
        return CYwebAddAppUINameTypeLastWinRank;
    } else if ([addUiName isEqualToString:@"KEFU"]) {
        return CYwebAddAppUINameTypeCustomerServices;
    }
    return CYwebAddAppUINameTypeDef;
}

+(CYWebOpennativeNameType)opennativeNameTypeWithName:(NSString *)name{
    if ([name isEqualToString:@"GOODS_DETAIL_INFO"]) {
        return GOODS_DETAIL_INFO;
    }else if([name isEqualToString:@"APP_LOGIN"]){
        return APP_LOGIN;
    }else if([name isEqualToString:@"BORROW_MONEY"]){
        return BORROW_MONEY;
    }else if ([name isEqualToString:@"APP_SHARE"]){
        return APP_SHARE;
    }else if ([name isEqualToString:@"APP_SIGNIN"]){
        return APP_SIGNIN;
    }else if ([name isEqualToString:@"MINE_COUPON_LIST"]){
        return MINE_COUPON_LIST;
    }else if ([name rangeOfString:@"BRAND_ORDER_CONFIRM"].location !=NSNotFound){
        return BOLUOMI_CHOISE_PAYMENT;
    }else if ([name rangeOfString:@"APP_HOME"].location !=NSNotFound){
        return JUMP_HOMEPAGE;
    }else if ([name rangeOfString:@"APP_TRADE_PAY"].location !=NSNotFound){
        return APP_TRADE_PAY;
    }else if ([name rangeOfString:@"APP_TRADE_PROMOTE"].location !=NSNotFound){
        return APP_TRADE_PROMOTE;
    }else if ([name rangeOfString:@"DO_SCAN_ID"].location !=NSNotFound){
        return DO_SCAN_ID;
    }else if ([name rangeOfString:@"DO_FACE"].location !=NSNotFound){
        return DO_FACE;
    }else if ([name rangeOfString:@"DO_BIND_CARD"].location !=NSNotFound){
        return DO_BIND_CARD;
    }else if ([name rangeOfString:@"DO_PROMOTE_BASIC"].location !=NSNotFound){
        return DO_PROMOTE_BASIC;
    }else if ([name rangeOfString:@"DO_PROMOTE_EXTRA"].location !=NSNotFound){
        return DO_PROMOTE_EXTRA;
    }else if ([name rangeOfString:@"APP_CONTACT_CUSTOMER"].location !=NSNotFound){
        return APP_CONTACT_CUSTOMER;
    }else if ([name rangeOfString:@"APP_INVITE"].location != NSNotFound) {
        return APP_INVITE;
    }else if ([name rangeOfString:@"RETURN_BACK"].location != NSNotFound){
        return RETURN_BACK;
    }else if ([name rangeOfString:@"DO_WHITE_RISK"].location != NSNotFound){
        return DO_WHITE_RISK;
    }else if ([name rangeOfString:@"CATEGORY"].location != NSNotFound){
        return CATEGORY;
    }else if ([name rangeOfString:@"MALL_AUTH_LIST"].location != NSNotFound){
        return MALL_AUTH_LIST;
    }else if ([name rangeOfString:@"LOAN_AUTH_LIST"].location != NSNotFound){
        return LOAN_AUTH_LIST;
    }else if ([name rangeOfString:@"MALL_HOME"].location != NSNotFound){
        return MALL_HOME;
    }else if ([name rangeOfString:@"FORGET_PASSWORD"].location != NSNotFound){
        return FORGET_PASSWORD;
    }else if ([name rangeOfString:@"ORDER_DETAILS"].location != NSNotFound){
        return ORDER_DETAILS;
    }
    
    
    return COMMON_VIEW_CONTROLLER;
}

@end

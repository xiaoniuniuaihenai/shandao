//
//  MobileRechargeInfoViewModel.m
//  ZTMXFXunMiaoiOS
//
//  Created by 朱吉达 on 2018/1/31.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "ZTMXFMobileRechargeInfoViewModel.h"
#import "CreateRechargeOrderInfoModel.h"
#import "MobileRechargeInfoModel.h"
#import "MobileRechargeListApi.h"
#import "CreateMobileRechargeOrderApi.h"
@implementation ZTMXFMobileRechargeInfoViewModel


-(void)requestRechargeInfoWithProvince:(NSString *)province company:(NSString*)company{
        MobileCompanyType companyType = MobileCompanyTypeMobileUnknown;
        if ([company isEqualToString:@"移动"]) {
            companyType = MobileCompanyTypeMobile;
        }else if([company isEqualToString:@"电信"]){
            companyType = MobileCompanyTypeTelecom;
    
        }else if ([company isEqualToString:@"联通"]){
            companyType = MobileCompanyTypeUnicom;
        }
        [SVProgressHUD showLoading];
    
        MobileRechargeListApi * listApi = [[MobileRechargeListApi alloc] initWithProvince:province company:companyType];
        [listApi requestWithSuccess:^(NSDictionary *responseDict) {
            NSString * codeStr = [responseDict[@"code"]description];
            if ([codeStr isEqualToString:@"1000"]) {
                NSDictionary * rechargeData = responseDict[@"data"];
                MobileRechargeInfoModel * rechargeInfo = [MobileRechargeInfoModel mj_objectWithKeyValues:rechargeData];
                if ([_delegate respondsToSelector:@selector(requestRechargeInfoSuccess:)]) {
                    [_delegate requestRechargeInfoSuccess:rechargeInfo];
                }
//                _chooseMoneyView.arrPayMoneyArr = _rechargeMoneyList;
//                //            没有数据是按钮不可点击
//                _btnSubmitBtn.userInteractionEnabled = _rechargeMoneyList.count>0?YES:NO;
//                _btnSubmitBtn.selected = !_btnSubmitBtn.userInteractionEnabled;
            }
            [SVProgressHUD dismiss];
        } failure:^(__kindof YTKBaseRequest *request) {
            [SVProgressHUD dismiss];
        }];
}


#pragma mark -- -生成充值订单
-(void)requestCreateRechargeOrderWithOrderInfoModel:(CreateRechargeOrderInfoModel *)orderInfoModel{
    [SVProgressHUD showLoading];
    CreateMobileRechargeOrderApi * orderApi = [[CreateMobileRechargeOrderApi alloc]initWithOrderInfo:orderInfoModel];
    [orderApi requestWithSuccess:^(NSDictionary *responseDict) {
        NSString * codeStr = [responseDict[@"code"]description];
        if ([codeStr isEqualToString:@"1000"]) {
            NSString * orderId = [responseDict[@"data"][@"rid"]description];
            orderInfoModel.rid = orderId;
            if ([_delegate respondsToSelector:@selector(requestCreateRechargeOrderSuccess:)]) {
                [_delegate requestCreateRechargeOrderSuccess:orderInfoModel];
            }
        }
        [SVProgressHUD dismiss];

    } failure:^(__kindof YTKBaseRequest *request) {
        [SVProgressHUD dismiss];
    }];
}
@end

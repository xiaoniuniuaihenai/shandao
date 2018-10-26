//
//  MyAddressViewModel.m
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2017/12/11.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "MyAddressViewModel.h"
#import "ModifyAddressApi.h"
#import "MyAddressListApi.h"
#import "DefaultAddressApi.h"
#import "LSAddressModel.h"

@interface MyAddressViewModel ()

@end

@implementation MyAddressViewModel

-(void)requestAddressListDataWithPageNum:(NSInteger)pageNum pageSize:(NSInteger)pageSize
{
    MyAddressListApi *addressListApi = [[MyAddressListApi alloc] initWithId:nil pageNum:pageNum pageSize:(NSInteger)pageSize];
    [addressListApi requestWithSuccess:^(NSDictionary *responseDict) {
        NSLog(@"%@", responseDict);
        NSString *codeStr = [responseDict[@"code"] description];
        if ([codeStr isEqualToString:@"1000"]) {
            
            NSArray *addressArray = responseDict[@"data"][@"list"];
            
            NSArray *addressModelArray = [LSAddressModel mj_objectArrayWithKeyValuesArray:addressArray];
            if (self.delegete && [self.delegete respondsToSelector:@selector(getAddressListSuccess:)]) {
                [self.delegete getAddressListSuccess:addressModelArray];
            }
        }else{
            if (self.delegete && [self.delegete respondsToSelector:@selector(requestDataFailure)]) {
                [self.delegete requestDataFailure];
            }
        }
        
    } failure:^(__kindof YTKBaseRequest *request) {
        //增加无数据展现
        if (self.delegete && [self.delegete respondsToSelector:@selector(requestDataFailure)]) {
            [self.delegete requestDataFailure];
        }
    }];
}

- (void)requestModifyAddressDataWithDict:(NSDictionary *)paramsDict{
    
    ModifyAddressApi *modifyAddressApi = [[ModifyAddressApi alloc] initWithParamsDict:paramsDict];
    [SVProgressHUD show];
    [modifyAddressApi requestWithSuccess:^(NSDictionary *responseDict) {
        NSString *codeStr = [responseDict[@"code"] description];
        [SVProgressHUD dismiss];
        if ([codeStr isEqualToString:@"1000"]) {
            NSString *opera = paramsDict[@"opera"];
            if ([opera isEqualToString:@"delete"]) {
                if (self.delegete && [self.delegete respondsToSelector:@selector(deleteAddressSuccess)]) {
                    
                    [self.delegete deleteAddressSuccess];
                }
            }else{
                if (self.delegete && [self.delegete respondsToSelector:@selector(modifyAddressSuccess)]) {
                    
                    [self.delegete modifyAddressSuccess];
                }
            }
        }
        
    } failure:^(__kindof YTKBaseRequest *request) {
        [SVProgressHUD dismiss];
        if (self.delegete && [self.delegete respondsToSelector:@selector(requestDataFailure)]) {
            [self.delegete requestDataFailure];
        }
    }];
}

-(void)requestDefaultAddressData{
    
    DefaultAddressApi *defaultAddressApi = [[DefaultAddressApi alloc] init];
    [defaultAddressApi requestWithSuccess:^(NSDictionary *responseDict) {
        NSLog(@"%@", responseDict);
        NSString *codeStr = [responseDict[@"code"] description];
        if ([codeStr isEqualToString:@"1000"]) {
            
            NSDictionary *defaultAddressDict = responseDict[@"data"][@"userAddress"];
            LSAddressModel *defaultaddressModel = [LSAddressModel mj_objectWithKeyValues:defaultAddressDict];
            
            if (self.delegete && [self.delegete respondsToSelector:@selector(getDefaultAddressSuccess:)]) {
                [self.delegete getDefaultAddressSuccess:defaultaddressModel];
            }
        }
    } failure:^(__kindof YTKBaseRequest *request) {
        if (self.delegete && [self.delegete respondsToSelector:@selector(requestDataFailure)]) {
            [self.delegete requestDataFailure];
        }
    }];
}

@end

//
//  MyAddressViewModel.h
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2017/12/11.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LSAddressModel;

@protocol LSAddressViewModelDelegate<NSObject>

@optional

/**  获取地址列表*/
- (void)getAddressListSuccess:(NSArray *)addressModelArray;

- (void)modifyAddressSuccess;

- (void)deleteAddressSuccess;
/**  获取默认地址*/
- (void)getDefaultAddressSuccess:(LSAddressModel *)defaultAddress;
/**  获取地址失败 */
- (void)requestDataFailure;

@end

@interface MyAddressViewModel : NSObject

@property (nonatomic, weak) id <LSAddressViewModelDelegate> delegete;

-(void)requestAddressListDataWithPageNum:(NSInteger)pageNum pageSize:(NSInteger)pageSize;

- (void)requestModifyAddressDataWithDict:(NSDictionary *)paramsDict;
/**  获取默认地址*/
- (void)requestDefaultAddressData;

@end

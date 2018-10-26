//
//  ChoiseBankCardView.h
//  ALAFanBei
//
//  Created by yangpenghua on 17/3/23.
//

typedef enum : NSUInteger {
    CHOISE_BANK_CARD_VIEW_REIMBURSEMENT,//还款
    CHOISE_BANK_CARD_VIEW_DEFERRED_PAYMENT,//延期还款
} CHOISE_BANK_CARD_VIEW_TYPE;

#import <UIKit/UIKit.h>
@class BankCardModel;
@protocol ChoiseBankCardViewDelegate <NSObject>

//  点击返回按钮
- (void)choiseBankCardViewClickBackButton;
//  选中银行卡
- (void)choiseBankCardViewDidSelectedBankCard:(BankCardModel *)bankCardModel;
//  添加银行卡
- (void)choiseBankCardViewAddBankCard;

@end

@interface ChoiseBankCardView : UIView

@property (nonatomic, weak) id<ChoiseBankCardViewDelegate> delegate;
/** 初始化方法,传0不显示支付宝,传1显示支付宝 */
- (instancetype)initWithChoiseBankCardViewType:(CHOISE_BANK_CARD_VIEW_TYPE)type;
/** 初始化方法,传0不显示支付宝,传1显示支付宝 */
- (instancetype)initWithFrame:(CGRect)frame choiseBankCardViewType:(CHOISE_BANK_CARD_VIEW_TYPE)type;
/** 选中银行卡ID */
@property (nonatomic, copy) NSString *selectBankCardId;

@end

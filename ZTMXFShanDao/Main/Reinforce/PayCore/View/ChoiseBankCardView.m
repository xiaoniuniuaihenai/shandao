//
//  ChoiseBankCardView.m
//  ALAFanBei
//
//  Created by yangpenghua on 17/3/23.
//

#import "ChoiseBankCardView.h"
#import "ChoiseBankCardTableViewCell.h"
#import "BankCardModel.h"
#import "BankCardListApi.h"
#import "BankCardListModel.h"

@interface ChoiseBankCardView ()<UITableViewDelegate, UITableViewDataSource>
/** tableView */
@property (nonatomic, strong) UITableView *tableView;
/** back button */
@property (nonatomic, strong) UIButton *backButton;
/** header title label */
@property (nonatomic, strong) UILabel *headerLabel;
/** line view */
@property (nonatomic, strong) UIView *lineView;

/** 银行列表model */
@property (nonatomic, strong) BankCardListModel *bankCardListModel;
/** 银行卡列表模型 */
@property (nonatomic, strong) NSMutableArray *bankCardArray;

@property (nonatomic, assign) CHOISE_BANK_CARD_VIEW_TYPE type;

@end

@implementation ChoiseBankCardView

- (NSMutableArray *)bankCardArray{
    if (_bankCardArray == nil) {
        _bankCardArray = [NSMutableArray array];
    }
    return _bankCardArray;
}


/** 初始化方法,传0不显示支付宝,传1显示支付宝 */
- (instancetype)initWithChoiseBankCardViewType:(CHOISE_BANK_CARD_VIEW_TYPE)type{
    if (self = [super init]) {
        _type = type;
        self.backgroundColor = [UIColor whiteColor];
        //  添加子控件
        [self setupViews];
        //  获取银行卡列表
        [self bankCardList];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame choiseBankCardViewType:(CHOISE_BANK_CARD_VIEW_TYPE)type
{
    self = [self initWithFrame:frame];
    if (self) {
        _type = type;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        //  添加子控件
        [self setupViews];
        //  获取银行卡列表
        [self bankCardList];
    }
    return self;

}

//  添加子控件
- (void)setupViews{
    
    self.backButton = [UIButton setupButtonWithImageStr:@"nav_back" title:@"" titleColor:[UIColor whiteColor] titleFont:14 withObject:self action:@selector(backButtonAction)];
    [self addSubview:self.backButton];
    
    self.headerLabel = [UILabel labelWithTitleColorStr:COLOR_BLACK_STR fontSize:17 alignment:NSTextAlignmentCenter];
    self.headerLabel.text = @"选择银行卡";
    [self addSubview:self.headerLabel];
    
    self.lineView = [UIView setupViewWithSuperView:self withBGColor:COLOR_BORDER_STR];
    
    //  添加TableView
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0,CGRectGetMaxY(self.headerLabel.frame), Main_Screen_Width, 100.0) style:UITableViewStylePlain];
    tableView.backgroundColor = [UIColor whiteColor];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.showsVerticalScrollIndicator = NO;
    self.tableView = tableView;
    [self addSubview:self.tableView];
    
}

#pragma mark - TableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.bankCardArray.count + 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == self.bankCardArray.count){
        return 52;
    }else{
        BankCardModel *_bankCardModel =(BankCardModel *)self.bankCardArray[indexPath.row];
        if (_bankCardModel.isValid == 0) {
            return 70;
        } else {
            if (kStringIsEmpty(_bankCardModel.channelDesc)) {
                return 52;
            }else{
                return 70;
            }
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChoiseBankCardTableViewCell *cell = [ChoiseBankCardTableViewCell cellWithTableView:tableView];
    if (indexPath.row == self.bankCardArray.count) {
        //  添加银行卡
        cell.iconImageView.image = [UIImage imageNamed:@"add_bank_card"];
        cell.titleLabel.text = @"添加银行卡";
        cell.showRowImage = YES;
    } else {
        BankCardModel *bankCardModel = self.bankCardArray[indexPath.row];
        cell.bankCardModel = bankCardModel;
        cell.showRowImage = NO;
        if ([bankCardModel.rid isEqualToString:self.selectBankCardId]) {
            //  当前银行卡是选中状态
            cell.showSelectedImage = NO;
        } else {
            cell.showSelectedImage = NO;
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ChoiseBankCardTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([cell.titleLabel.text isEqualToString:@"添加银行卡"]) {
        //  添加银行卡
        if (self.delegate && [self.delegate respondsToSelector:@selector(choiseBankCardViewAddBankCard)]) {
            [self.delegate choiseBankCardViewAddBankCard];
        }
    } else {
        //  选中银行卡
        BankCardModel *bankCardModel = self.bankCardArray[indexPath.row];
        if (bankCardModel.isValid == 0) {
            //  如果银行卡无效则不选择
            return;
        } else {
            if (self.delegate && [self.delegate respondsToSelector:@selector(choiseBankCardViewDidSelectedBankCard:)]) {
                self.selectBankCardId = bankCardModel.rid;
                [self.delegate choiseBankCardViewDidSelectedBankCard:bankCardModel];
            }
        }
    }
}

//  布局子控件
- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat viewHeight = self.bounds.size.height;
    CGFloat headerHeight = 57.0;
    
    self.backButton.frame = CGRectMake(0.0, 0.0, 44.0, headerHeight);
    self.headerLabel.frame = CGRectMake(CGRectGetWidth(self.backButton.frame), 0.0, SCREEN_WIDTH - 2 * CGRectGetWidth(self.backButton.frame), headerHeight);
    self.lineView.frame = CGRectMake(0.0, headerHeight - 0.5, SCREEN_WIDTH, 0.5);
    self.tableView.frame = CGRectMake(0.0, CGRectGetMaxY(self.headerLabel.frame), SCREEN_WIDTH, viewHeight - CGRectGetMaxY(self.headerLabel.frame) - 70.0);
    
}

//  点击返回按钮
- (void)backButtonAction{
    if (self.delegate && [self.delegate respondsToSelector:@selector(choiseBankCardViewClickBackButton)]) {
        [self.delegate choiseBankCardViewClickBackButton];
    }
}

#pragma mark - 获取银行卡列表
//  获取银行卡列表
- (void)bankCardList{
    BankCardListApi *bankCardApi = [[BankCardListApi alloc] init];
    if (kArrayIsEmpty(self.bankCardArray)) {
//        [SVProgressHUD showLoading];
    }
    [SVProgressHUD dismiss];
    [bankCardApi requestWithSuccess:^(NSDictionary *responseDict) {
        NSLog(@"%@", responseDict);
//        [SVProgressHUD dismiss];
        NSString *codeStr = [responseDict[@"code"] description];
        if ([codeStr isEqualToString:@"1000"]) {
            NSDictionary *dataDict = responseDict[@"data"];
            self.bankCardListModel = [BankCardListModel mj_objectWithKeyValues:dataDict];
            
            if (!kArrayIsEmpty(self.bankCardArray)) {
                [self.bankCardArray removeAllObjects];
            }
            
            if (self.bankCardListModel.bankCardList.count > 0) {
                [self.bankCardArray addObjectsFromArray:self.bankCardListModel.bankCardList];
            }
            [self.tableView reloadData];
        }
    } failure:^(__kindof YTKBaseRequest *request) {
//        [SVProgressHUD dismiss];
    }];
}

//  设置选中的银行卡
- (void)setSelectBankCardId:(NSString *)selectBankCardId{
    if (_selectBankCardId != selectBankCardId) {
        _selectBankCardId = selectBankCardId;
    }
    
    [self.tableView reloadData];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

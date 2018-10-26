//
//  LSFeedbackViewController.m
//  ZTMXFXunMiaoiOS
//
//  Created by 朱吉达 on 2018/1/29.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "LSFeedbackViewController.h"
#import "UITextView+PlaceHolder.h"
#import "TZImagePickerController.h"
#import "UploadSingleImageService.h"
#import "NSString+Trims.h"
#import "ImageCompressHelper.h"
#import "ImageItemView.h"


#import "FeedbackApi.h"
@interface LSFeedbackViewController ()<UITextViewDelegate,ImageItemViewDelegate,TZImagePickerControllerDelegate>
@property (nonatomic,strong) UIScrollView * scrollView;
@property (nonatomic,strong) UILabel * lbTitleLb;
@property (nonatomic,strong) UIView * viTextView;
@property (nonatomic,strong) UITextView * textView;
@property (nonatomic,strong) UILabel * lbPromptTitleLb;
@property (nonatomic,strong) XLButton * btnSubmitBtn;
@property (nonatomic,strong) NSMutableArray * arrBtnPhotoArr;
@property (nonatomic,strong) NSMutableArray * arrPhotoImgArr;
//原图地址
@property (nonatomic,strong) NSMutableArray * selectedAssets;

//可以选择相册的 角标
@property (nonatomic,assign) NSInteger choosePhotoIndex;
@property (nonatomic,copy  ) NSString * imgsUrl;

@end

@implementation LSFeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.title = @"意见反馈";
    
    [self addSubviewUI];
}

#pragma mark ------ Action
-(void)btnSubmitBtnClick:(UIButton *)btnSubmit{
    btnSubmit.userInteractionEnabled = NO;
    if ([self judgeSubmitBtnEnabledState]) {
//        提交意见反馈
        [self requestSubmitFeedback];
    }
    
    btnSubmit.userInteractionEnabled = YES;
}



#pragma mark --
-(void)requestSubmitFeedback{
    [SVProgressHUD showLoading];
    if (_arrPhotoImgArr.count>0) {
        [self uploadFeedbackImages];
    }else{
        [self requsetSubmitFeedbackMessage];
    }
}
-(void)uploadFeedbackImages{
    NSMutableArray * arrImgData = [[NSMutableArray alloc]init];
    for (int i =0; i<_arrPhotoImgArr.count; i++) {
        NSData *imgData = [ImageCompressHelper returnDataCompressedImageToLimitSizeOfKB:200 image:_arrPhotoImgArr[i]];
        [arrImgData addObject:imgData];
    }
    UploadSingleImageService * uploadApi = [[UploadSingleImageService alloc]initWithImageDatas:arrImgData andUploadType:UploadSingleTypeFile andFileName:nil];
    [uploadApi requestWithSuccess:^(NSDictionary *responseDict) {
        NSString * codeStr = [responseDict[@"code"]description];
        if ([codeStr isEqualToString:@"1000"]) {
            NSDictionary * dicData = responseDict[@"data"];
            _imgsUrl = @"";
            NSArray * arrList = dicData[@"list"];
            for (int i = 0; i < [arrList count]; i++) {
                NSString * urlStr = arrList[i][@"url"];
                NSString * commaStr = i == 0 ? @"" : @",";
                _imgsUrl = [NSString stringWithFormat:@"%@%@%@",_imgsUrl,commaStr,urlStr];
            }
            [self requsetSubmitFeedbackMessage];
        }
    } failure:^(__kindof YTKBaseRequest *request) {
        [SVProgressHUD dismiss];
    }];
}
-(void)requsetSubmitFeedbackMessage{
    NSString * messageStr = [_textView.text trimmingWhitespaceAndNewlines];
    NSData *data = [messageStr dataUsingEncoding:NSUTF8StringEncoding];
    NSData *base64Data = [data base64EncodedDataWithOptions:0];
    NSString *baseString = [[NSString alloc]initWithData:base64Data encoding:NSUTF8StringEncoding];
    
    FeedbackApi * feedbackApi = [[FeedbackApi alloc]initWithOpinionMsg:baseString imagesUrl:_imgsUrl];
    [feedbackApi requestWithSuccess:^(NSDictionary *responseDict) {
        NSString * codeStr = [responseDict[@"code"]description];
        [SVProgressHUD dismiss];
        if ([codeStr isEqualToString:@"1000"]) {
            [kKeyWindow makeCenterToast:@"提交成功，感谢您的反馈"];
            [self.navigationController popViewControllerAnimated:YES];
        }
    } failure:^(__kindof YTKBaseRequest *request) {
        [SVProgressHUD dismiss];
    }];
}
#pragma mark --------
//图片排列
-(void)updateUploadImgUI{
  
    for (int i =0; i<_arrPhotoImgArr.count; i++) {
        UIImage * imgPhoto = _arrPhotoImgArr[i];
        if (i<_arrBtnPhotoArr.count) {
            ImageItemView * itemView = _arrBtnPhotoArr[i];
            [itemView changeStateWithIsSelect:YES imageSelect:imgPhoto];
            itemView.hidden = NO;
        }
    }
//    重新获得可以选择图片的角标
    NSInteger indexImg = _arrPhotoImgArr.count-1;
    _choosePhotoIndex = indexImg+1;
    if (_choosePhotoIndex<_arrBtnPhotoArr.count) {
        ImageItemView * itemViewAdd = _arrBtnPhotoArr[_choosePhotoIndex];
        [itemViewAdd changeStateWithIsSelect:NO imageSelect:nil];
        itemViewAdd.hidden = NO;
        
        for (NSInteger i = _choosePhotoIndex+1; i<_arrBtnPhotoArr.count; i++) {
            ImageItemView * itemViewDelete = _arrBtnPhotoArr[i];
            [itemViewDelete changeStateWithIsSelect:NO imageSelect:nil];
            itemViewDelete.hidden = YES;
        }
    }
}
// 反馈意见 是否可提交
-(BOOL)judgeSubmitBtnEnabledState{
    NSString * feedbackStr = [_textView.text trimmingWhitespace];
    feedbackStr = [feedbackStr stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    feedbackStr = [feedbackStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    if (feedbackStr.length<=0) {
        [kKeyWindow makeCenterToast:@"请输入你的问题"];
        return NO;
    }else if (feedbackStr.length<10&&feedbackStr.length>0) {
        [kKeyWindow makeCenterToast:@"反馈内容不能少于10个字"];
//        不能提交
        return NO;
    }else if (feedbackStr.length>200){
        [kKeyWindow makeCenterToast:@"反馈内容不能超过200个字"];
        return NO;
    }
    else{
        return YES;
    }
}
#pragma mark - TZImagePickerController

- (void)pushTZImagePickerController {
    NSInteger maxImgCount = 3-_arrPhotoImgArr.count;
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:maxImgCount delegate:self];
//    imagePickerVc.takePictureImageName = @"照片";
    //  是否选择原图
    imagePickerVc.allowPickingOriginalPhoto = NO;
    // 在内部显示拍照按钮Photos
    imagePickerVc.allowTakePicture = NO;
//    不可选gif
    imagePickerVc.allowPickingGif = NO;
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}
#pragma  mark ----- ImageItemViewDelegate

-(void)didSelectImageItemView:(ImageItemView *)itemView{
    if (itemView.tag==_choosePhotoIndex) {
        //        选择相册
        [self pushTZImagePickerController];
    }else{
       
    }
}
-(void)removeImageItemView:(ImageItemView *)itemView{
    //        删除要上传图片
    [_arrPhotoImgArr removeObjectAtIndex:itemView.tag];
    [self updateUploadImgUI];
}
#pragma mark - TZImagePickerControllerDelegate
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto{
    [self.arrPhotoImgArr addObjectsFromArray:photos];
    [self updateUploadImgUI];
//    self.selectedAssets = [NSMutableArray arrayWithArray:assets];
//
//    if (self.selectedPhotos.count > 0) {
//
//        [self.mainScrollView addSubview:self.uploadSuccessView];
//        self.uploadImageView.image = self.selectedPhotos[0];
//
//        //        [self.goRepaymentButton setTitle:@"提 交" forState:UIControlStateNormal];
//        //        [self.grayUploadButton setTitle:@"重新上传" forState:UIControlStateNormal];
//    }
}
#pragma mark ------
//-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
//    NSString * feedbackStr = [textView.text trimmingWhitespaceAndNewlines];
//    if (feedbackStr.length>200) {
//        return <#expression#>
//    }
//    return YES;
//}
#pragma mark ---- AddUI
-(void)addSubviewUI{
    [self.view addSubview:self.scrollView];
    [_scrollView addSubview:self.lbTitleLb];
    [_scrollView addSubview:self.viTextView];
    [_viTextView addSubview:self.textView];
    [_scrollView addSubview:self.lbPromptTitleLb];
    [_scrollView addSubview:self.btnSubmitBtn];
    _choosePhotoIndex = 0;
    
    [_scrollView setFrame:CGRectMake(0,k_Navigation_Bar_Height, Main_Screen_Width, Main_Screen_Height-k_Navigation_Bar_Height)];
    [_lbTitleLb setFrame:CGRectMake(AdaptedWidth(12), AdaptedWidth(15), Main_Screen_Width-AdaptedWidth(24), AdaptedWidth(22))];
    CGRect rect = CGRectMake(_lbTitleLb.left, _lbTitleLb.bottom+AdaptedWidth(10),Main_Screen_Width- AdaptedWidth(24), AdaptedWidth(160));
    [_viTextView setFrame:rect];
    
    _textView.frame = CGRectMake(AdaptedWidth(10), AdaptedWidth(5),_viTextView.width- AdaptedWidth(20), AdaptedWidth(150));
    [_lbPromptTitleLb setFrame:CGRectMake(_lbTitleLb.left, _viTextView.bottom+AdaptedWidth(20), _viTextView.width, AdaptedWidth(22))];
    
    _btnSubmitBtn.width = KW - 40;
    _btnSubmitBtn.height = AdaptedWidth(44);
    _btnSubmitBtn.centerX = Main_Screen_Width/2.;

    [self.arrBtnPhotoArr removeAllObjects];
    [self.arrPhotoImgArr removeAllObjects];
    for (int i =0; i<3; i++) {
        ImageItemView * btnPhoto = [[ImageItemView alloc]init];;
        btnPhoto.tag = i;
        [btnPhoto setFrame:CGRectMake(_lbTitleLb.left+i*AdaptedWidth(96), _lbPromptTitleLb.bottom+AdaptedWidth(10), AdaptedWidth(72), AdaptedWidth(72))];
        btnPhoto.delegate= self;
        btnPhoto.hidden = i==0?NO:YES;
        [_scrollView addSubview:btnPhoto];
        [_arrBtnPhotoArr  addObject:btnPhoto];
        _btnSubmitBtn.top = btnPhoto.bottom + AdaptedWidth(40);
    }
    _scrollView.contentSize = CGSizeMake(0, _btnSubmitBtn.bottom+20);
    
    _lbTitleLb.text = @"简单描述你的反馈";
    [_textView addPlaceHolder:@"不少于10个字，不超过200字"];
    _lbPromptTitleLb.text = @"上传图片能帮助我们更好的定位问题";
    
}
#pragma mark ---- Get
-(UIScrollView * )scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]init];
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
    }
    return _scrollView;
}
-(UILabel * )lbTitleLb{
    if (!_lbTitleLb) {
        _lbTitleLb = [[UILabel alloc]init];
        _lbTitleLb.font = [UIFont systemFontOfSize:AdaptedWidth(16)];
        _lbTitleLb.textColor = [UIColor colorWithHexString:COLOR_BLACK_STR];
    }
    return _lbTitleLb;
}
-(UIView *)viTextView{
    if (!_viTextView) {
        _viTextView = [[UIView alloc]init];
        [_viTextView.layer setBorderWidth:1];
        [_viTextView.layer setCornerRadius:2];
        [_viTextView.layer setBorderColor:[UIColor colorWithHexString:COLOR_BORDER_STR].CGColor];
        [_viTextView setBackgroundColor:[UIColor clearColor]];
    }
    return _viTextView;
}
-(UITextView *)textView{
    if (!_textView) {
        CGRect rect = CGRectMake(AdaptedWidth(12), AdaptedWidth(33),Main_Screen_Width- AdaptedWidth(24), AdaptedWidth(250));
        _textView = [[UITextView alloc]initWithFrame:rect textContainer:NSTextAlignmentLeft];
        _textView.textColor = [UIColor colorWithHexString:COLOR_BLACK_STR];
        _textView.delegate = self;
        _textView.showsVerticalScrollIndicator = NO;
        _textView.showsHorizontalScrollIndicator = NO;
        _textView.font = [UIFont systemFontOfSize:AdaptedWidth(15)];
     
//        _textView.contentInset = UIEdgeInsetsMake(10, 10, 10, 10);
        
    }
    return _textView;
}
-(UILabel *)lbPromptTitleLb{
    if (!_lbPromptTitleLb) {
        _lbPromptTitleLb = [[UILabel alloc]init];
        _lbPromptTitleLb.font = [UIFont systemFontOfSize:AdaptedWidth(16)];
        _lbPromptTitleLb.textColor = [UIColor colorWithHexString:COLOR_GRAY_STR];
        
    }
    return _lbPromptTitleLb;
}
-(NSMutableArray *)arrBtnPhotoArr{
    if (!_arrBtnPhotoArr) {
        _arrBtnPhotoArr = [[NSMutableArray alloc]init];
    }
    return _arrBtnPhotoArr;
}
-(NSMutableArray * )arrPhotoImgArr{
    if (!_arrPhotoImgArr) {
        _arrPhotoImgArr = [[NSMutableArray alloc]init];
    }
    return _arrPhotoImgArr;
}
-(UIButton *)btnSubmitBtn{
    if (!_btnSubmitBtn) {
        _btnSubmitBtn = [XLButton buttonWithType:UIButtonTypeCustom];
        [_btnSubmitBtn setTitle:@"提交" forState:UIControlStateNormal];
        [_btnSubmitBtn addTarget:self action:@selector(btnSubmitBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnSubmitBtn;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

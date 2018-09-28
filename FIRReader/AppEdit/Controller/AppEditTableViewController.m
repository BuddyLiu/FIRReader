//
//  AppEditTableViewController.m
//  FIRReader
//
//  Created by Paul on 2018/9/28.
//  Copyright © 2018年 Liu Bo. All rights reserved.
//

#import "AppEditTableViewController.h"

@interface AppEditTableViewController ()

@property (strong, nonatomic) IBOutlet UIImageView *e_iconImageView;
@property (strong, nonatomic) IBOutlet UITextField *e_nameTextField;
@property (strong, nonatomic) IBOutlet UILabel *e_subTitleLabel;
@property (strong, nonatomic) IBOutlet UITextView *e_detailTextView;
@property (strong, nonatomic) IBOutlet UITextField *e_shortUrlTextField;

@property (nonatomic, strong) AppDetailModel *detailModel;

@end

@implementation AppEditTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self hideViews];
}

- (IBAction)backBtnAction:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)e_saveBtnAction:(UIButton *)sender
{
    sender.backgroundColor = ItemColorFromRGB(0x666666);
    sender.userInteractionEnabled = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        sender.backgroundColor = MainColor;
        sender.userInteractionEnabled = YES;
    });
    if([_e_nameTextField.text isEqual:_detailModel.name] &&
       [_e_detailTextView.text isEqual:_detailModel.desc] &&
       [_e_shortUrlTextField.text isEqual:_detailModel.shortStr])
    {
        [SVProgressHUD showErrorWithStatus:@"信息未修改，无须提交！"];
    }
    else
    {
        WEAKSELF
        [[RequestMannager sharedInstance] changeAppInfoRequestWithAppId:_detailModel.appId
                                                                   name:_e_nameTextField.text
                                                                   desc:_e_detailTextView.text
                                                               shortStr:_e_shortUrlTextField.text
                                                        completionBlock:^(id responseObject) {
                                                            [weakSelf dismissViewControllerAnimated:YES completion:^{
                                                                [SVProgressHUD showSuccessWithStatus:@"修改成功！"];
                                                            }];
                                                        } failBlock:^(NSError *error) {
                                                            [SVProgressHUD showErrorWithStatus:error.localizedDescription];
                                                        }];
    }
}

-(void)setDetailModel:(AppDetailModel *)detailModel
{
    _detailModel = detailModel;
    if(_detailModel)
    {
        [self showViews];
        [_e_iconImageView sd_setImageWithURL:[NSURL URLWithString:_detailModel.icon_url]];
        _e_detailTextView.text = _detailModel.desc?_detailModel.desc:@"";
        _e_nameTextField.text = _detailModel.name?_detailModel.name:@"";
        _e_subTitleLabel.text = _detailModel.bundle_id?[NSString stringWithFormat:@"%@  %@\n%@",
                                                        _detailModel.bundle_id,
                                                        [[GeneralTool sharedInstance] convertToTimeFormat:@"yyyy/MM/dd HH:mm:ss"
                                                                                                 interval:_detailModel.created_at],
                                                        _detailModel.desc]:@"";
        _e_shortUrlTextField.text = _detailModel.shortStr?_detailModel.shortStr:@"";
    }
}

-(void)hideViews
{
    _e_iconImageView.alpha = 0;
    _e_detailTextView.alpha = 0;
    _e_nameTextField.alpha = 0;
    _e_subTitleLabel.alpha = 0;
    _e_shortUrlTextField.alpha = 0;
}

-(void)showViews
{
    WEAKSELF
    [UIView animateWithDuration:0.5 animations:^{
        weakSelf.e_iconImageView.alpha = 1;
        weakSelf.e_detailTextView.alpha = 1;
        weakSelf.e_nameTextField.alpha = 1;
        weakSelf.e_subTitleLabel.alpha = 1;
        weakSelf.e_shortUrlTextField.alpha = 1;
    }];
}

@end

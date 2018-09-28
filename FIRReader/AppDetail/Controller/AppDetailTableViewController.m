//
//  AppDetailTableViewController.m
//  FIRReader
//
//  Created by Paul on 2018/9/27.
//  Copyright © 2018年 Liu Bo. All rights reserved.
//

#import "AppDetailTableViewController.h"
#import "AppDetailModel.h"
#import "AppDetailView.h"
#import "AppEditTableViewController.h"

@interface AppDetailTableViewController ()

@property (nonatomic, copy) NSString *appId;
@property (nonatomic, strong) AppDetailModel *detailModel;

@end

static float detailNav_height = 60;
static float detailFooter_height = 60;

@implementation AppDetailTableViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self requestData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.bounces = NO;
}

-(void)createAppId:(NSString *)appId
{
    _appId = appId;
    [self requestData];
}

-(void)requestData
{
    if((!self.appId) || (self.appId.length == 0))
    {
        return;
    }
    else
    {
        [SVProgressHUD show];
        WEAKSELF
        [[RequestMannager sharedInstance] getAppDetailRequestWithAppId:self.appId
                                                       completionBlock:^(id responseObject) {
                                                           weakSelf.detailModel = [[AppDetailModel alloc] initWithDictionary:responseObject error:nil];
                                                           if(weakSelf.detailModel)
                                                           {
                                                               [weakSelf.tableView reloadData];
                                                           }
                                                           [SVProgressHUD dismiss];
                                                       } failBlock:^(NSError *error) {
                                                           
                                                       }];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0)
    {
        return 240;
    }
    else
    {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0)
    {
        AppDetailTableViewCell_F *cell = [tableView dequeueReusableCellWithIdentifier:@"AppDetailCell_F" forIndexPath:indexPath];
        [cell.f_downloadBtn setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.detailModel.icon_url]]] forState:(UIControlStateNormal)];
        [cell.f_downloadBtn addTarget:self action:@selector(f_downloadBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
        cell.f_titleLabel.text = self.detailModel.name?self.detailModel.name:@"";
        cell.f_detailLabel.text = self.detailModel.bundle_id?[NSString stringWithFormat:@"%@\n%@\n%@\n%@",
                                                               self.detailModel.type,
                                                               self.detailModel.bundle_id,
                                                               [[GeneralTool sharedInstance] convertToTimeFormat:@"yyyy/MM/dd HH:mm:ss"
                                                                                                        interval:self.detailModel.created_at],
                                                              self.detailModel.desc]:@"";
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else
    {
        AppDetailTableViewCell_H *cell = [tableView dequeueReusableCellWithIdentifier:@"AppDetailCell_H" forIndexPath:indexPath];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return detailNav_height;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    AppDetailView *headerView = [[AppDetailView alloc] initWithHDFrame:CGRectMake(0, 0, ScreenWidth, detailNav_height)];
    headerView.hd_titleLabel.text = @"应用详情";
    [headerView.hd_backBtn addTarget:self action:@selector(hd_backBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [headerView.hd_editBtn addTarget:self action:@selector(hd_editBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    return headerView;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)f_downloadBtnAction:(UIButton *)sender
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示信息" message:[NSString stringWithFormat:@"即将跳转Safari，并打开https://fir.im/%@，是否马上打开？", self.detailModel.shortStr] preferredStyle:(UIAlertControllerStyleAlert)];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    WEAKSELF
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://fir.im/%@", weakSelf.detailModel.shortStr]];
        if([[UIApplication sharedApplication] canOpenURL:url])
        {
            [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
        }
        else
        {
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"打开失败，服务器开小差了!"]];
        }
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return detailFooter_height;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    AppDetailView *footerView = [[AppDetailView alloc] initWithHFFrame:CGRectMake(0, 0, ScreenWidth, detailNav_height)];
    [footerView.hf_installBtn addTarget:self action:@selector(hf_installBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    return footerView;
}

-(void)hf_installBtnAction:(UIButton *)sender
{
    if([sender.currentTitle isEqual:@"直接安装"] || [sender.currentTitle isEqual:@"重新安装"])
    {
        WEAKSELF
        [[RequestMannager sharedInstance] getAppInstallTokenRequestWithAppId:self.detailModel.appId completionBlock:^(id responseObject) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示信息" message:[NSString stringWithFormat:@"即将安装%@，是否马上安装？", self.detailModel.name] preferredStyle:(UIAlertControllerStyleAlert)];
            [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
                
            }]];
            [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                NSDictionary *dic = [NSDictionary dictionaryWithDictionary:responseObject];
                NSString *download_token = dic[@"download_token"];
                if(download_token && download_token.length > 0)
                {
                    NSString *downloadURL = [[NSString stringWithFormat:@"https://download.fir.im/apps/%@/install?download_token=%@", weakSelf.detailModel.appId, download_token] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                    NSString *unencodedString = downloadURL;
                    NSString *encodedString = (NSString *)
                    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                              (CFStringRef)unencodedString,
                                                                              NULL,
                                                                              (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                              kCFStringEncodingUTF8));
                    
                    
                    
                    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"itms-services://?action=download-manifest&url=%@", encodedString]];
                    if([[UIApplication sharedApplication] canOpenURL:url])
                    {
                        [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
                    }
                    else
                    {
                        [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"打开失败，服务器开小差了!"]];
                    }
                }
                else
                {
                    [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"打开失败，服务器开小差了!"]];
                }
            }]];
            [weakSelf presentViewController:alertController animated:YES completion:nil];
        } failBlock:^(NSError *error) {
            [SVProgressHUD showErrorWithStatus:error.localizedDescription];
        }];
        sender.userInteractionEnabled = NO;
        [sender setBackgroundColor:ItemColorFromRGB(0x666666)];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [sender setTitle:@"重新安装" forState:(UIControlStateNormal)];
            sender.userInteractionEnabled = YES;
            [sender setBackgroundColor:MainColor];
        });
    }
    else
    {
        [sender setTitle:@"直接安装" forState:(UIControlStateNormal)];
        sender.userInteractionEnabled = YES;
        [sender setBackgroundColor:MainColor];
    }
}

-(void)hd_backBtnAction:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)hd_editBtnAction:(UIButton *)sender
{
    AppEditTableViewController *editTableViewController = MainStoryBoard(@"AppEditTableViewController");
    [self presentViewController:editTableViewController animated:YES completion:^{
        [editTableViewController setDetailModel:self.detailModel];
    }];
}

@end

@implementation AppDetailTableViewCell_F

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end

@implementation AppDetailTableViewCell_H

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end

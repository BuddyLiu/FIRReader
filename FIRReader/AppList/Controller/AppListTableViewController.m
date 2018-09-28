//
//  AppListTableViewController.m
//  FIRReader
//
//  Created by Paul on 2018/9/27.
//  Copyright © 2018年 Liu Bo. All rights reserved.
//

#import "AppListTableViewController.h"
#import "AppListModel.h"
#import "AppListView.h"
#import "AppDetailTableViewController.h"

static float listHeader_height = 60;

@interface AppListTableViewController ()

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) AppListModel *appListModel;

@end

@implementation AppListTableViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self requestData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.separatorColor = MainColor;
    self.tableView.sectionHeaderHeight = listHeader_height;
    self.tableView.bounces = NO;
}

-(void)requestData
{
    WEAKSELF
    [SVProgressHUD show];
    [[RequestMannager sharedInstance] getAppListRequestWithCompletionBlock:^(id responseObject) {
        
        [weakSelf.dataArray removeAllObjects];
        
        weakSelf.appListModel = [[AppListModel alloc] initWithDictionary:responseObject error:nil];
        [weakSelf.dataArray addObjectsFromArray:weakSelf.appListModel.items];
        
        [weakSelf.tableView reloadData];
        [SVProgressHUD dismiss];
        
    } failBlock:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:error.localizedDescription];
        
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AppListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ApplistCell" forIndexPath:indexPath];
    if(indexPath.row < self.dataArray.count)
    {
        AppListModel_Items *model = self.dataArray[indexPath.row];
        cell.l_titleLabel.text = [NSString stringWithFormat:@"%@  V%@", model.name, model.master_release.version];
        NSString *subTitle = @"";
        if(model.master_release.distribution_name && model.master_release.distribution_name.length > 0)
        {
            subTitle = [NSString stringWithFormat:@"%@    %@\n%@", model.bundle_id, [[GeneralTool sharedInstance] convertToTimeFormat:@"yyyy-MM-dd HH:mm:ss" interval:model.created_at], model.master_release.distribution_name];
        }
        else
        {
            subTitle = [NSString stringWithFormat:@"%@    %@", model.bundle_id, [[GeneralTool sharedInstance] convertToTimeFormat:@"yyyy-MM-dd HH:mm:ss" interval:model.created_at]];
        }
        cell.l_subTitleLabel.text = subTitle;
        cell.l_detailBtn.tag = 786 + indexPath.row;
        [cell.l_detailBtn addTarget:self action:@selector(l_detailBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    WEAKSELF
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if(indexPath.row < weakSelf.dataArray.count)
        {
            AppListModel_Items *model = weakSelf.dataArray[indexPath.row];
            [((AppListTableViewCell *)cell).l_iconImageView sd_setImageWithURL:[NSURL URLWithString:model.icon_url]];
        }
    });
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AppDetailTableViewController *detailTableViewController = MainStoryBoard(@"AppDetailTableViewController");
    AppListModel_Items *model = self.dataArray[indexPath.row];
    [detailTableViewController createAppId:model.appId];
    [self presentViewController:detailTableViewController animated:YES completion:nil];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return listHeader_height;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    AppListView *headerView = [[AppListView alloc] initWithHFrame:CGRectMake(0, 0, ScreenWidth, listHeader_height)];
    headerView.h_titleLabel.text = @"应用列表";
    [headerView.h_backBtn addTarget:self action:@selector(h_backBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    return headerView;
}

-(void)l_detailBtnAction:(UIButton *)sender
{
    NSInteger index = sender.tag - 786;
    AppListModel_Items *model = self.dataArray[index];
    WEAKSELF
    [[RequestMannager sharedInstance] getAppInstallTokenRequestWithAppId:model.appId completionBlock:^(id responseObject) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示信息" message:[NSString stringWithFormat:@"即将安装%@，是否马上安装？", model.name] preferredStyle:(UIAlertControllerStyleAlert)];
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            NSDictionary *dic = [NSDictionary dictionaryWithDictionary:responseObject];
            NSString *download_token = dic[@"download_token"];
            if(download_token && download_token.length > 0)
            {
                NSString *downloadURL = [[NSString stringWithFormat:@"https://download.fir.im/apps/%@/install?download_token=%@", model.appId, download_token] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
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
}

-(void)h_backBtnAction:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(NSMutableArray *)dataArray
{
    if(!_dataArray)
    {
        _dataArray = [NSMutableArray new];
    }
    return _dataArray;
}

@end

@implementation AppListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end

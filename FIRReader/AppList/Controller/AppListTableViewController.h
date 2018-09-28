//
//  AppListTableViewController.h
//  FIRReader
//
//  Created by Paul on 2018/9/27.
//  Copyright © 2018年 Liu Bo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppListTableViewController : UITableViewController

@end

@interface AppListTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *l_iconImageView;
@property (strong, nonatomic) IBOutlet UILabel *l_titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *l_subTitleLabel;
@property (strong, nonatomic) IBOutlet UIButton *l_detailBtn;

@end

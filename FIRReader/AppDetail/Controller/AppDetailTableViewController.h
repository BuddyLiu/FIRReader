//
//  AppDetailTableViewController.h
//  FIRReader
//
//  Created by Paul on 2018/9/27.
//  Copyright © 2018年 Liu Bo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDetailTableViewController : UITableViewController

-(void)createAppId:(NSString *)appId;

@end

@interface AppDetailTableViewCell_F : UITableViewCell

@property (strong, nonatomic) IBOutlet UIButton *f_downloadBtn;
@property (strong, nonatomic) IBOutlet UILabel *f_titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *f_detailLabel;

@end

@interface AppDetailTableViewCell_H : UITableViewCell

@property (strong, nonatomic) IBOutlet UIButton *h_downloadBtn;
@property (strong, nonatomic) IBOutlet UILabel *h_titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *h_detailLabel;

@end

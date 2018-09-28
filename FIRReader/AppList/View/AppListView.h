//
//  AppListView.h
//  FIRReader
//
//  Created by Paul on 2018/9/27.
//  Copyright © 2018年 Liu Bo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppListView : UIView

@property (strong, nonatomic) IBOutlet UIButton *h_backBtn;
@property (strong, nonatomic) IBOutlet UILabel *h_titleLabel;

- (instancetype)initWithHFrame:(CGRect)frame;

@end

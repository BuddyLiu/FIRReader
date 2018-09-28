//
//  GeneralView.h
//  IntegralWall
//
//  Created by Paul on 2018/8/2.
//  Copyright © 2018 QingHu. All rights reserved.
//

/**
 * 通用的视图样式
 **/

#import <UIKit/UIKit.h>

@interface GeneralView : UIView

@property (strong, nonatomic) IBOutlet UIView *sm_backView;
@property (strong, nonatomic) IBOutlet UIView *sm_sepLineView;
@property (strong, nonatomic) IBOutlet UIButton *sm_sureBtn;
@property (strong, nonatomic) IBOutlet UIScrollView *sm_scrollView;
@property (strong, nonatomic) IBOutlet UILabel *sm_titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *sm_messageLabel;

- (instancetype)initWithSMFrame:(CGRect)frame;

@end

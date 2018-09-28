//
//  OpenShowMainView.h
//  QHWallet
//
//  Created by Paul on 2018/9/10.
//  Copyright © 2018年 QingHu. All rights reserved.
//

/**
 * 自定义的弹窗框视图样式，使用OpenShowView承载该视图
 **/

#import <UIKit/UIKit.h>

@interface OpenShowMainView : UIView

@property (strong, nonatomic) IBOutlet UIImageView *openhIconImageView;
@property (strong, nonatomic) IBOutlet UIButton *openhBtn;

@property (strong, nonatomic) IBOutlet UILabel *openr_titleLabel;
@property (strong, nonatomic) IBOutlet UIButton *openr_backBtn;
@property (strong, nonatomic) IBOutlet UIImageView *openr__iconImageView;
@property (strong, nonatomic) IBOutlet UILabel *openr_subTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *openr_moneyLabel;
@property (strong, nonatomic) IBOutlet UIButton *openr_seeDetailBtn;

@property (strong, nonatomic) IBOutlet UIImageView *opens_iconImageView;
@property (strong, nonatomic) IBOutlet UILabel *opens_titleLabel;

@property (strong, nonatomic) IBOutlet UILabel *bef_nameLabel;
@property (strong, nonatomic) IBOutlet UIButton *bef_openBtn;


- (instancetype)initWithhFrame:(CGRect)frame;
- (instancetype)initWithrFrame:(CGRect)frame;
- (instancetype)initWithsFrame:(CGRect)frame;
- (instancetype)initWithBefFrame:(CGRect)frame;

@end

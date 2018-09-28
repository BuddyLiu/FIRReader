//
//  AppDetailView.h
//  FIRReader
//
//  Created by Paul on 2018/9/27.
//  Copyright © 2018年 Liu Bo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDetailView : UIView

@property (strong, nonatomic) IBOutlet UIButton *hd_backBtn;
@property (strong, nonatomic) IBOutlet UIButton *hd_editBtn;
@property (strong, nonatomic) IBOutlet UILabel *hd_titleLabel;

@property (strong, nonatomic) IBOutlet UIButton *hf_installBtn;

-(instancetype)initWithHDFrame:(CGRect)frame;
-(instancetype)initWithHFFrame:(CGRect)frame;

@end

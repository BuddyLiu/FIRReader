//
//  HomeViewController.m
//  FIRReader
//
//  Created by Paul on 2018/9/27.
//  Copyright © 2018年 Liu Bo. All rights reserved.
//

#import "HomeViewController.h"
#import "AppListTableViewController.h"

@interface HomeViewController ()<UIGestureRecognizerDelegate>

@property (strong, nonatomic) IBOutlet UILabel *versionLabel;
@property (strong, nonatomic) IBOutlet UITextField *infoTextField;
@property (strong, nonatomic) IBOutlet UIImageView *h_iconImageView;
@property (strong, nonatomic) IBOutlet UIButton *startBtn;
@property (strong, nonatomic) IBOutlet UIImageView *startBtnBorderImageView;
@property (strong, nonatomic) IBOutlet UIImageView *startBtnSideBorderImageView;

@end

@implementation HomeViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.versionLabel.text = [NSString stringWithFormat:@"V %@\n%@", AppVersion, @"@CopyRight LiuBo(Paul) 2018"];
    self.infoTextField.text = [USERDEFAULTS objectForKey:@"FirAppTokenStr"];
    self.infoTextField.alpha = 0;
    self.startBtnBorderImageView.layer.cornerRadius = 182.0/2.0;
    [self addRotationToView:self.startBtnBorderImageView isNorDir:YES time:3];
    self.startBtnSideBorderImageView.layer.cornerRadius = 184.0/2.0;
    [self addRotationToView:self.startBtnSideBorderImageView isNorDir:NO time:5];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(resetInfo:)];
    longPress.delegate = self;
    self.h_iconImageView.userInteractionEnabled = YES;
    [self.h_iconImageView addGestureRecognizer:longPress];
}

-(void)addRotationToView:(UIView *)view isNorDir:(BOOL)isNorSir time:(CGFloat)time
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    
    //默认是顺时针效果，若将fromValue和toValue的值互换，则为逆时针效果
    if(isNorSir)
    {
        animation.fromValue = [NSNumber numberWithFloat:0.f];
        animation.toValue = [NSNumber numberWithFloat: M_PI *2];
    }
    else
    {
        animation.fromValue = [NSNumber numberWithFloat: M_PI *2];
        animation.toValue = [NSNumber numberWithFloat:0.f];
    }
    animation.duration = time;
    animation.autoreverses = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.repeatCount = MAXFLOAT; //如果这里想设置成一直自旋转，可以设置为MAXFLOAT，否则设置具体的数值则代表执行多少次
    [view.layer addAnimation:animation forKey:nil];
}

- (IBAction)setInfoAction:(UIButton *)sender
{
    if(sender.tag == 90)
    {
        sender.tag = 91;
        self.infoTextField.text = [USERDEFAULTS objectForKey:@"FirAppTokenStr"];
        WEAKSELF
        [UIView animateWithDuration:0.5 animations:^{
            weakSelf.infoTextField.alpha = 1;
        }];
    }
    else
    {
        sender.tag = 90;
        WEAKSELF
        [UIView animateWithDuration:0.5 animations:^{
            weakSelf.infoTextField.alpha = 0;
        }];
        [USERDEFAULTS setObject:self.infoTextField.text forKey:@"FirAppTokenStr"];
    }
}

- (void)resetInfo:(UILongPressGestureRecognizer *)press
{
    [USERDEFAULTS setObject:FirAppToken forKey:@"FirAppTokenStr"];
    self.infoTextField.text = [USERDEFAULTS objectForKey:@"FirAppTokenStr"];
}

- (IBAction)startBtnAction:(UIButton *)sender
{
    AppListTableViewController *listViewController = MainStoryBoard(@"AppListTableViewController");
    [self presentViewController:listViewController animated:YES completion:nil];
}

@end

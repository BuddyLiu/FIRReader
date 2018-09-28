//
//  ShowMessageView.m
//  IntegralWall
//
//  Created by Paul on 2018/8/2.
//  Copyright © 2018 QingHu. All rights reserved.
//

#import "ShowMessageView.h"

@interface ShowMessageView()<UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIWindow *window;
@property (nonatomic, strong) UIButton *closeBtn;
@property (nonatomic, strong) UIView *blackView;
@property (nonatomic, copy) NSString *titleStr;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, strong) GeneralView *generalView;

@end

static BOOL isVisible = NO;

@implementation ShowMessageView

- (instancetype)initShowMessageViewWithMessage:(NSString *)message
{
    self = [super init];
    if (self)
    {
        self.window = [UIApplication sharedApplication].delegate.window;
        self.window.windowLevel = UIWindowLevelNormal;
        self.message = message;
    }
    return self;
}

- (instancetype)initShowMessageViewWithMessage:(NSString *)message delegate:(ShowMessageViewBlock)delegate
{
    self = [super init];
    if (self)
    {
        self.window = [UIApplication sharedApplication].delegate.window;
        self.window.windowLevel = UIWindowLevelNormal;
        self.message = message;
        self.delegate = delegate;
    }
    return self;
}

- (instancetype)initShowMessageViewWithMessage:(NSString *)message titleStr:(NSString *)titleStr
{
    self = [super init];
    if (self)
    {
        self.window = [UIApplication sharedApplication].delegate.window;
        self.window.windowLevel = UIWindowLevelNormal;
        self.titleStr = titleStr;
        self.message = message;
    }
    return self;
}

- (instancetype)initShowMessageViewWithMessage:(NSString *)message titleStr:(NSString *)titleStr delegate:(ShowMessageViewBlock)delegate
{
    self = [super init];
    if (self)
    {
        self.window = [UIApplication sharedApplication].delegate.window;
        self.window.windowLevel = UIWindowLevelNormal;
        self.titleStr = titleStr;
        self.message = message;
        self.delegate = delegate;
    }
    return self;
}

-(void)show
{
    if(!isVisible)
    {
        [self createSignInView];
    }
    else
    {
        //nothing to do
    }
}

-(void)createSignInView
{
    [self removeAllSubviews];
    isVisible = YES;
    
    self.blackView = [[UIView alloc] initWithFrame:self.window.bounds];
    self.blackView.userInteractionEnabled = YES;
    self.blackView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.15];
    
    UITapGestureRecognizer *tapblackView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBlackView:)];
    tapblackView.delegate = self;
    [self.blackView addGestureRecognizer:tapblackView];
    [self.window addSubview:self.blackView];
    
    CGFloat viewHeight = [[GeneralTool sharedInstance] getHeightWithString:self.message fontSize:15 width:ScreenWidth - 80] + 88;
    if(viewHeight < 150)
    {
        viewHeight = 150;
    }
    if(viewHeight > ScreenHeight - 120)
    {
        viewHeight = ScreenHeight - 120;
    }
    self.generalView = [[GeneralView alloc] initWithSMFrame:CGRectMake(40, (ScreenHeight - viewHeight)/2.0, ScreenWidth - 80, viewHeight)];
    self.generalView.clipsToBounds = YES;
    self.generalView.layer.cornerRadius = 10;
    self.generalView.layer.borderColor = ItemColorFromRGB(0xf2f2f2).CGColor;
    self.generalView.layer.borderWidth = 1.5;
    if(self.titleStr && self.titleStr.length > 0)
    {
        self.generalView.sm_titleLabel.text = self.titleStr;
    }
    else
    {
        self.generalView.sm_titleLabel.text = @"提示";
    }
    self.generalView.sm_messageLabel.text = self.message;
    [self.generalView.sm_sureBtn addTarget:self action:@selector(sureBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.window addSubview:self.generalView];
}

-(void)sureBtnAction:(UIButton *)sender
{
    if(self.delegate)
    {
        self.delegate();
    }
    [self hide];
}

-(void)tapBlackView:(UITapGestureRecognizer *)tap
{
//    [self hide];
}

-(void)hide
{
    isVisible = NO;
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.5 animations:^{
        weakSelf.blackView.alpha = 0;
        weakSelf.generalView.alpha = 0;
        weakSelf.closeBtn.alpha = 0;
    } completion:^(BOOL finished) {
        [weakSelf.blackView removeFromSuperview];
        [weakSelf.generalView removeFromSuperview];
        [weakSelf.closeBtn removeFromSuperview];
    }];
}

@end

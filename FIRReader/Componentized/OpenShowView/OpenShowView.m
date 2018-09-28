//
//  OpenShowView.m
//  DaddyLoan
//
//  Created by Paul on 2018/6/1.
//  Copyright © 2018 QingHu. All rights reserved.
//

#import "OpenShowView.h"
#import "OpenShowMainView.h"

@interface OpenShowView()
<
    UIGestureRecognizerDelegate,
    UIWebViewDelegate,
    UITextFieldDelegate
>

@property (nonatomic, strong) UIWindow *window;
@property (nonatomic, strong) UIButton *closeBtn;
@property (nonatomic, strong) UIView *blackView;
@property (nonatomic, strong) UIView *openShowMainView;

@end

static BOOL isVisible = NO;
static CGFloat showAnimationDuration = 0.3;

@implementation OpenShowView

static OpenShowView *openShowView = nil;
+(OpenShowView *)shareInstance
{
    if(!openShowView)
    {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            openShowView = [[OpenShowView alloc] initOpenShowView];
        });
    }
    return openShowView;
}

- (instancetype)initOpenShowView
{
    self = [super init];
    if (self)
    {
        self.window = [UIApplication sharedApplication].delegate.window;
        self.window.windowLevel = UIWindowLevelNormal;
    }
    return self;
}

-(void)showDeledate:(id <OpenShowViewDelegate>)delegate showView:(UIView *)showView
{
    if(!isVisible)
    {
        self.delegate = delegate;
        self.openShowMainView = showView;
        [self createSignIniView];
    }
    else
    {
        //nothing to do
    }
}

-(void)createSignIniView
{
    [self removeAllSubviews];
    isVisible = YES;
    
    self.blackView = [[UIView alloc] initWithFrame:self.window.bounds];
    self.blackView.userInteractionEnabled = YES;
    self.blackView.alpha = 0;
    self.blackView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    
    UITapGestureRecognizer *tapblackView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBlackView:)];
    tapblackView.delegate = self;
    [self.blackView addGestureRecognizer:tapblackView];
    
    [self.window addSubview:self.blackView];
    
    self.closeBtn = [[UIButton alloc] initWithFrame:CGRectMake((ScreenWidth - 40)/2.0, ScreenHeight - 100, 40, 40)];
    [self.closeBtn addTarget:self action:@selector(closeBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.closeBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [self.closeBtn setTitle:@" X " forState:(UIControlStateNormal)];
    self.closeBtn.titleLabel.font = [UIFont systemFontOfSize:22];
    self.closeBtn.clipsToBounds = YES;
    self.closeBtn.layer.cornerRadius = self.closeBtn.width/2.0;
    self.closeBtn.layer.borderWidth = 2;
    self.closeBtn.alpha = 0;
    self.closeBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    [self.window addSubview:self.closeBtn];
    
    [self.window addSubview:self.openShowMainView];
    self.openShowMainView.alpha = 0;
    
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:showAnimationDuration animations:^{
        weakSelf.blackView.alpha = 1.0;
        weakSelf.closeBtn.alpha = 1.0;
    } completion:^(BOOL finished) {
        __weak typeof(weakSelf) strongSelf = weakSelf;
        [UIView animateWithDuration:showAnimationDuration animations:^{
            strongSelf.openShowMainView.alpha = 1.0;
        }];
    }];
}

-(void)openshowBtnAction:(UIButton *)sender
{
    [self hide];
}

-(void)closeBtnAction:(UIButton *)sender
{
    [self hide];
}

-(void)tapBlackView:(UITapGestureRecognizer *)tap
{
    [self hide];
}

-(void)hide
{
    if(self.delegate && [self.delegate performSelector:@selector(didHideOpenShowView)])
    {
        [self.delegate didHideOpenShowView];
    }
    isVisible = NO;
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.5 animations:^{
        weakSelf.blackView.alpha = 0;
        weakSelf.openShowMainView.alpha = 0;
        weakSelf.closeBtn.alpha = 0;
    } completion:^(BOOL finished) {
        [weakSelf.blackView removeFromSuperview];
        [weakSelf.openShowMainView removeFromSuperview];
        [weakSelf.closeBtn removeFromSuperview];
    }];
}

@end

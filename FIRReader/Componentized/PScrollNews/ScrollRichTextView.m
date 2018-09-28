//
//  ScrollRichTextView.m
//  DaddyLoan
//
//  Created by Paul on 2018/6/1.
//  Copyright © 2018 QingHu. All rights reserved.
//

#import "ScrollRichTextView.h"
#import "ESTimer.h"

@interface ScrollRichTextView()<UITableViewDelegate, UITableViewDataSource>

//数据源
@property (nonatomic, strong) UITableView *scrolltableView;
@property (nonatomic, strong) ESTimer *timer;
@property (nonatomic, assign) NSInteger scrollIndex;
@property (nonatomic, strong) NSMutableArray *viewsArray;

@property (nonatomic, assign) BOOL isBlur; //是否添加毛玻璃效果
@property (nonatomic, assign) ScrollRichTextViewBlurType blurType;

@end

static CGFloat blurDelayTime = 0.5;

@implementation ScrollRichTextView

-(instancetype) initWithFrame:(CGRect)frame views:(NSArray *)viewsArray
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.isBlur = NO;
        self.blurType = ScrollRichTextViewBlurTypeCollapseToTop;
        self.scrollIndex = 0;
        self.scrolltableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height) style:UITableViewStylePlain];
        self.scrolltableView.delegate = self;
        self.scrolltableView.dataSource = self;
        self.viewsArray = [viewsArray mutableCopy];
        [self inputScrollData:self.viewsArray];
        self.scrolltableView.scrollEnabled = NO;
        self.scrolltableView.separatorColor = [UIColor clearColor];
        self.scrolltableView.sectionHeaderHeight = 0.0001;
        self.scrolltableView.sectionFooterHeight = 0.0001;
        [self addSubview:self.scrolltableView];
    }
    return self;
}

-(void)inputScrollData:(NSMutableArray *)arr
{
    if(self.viewsArray.count > 0)
    {
        [self.viewsArray addObject:[self.viewsArray firstObject]];
    }
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.scrollIndex inSection:0];
    CGRect rect = [self.scrolltableView rectForRowAtIndexPath:indexPath];
    [self.scrolltableView setContentOffset:CGPointMake(rect.origin.x, rect.origin.y) animated:YES];
    
    WEAKSELF
    [self.timer startTimerWithTimerType:(ESTimerTypeGCD) timeInterval:3 startTimerBlock:^(CGFloat seconds) {
        if(self.viewsArray.count == 0)
        {
            weakSelf.scrollIndex = 0;
            [weakSelf.scrolltableView setContentOffset:CGPointMake(0, 0) animated:NO];
            return;
        }
        else
        {
            if(weakSelf.scrollIndex <= weakSelf.viewsArray.count)
            {
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:weakSelf.scrollIndex inSection:0];
                CGRect rect = [weakSelf.scrolltableView rectForRowAtIndexPath:indexPath];
                [weakSelf.scrolltableView setContentOffset:CGPointMake(rect.origin.x, rect.origin.y) animated:YES];
                weakSelf.scrollIndex++;
                STRONGSELF
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(blurDelayTime/2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    if(strongSelf.scrollIndex == (strongSelf.viewsArray.count))
                    {
                        weakSelf.scrollIndex = 1;
                        [weakSelf.scrolltableView setContentOffset:CGPointMake(0, 0) animated:NO];
                    }
                });
            }
        }
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.viewsArray.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.frame.size.height;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"scrollCell"];
    if(!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"scrollCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [cell.contentView removeAllSubviews];
    UIView *view = (UIView *)self.viewsArray[indexPath.row];
    if(self.isBlur)
    {
        UIVisualEffectView *visualEffectView = [self addBlurToView:view];
        [self collaspeBlurDelay:blurDelayTime visualEffectView:visualEffectView type:self.blurType animationDuration:0.5];
    }
    view.frame = ({
        CGRect frame = view.frame;
        frame.size.width = cell.contentView.width;
        frame;
    });
    [cell.contentView addSubview:view];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(clickNewsItem:index:)])
    {
        [self.delegate clickNewsItem:self.viewsArray[indexPath.row] index:indexPath.row];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return self.scrolltableView.sectionHeaderHeight;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return self.scrolltableView.sectionFooterHeight;
}

-(NSAttributedString *)highLightStr:(NSString *)subString inStr:(NSString *)originStr
{
    NSArray *subStringArr = [subString componentsSeparatedByString:@"|"];
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:originStr];;
    for (int i = 0; i < subStringArr.count; i++)
    {
        [attrStr addAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} range:[originStr rangeOfString:subStringArr[i]]];
    }
    return [attrStr copy];
}

-(void)reloadScrolltableViewsArray:(NSArray *)viewsArray
{
    self.viewsArray = [viewsArray mutableCopy];
    self.scrollIndex = 0;
    [self.scrolltableView setContentOffset:CGPointMake(0, 0) animated:NO];
    [self.scrolltableView reloadData];
}

-(ESTimer *)timer
{
    if(!_timer)
    {
        _timer = [[ESTimer alloc] init];
    }
    return _timer;
}

-(void)setIsBlur:(BOOL)blur
{
    _isBlur = blur;
}

-(void)setIsBlur:(BOOL)blur hideAnimationType:(ScrollRichTextViewBlurType)hideAnimationType
{
    _isBlur = blur;
    _blurType = hideAnimationType;
}

-(UIVisualEffectView *)addBlurToView:(UIView *)view
{
    CGRect blurRect = CGRectZero;
    switch (self.blurType)
    {
        case ScrollRichTextViewBlurTypeCollapseToTop:
        case ScrollRichTextViewBlurTypeCollapseToLeft:
        case ScrollRichTextViewBlurTypeCollapseToRight:
        case ScrollRichTextViewBlurTypeCollapseToBottom:
        {
            blurRect = CGRectMake(0, 0, view.width, view.height);
        }
            break;
        case ScrollRichTextViewBlurTypeGradient:
        {
            blurRect = CGRectMake(0, 0, view.width, view.height);
        }
            break;
        default:
        {
            blurRect = CGRectMake(0, 0, view.width, view.height);
        }
            break;
    }
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc] initWithFrame:blurRect];
    visualEffectView.clipsToBounds = YES;
    visualEffectView.layer.cornerRadius = 10;
    [visualEffectView setEffect:blurEffect];
    [view addSubview:visualEffectView];
    return visualEffectView;
}

-(void)collaspeBlurDelay:(CGFloat)delayTime visualEffectView:(UIVisualEffectView *)visualEffectView type:(ScrollRichTextViewBlurType)type animationDuration:(CGFloat)animationDuration
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if(visualEffectView)
        {
            switch (type)
            {
                case ScrollRichTextViewBlurTypeCollapseToTop:
                {
                    [UIView animateWithDuration:animationDuration animations:^{
                        visualEffectView.alpha = 0.3;
                        visualEffectView.frame = ({
                            CGRect frame = visualEffectView.frame;
                            frame.size.height = 0;
                            frame;
                        });
                    } completion:^(BOOL finished) {
                        [visualEffectView removeFromSuperview];
                    }];
                }
                    break;
                case ScrollRichTextViewBlurTypeCollapseToLeft:
                {
                    [UIView animateWithDuration:animationDuration animations:^{
                        visualEffectView.alpha = 0.3;
                        visualEffectView.clipsToBounds = YES;
                        visualEffectView.frame = ({
                            CGRect frame = visualEffectView.frame;
                            frame.size.width = 0;
                            frame;
                        });
                    } completion:^(BOOL finished) {
                        [visualEffectView removeFromSuperview];
                    }];
                }
                    break;
                case ScrollRichTextViewBlurTypeCollapseToRight:
                {
                    [UIView animateWithDuration:animationDuration animations:^{
                        visualEffectView.alpha = 0.3;
                        visualEffectView.clipsToBounds = YES;
                        visualEffectView.frame = ({
                            CGRect frame = visualEffectView.frame;
                            frame.size.width = 0;
                            frame.origin.x = visualEffectView.frame.size.width;
                            frame;
                        });
                    } completion:^(BOOL finished) {
                        [visualEffectView removeFromSuperview];
                    }];
                }
                    break;
                case ScrollRichTextViewBlurTypeCollapseToBottom:
                {
                    [UIView animateWithDuration:animationDuration animations:^{
                        visualEffectView.alpha = 0.3;
                        visualEffectView.clipsToBounds = YES;
                        visualEffectView.frame = ({
                            CGRect frame = visualEffectView.frame;
                            frame.size.height = 0;
                            frame.origin.y = visualEffectView.frame.size.height;
                            frame;
                        });
                    } completion:^(BOOL finished) {
                        [visualEffectView removeFromSuperview];
                    }];
                }
                    break;
                case ScrollRichTextViewBlurTypeGradient:
                {
                    [UIView animateWithDuration:animationDuration animations:^{
                        visualEffectView.alpha = 0.0;
                    } completion:^(BOOL finished) {
                        [visualEffectView removeFromSuperview];
                    }];
                }
                    break;
                default:
                    break;
            }
        }
    });
}

@end


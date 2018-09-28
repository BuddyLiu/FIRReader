//
//  ViewTool.m
//  IntegralWall
//
//  Created by QingHu on 2018/6/25.
//  Copyright © 2018 QingHu. All rights reserved.
//

#import "ViewTool.h"

@implementation ViewTool

DEF_SINGLETON(ViewTool)

- (void)drawSectorWithDatas:(NSArray <NSNumber *>*)datas
                     colors:(NSArray <UIColor *>*)colors
                     inView:(UIView *)view
            sectorLineWidth:(NSUInteger)sectorLineWidth
{
    if(!self.needsToRefreshSubLayers)
    {
        self.needsToRefreshSubLayers = [NSMutableArray new];
    }
    NSArray *newDatas = [self getPersentArraysWithDataArray:datas];
    CGFloat start = 0.f;
    CGFloat end = 0.f;
    UIBezierPath *piePath = [UIBezierPath bezierPathWithArcCenter:view.center radius:100 startAngle: - M_PI_2 endAngle:M_PI_2 * 3 clockwise:YES];
    
    for (int i = 0; i < newDatas.count; i ++)
    {
        NSNumber *number = newDatas[i];
        end = start + number.floatValue;
        CAShapeLayer *pieLayer = [CAShapeLayer layer];
        pieLayer.strokeStart = start;
        pieLayer.strokeEnd = end;
        pieLayer.lineWidth = sectorLineWidth;
        pieLayer.strokeColor = [colors.count > i?colors[i]:[UIColor clearColor] CGColor];
        pieLayer.fillColor = [UIColor clearColor].CGColor;
        pieLayer.path = piePath.CGPath;
        
        [self addAnimateToLayer:pieLayer];
        
        [self.needsToRefreshSubLayers addObject:pieLayer];
        
        [view.layer addSublayer:pieLayer];
        start = end;
    }
}

- (void)redrawSectorWithDatas:(NSArray <NSNumber *>*)datas
                       colors:(NSArray <UIColor *>*)colors
                       inView:(UIView *)view
              sectorLineWidth:(NSUInteger)sectorLineWidth
{
    for (int i = 0; i < self.needsToRefreshSubLayers.count; i++)
    {
        CALayer *layer = self.needsToRefreshSubLayers[i];
        [layer removeFromSuperlayer];
    }
    [self.needsToRefreshSubLayers removeAllObjects];
    
    [self drawSectorWithDatas:datas colors:colors inView:view sectorLineWidth:sectorLineWidth];
}

-(void)addAnimateToLayer:(CAShapeLayer *)layer
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.duration = 1.f;
    animation.fromValue = [NSNumber numberWithFloat:0.f];
    animation.toValue = [NSNumber numberWithFloat:1.f];
    //禁止还原
    animation.autoreverses = NO;
    //禁止完成即移除
    animation.removedOnCompletion = NO;
    //让动画保持在最后状态
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [layer addAnimation:animation forKey:@"strokeEnd"];
}

/**
 将数据按降序排列，再计算出所占比例返回
 
 @param datas 原始数据
 @return 数据占比数组
 */
- (NSArray *)getPersentArraysWithDataArray:(NSArray *)datas
{
    NSArray *newDatas = [datas sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        if ([obj1 floatValue] < [obj2 floatValue])
        {
            return NSOrderedDescending;
        }
        else if ([obj1 floatValue] > [obj2 floatValue])
        {
            return NSOrderedAscending;
        }
        else
        {
            return NSOrderedSame;
        }
    }];
    
    NSMutableArray *persentArray = [NSMutableArray array];
    NSNumber *sum = [newDatas valueForKeyPath:@"@sum.floatValue"];
    for (NSNumber *number in newDatas)
    {
        [persentArray addObject:@(number.floatValue/sum.floatValue)];
    }
    
    return persentArray;
}


-(void)addBlankViewToView:(UIView *)view title:(NSString *)title subTitle:(NSString *)subTitle image:(UIImage *)image
{
    UIView *backView = [view viewWithTag:1235679];
    [backView removeFromSuperview];
    UILabel *titleLabel = [view viewWithTag:12356790];
    [titleLabel removeFromSuperview];
    UILabel *subTitleLabel = [view viewWithTag:12356791];
    [subTitleLabel removeFromSuperview];
    UIImageView *messageImageView = [view viewWithTag:12356790];
    [messageImageView removeFromSuperview];
    
    UIView *blankBackView = [[UIView alloc] initWithFrame:view.bounds];
    blankBackView.tag = 1235679;
    blankBackView.backgroundColor = [UIColor whiteColor];
    [view addSubview:blankBackView];
    
    UILabel *blankTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, view.frame.size.height/3.0, view.frame.size.width, 20)];
    blankTitleLabel.tag = 12356790;
    blankTitleLabel.backgroundColor = [UIColor whiteColor];
    blankTitleLabel.textAlignment = NSTextAlignmentCenter;
    blankTitleLabel.textColor = [UIColor blackColor];
    blankTitleLabel.font = kSysFontSize(15);
    blankTitleLabel.text = title;
    [blankBackView addSubview:blankTitleLabel];
    
    UILabel *blankSubTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(blankTitleLabel.frame) + 10, view.frame.size.width, 20)];
    blankSubTitleLabel.tag = 12356791;
    blankSubTitleLabel.backgroundColor = [UIColor whiteColor];
    blankSubTitleLabel.textAlignment = NSTextAlignmentCenter;
    blankSubTitleLabel.textColor = ItemColorFromRGB(0x666666);
    blankSubTitleLabel.font = kSysFontSize(13);
    blankSubTitleLabel.text = subTitle;
    blankSubTitleLabel.numberOfLines = 0;
    [blankBackView addSubview:blankSubTitleLabel];
    
    UIImageView *blankImageView = [[UIImageView alloc] initWithFrame:CGRectMake((view.frame.size.width-80)/2.0, CGRectGetMinY(blankTitleLabel.frame) - 85, 80, 80)];
    blankImageView.image = image;
    [blankBackView addSubview:blankImageView];
    
    [view bringSubviewToFront:blankBackView];
    [blankBackView bringSubviewToFront:blankTitleLabel];
    [blankBackView bringSubviewToFront:blankSubTitleLabel];
    [blankBackView bringSubviewToFront:blankImageView];
}

-(void)removeBlankViewFromView:(UIView *)view
{
    UIView *backView = [view viewWithTag:1235679];
    [backView removeFromSuperview];
    UILabel *titleLabel = [view viewWithTag:12356790];
    [titleLabel removeFromSuperview];
    UILabel *subTitleLabel = [view viewWithTag:12356791];
    [subTitleLabel removeFromSuperview];
    UIImageView *messageImageView = [view viewWithTag:12356790];
    [messageImageView removeFromSuperview];
}

-(void)addTransitionAnimationToViews:(NSArray *)viewsArray
{
    [self addTransitionAnimationToViews:viewsArray animationTime:1.0];
}

-(void)addTransitionAnimationToViews:(NSArray *)viewsArray animationTime:(CGFloat)animationTime
{
    for(int i = 0; i < viewsArray.count; i++)
    {
        UIView *view = (UIView *)viewsArray[i];
        view.alpha = 0;
        [UIView animateWithDuration:animationTime animations:^{
            view.alpha = 1.0;
        }];
    }
}

@end

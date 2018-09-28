//
//  BaseNavViewController.m
//  IntegralWall
//
//  Created by QingHu on 2018/6/25.
//  Copyright © 2018 QingHu. All rights reserved.
//

#import "BaseNavViewController.h"

@interface BaseNavViewController ()

@end

@implementation BaseNavViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor], NSFontAttributeName:[UIFont systemFontOfSize:18]}];
    self.navigationBar.backgroundColor = [UIColor clearColor];
    self.navigationBar.barTintColor = [UIColor clearColor];
    [self.navigationBar setBackgroundImage:[self imageWithColor:MainColor size:CGSizeMake(ScreenWidth, NavBarHeight + StateBarHeight)] forBarMetrics:UIBarMetricsDefault];
}

-(UIImage *)imageWithColor:(UIColor *)aColor size:(CGSize)size
{
    CGRect aFrame = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(aFrame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [aColor CGColor]);
    CGContextFillRect(context, aFrame);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end

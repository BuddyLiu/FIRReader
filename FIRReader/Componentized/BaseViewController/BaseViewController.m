//
//  BaseViewController.m
//  IntegralWall
//
//  Created by QingHu on 25/06/2018.
//  Copyright © 2018 QingHu. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"general_back"] style:(UIBarButtonItemStyleDone) target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
}

-(void)back
{
    if(self.navigationController.viewControllers.count <= 1)
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end


//
//  AppDetailView.m
//  FIRReader
//
//  Created by Paul on 2018/9/27.
//  Copyright © 2018年 Liu Bo. All rights reserved.
//

#import "AppDetailView.h"

@implementation AppDetailView

-(instancetype)initWithHDFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self = [[NSBundle mainBundle] loadNibNamed:@"AppDetailView" owner:self options:nil][0];
        self.frame = frame;
    }
    return self;
}

-(instancetype)initWithHFFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self = [[NSBundle mainBundle] loadNibNamed:@"AppDetailView" owner:self options:nil][1];
        self.frame = frame;
    }
    return self;
}

@end

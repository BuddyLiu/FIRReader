//
//  OpenShowMainView.m
//  QHWallet
//
//  Created by Paul on 2018/9/10.
//  Copyright © 2018年 QingHu. All rights reserved.
//

#import "OpenShowMainView.h"

@implementation OpenShowMainView

- (instancetype)initWithhFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self = [[NSBundle mainBundle] loadNibNamed:@"OpenShowMainView" owner:self options:nil][0];
        self.frame = frame;
    }
    return self;
}

- (instancetype)initWithrFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self = [[NSBundle mainBundle] loadNibNamed:@"OpenShowMainView" owner:self options:nil][1];
        self.frame = frame;
    }
    return self;
}

- (instancetype)initWithsFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self = [[NSBundle mainBundle] loadNibNamed:@"OpenShowMainView" owner:self options:nil][2];
        self.frame = frame;
    }
    return self;
}

- (instancetype)initWithBefFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self = [[NSBundle mainBundle] loadNibNamed:@"OpenShowMainView" owner:self options:nil][3];
        self.frame = frame;
    }
    return self;
}

@end

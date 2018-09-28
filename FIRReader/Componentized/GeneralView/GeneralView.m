//
//  GeneralView.m
//  IntegralWall
//
//  Created by Paul on 2018/8/2.
//  Copyright © 2018 QingHu. All rights reserved.
//

#import "GeneralView.h"

@implementation GeneralView

- (instancetype)initWithSMFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self = [[NSBundle mainBundle]loadNibNamed:@"GeneralView" owner:self options:nil][0];
        self.frame = frame;
    }
    return self;
}

@end

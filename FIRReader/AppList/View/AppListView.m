//
//  AppListView.m
//  FIRReader
//
//  Created by Paul on 2018/9/27.
//  Copyright © 2018年 Liu Bo. All rights reserved.
//

#import "AppListView.h"

@implementation AppListView

- (instancetype)initWithHFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self = [[NSBundle mainBundle] loadNibNamed:@"AppListView" owner:self options:nil][0];
        self.frame = frame;
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

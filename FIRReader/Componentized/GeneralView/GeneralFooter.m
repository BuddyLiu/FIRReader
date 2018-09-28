//
//  GeneralFooter.m
//  IntegralWall
//
//  Created by Paul on 2018/7/3.
//  Copyright © 2018 QingHu. All rights reserved.
//

#import "GeneralFooter.h"

@implementation GeneralFooter

+(MJRefreshBackNormalFooter *)generalFooterTarget:(id)target selector:(SEL)selector
{
    MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:target refreshingAction:selector];
    footer.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    footer.stateLabel.hidden = YES;
    return footer;
}

@end

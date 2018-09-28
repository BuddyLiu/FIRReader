//
//  ASCommonMetrics.h
//  Alton
//
//  Created by square on 15/5/25.
//  Copyright (c) 2015年 square. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#if defined __cplusplus
extern "C" {
#endif

#ifndef UIViewAutoresizingFlexibleMargins
#define UIViewAutoresizingFlexibleMargins (UIViewAutoresizingFlexibleLeftMargin \
                                           | UIViewAutoresizingFlexibleTopMargin \
                                           | UIViewAutoresizingFlexibleRightMargin \
                                           | UIViewAutoresizingFlexibleBottomMargin)
#endif

#ifndef UIViewAutoresizingFlexibleDimensions
#define UIViewAutoresizingFlexibleDimensions (UIViewAutoresizingFlexibleWidth \
                                              | UIViewAutoresizingFlexibleHeight)
#endif

#ifndef UIViewAutoresizingNavigationBar
#define UIViewAutoresizingNavigationBar (UIViewAutoresizingFlexibleWidth \
                                         | UIViewAutoresizingFlexibleBottomMargin)
#endif

#ifndef UIViewAutoresizingToolbar
#define UIViewAutoresizingToolbar (UIViewAutoresizingFlexibleWidth \
                                   | UIViewAutoresizingFlexibleTopMargin)
#endif

/**
 * The recommended number of points for a minimum tappable area.
 *
 * Value: 44
 */
CGFloat ASMinimumTapDimension(void);

/**
 * Fetch the height of a toolbar in a given orientation.
 *
 * On the iPhone:
 * - Portrait: 44
 * - Landscape: 33
 *
 * On the iPad: always 44
 */
CGFloat ASToolbarHeightForOrientation(UIInterfaceOrientation orientation);

/**
 * The animation curve used when changing the status bar's visibility.
 *
 * This is the curve of the animation used by
 * <code>-[[UIApplication sharedApplication] setStatusBarHidden:withAnimation:].</code>
 *
 * Value: UIViewAnimationCurveEaseIn
 */
UIViewAnimationCurve ASStatusBarAnimationCurve(void);

/**
 * The animation duration used when changing the status bar's visibility.
 *
 * This is the duration of the animation used by
 * <code>-[[UIApplication sharedApplication] setStatusBarHidden:withAnimation:].</code>
 *
 * Value: 0.3 seconds
 */
NSTimeInterval ASStatusBarAnimationDuration(void);

/**
 * The animation curve used when the status bar's bounds change (when a call is received,
 * for example).
 *
 * Value: UIViewAnimationCurveEaseInOut
 */
UIViewAnimationCurve ASStatusBarBoundsChangeAnimationCurve(void);

/**
 * The animation duration used when the status bar's bounds change (when a call is received,
 * for example).
 *
 * Value: 0.35 seconds
 */
NSTimeInterval ASStatusBarBoundsChangeAnimationDuration(void);

/**
 * Get the status bar's current height.
 *
 * If the status bar is hidden this will return 0.
 *
 * This is generally 20 when the status bar is its normal height.
 */
CGFloat ASStatusBarHeight(void);

/**
 * The animation duration when the device is rotating to a new orientation.
 *
 * Value: 0.4 seconds if the device is being rotated 90 degrees.
 *        0.8 seconds if the device is being rotated 180 degrees.
 *
 * @param isFlippingUpsideDown YES if the device is being flipped upside down.
 */
NSTimeInterval ASDeviceRotationDuration(BOOL isFlippingUpsideDown);

/**
 * The padding around a standard cell in a table view.
 *
 * Value: 10 pixels on all sides.
 */
UIEdgeInsets ASCellContentPadding(void);

#if defined __cplusplus
};
#endif

/**@}*/// End of Common Metrics ///////////////////////////////////////////////////////////////////

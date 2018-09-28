//
//  ASDeviceOrientation.h
//
//  Created by square on 15/5/25.
//  Copyright (c) 2015年 square. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#if defined __cplusplus
extern "C" {
#endif

/**
 * For dealing with device orientations.
 *
 * <h2>Examples</h2>
 *
 * <h3>Use ASIsSupportedOrientation to Enable Autorotation</h3>
 *
 * @code
 *  - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
 *    return ASIsSupportedOrientation(toInterfaceOrientation);
 *  }
 * @endcode
 *
 * @ingroup ASmbusCore
 * @defgroup Device-Orientation Device Orientation
 * @{
 */

/**
 * For use in shouldAutorotateToInterfaceOrientation:
 *
 * On iPhone/iPod touch:
 *
 *      Returns YES if the orientation is portrait, landscape left, or landscape right.
 *      This helps to ignore upside down and flat orientations.
 *
 * On iPad:
 *
 *      Always returns YES.
 */
BOOL ASIsSupportedOrientation(UIInterfaceOrientation orientation);

/**
 * Returns the application's current interface orientation.
 *
 * This is simply a convenience method for [UIApplication sharedApplication].statusBarOrientation.
 *
 * @returns The current interface orientation.
 */
UIInterfaceOrientation ASInterfaceOrientation(void);

/**
 * Returns YES if the device is a phone and the orientation is landscape.
 *
 * This is a useful check for phone landscape mode which often requires
 * additional logic to handle the smaller vertical real estate.
 *
 * @returns YES if the device is a phone and orientation is landscape.
 */
BOOL ASIsLandscapePhoneOrientation(UIInterfaceOrientation orientation);

/**
 * Creates an affine transform for the given device orientation.
 *
 * This is useful for creating a transformation matrix for a view that has been added
 * directly to the window and doesn't automatically have its transformation modified.
 */
CGAffineTransform ASRotateTransformForOrientation(UIInterfaceOrientation orientation);

#if defined __cplusplus
};
#endif

/**@}*/// End of Device Orientation ///////////////////////////////////////////////////////////////


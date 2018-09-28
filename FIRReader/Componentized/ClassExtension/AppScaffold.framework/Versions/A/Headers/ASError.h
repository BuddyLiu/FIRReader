//
//  ASError.h
//
//  Created by square on 15/5/25.
//  Copyright (c) 2015年 square. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 * For defining various error types used throughout the AppScaffold framework.
 *
 * @defgroup Errors Errors
 * @{
 */

/** The AppScaffold error domain. */
extern NSString* const ASErrorDomain;

/** The key used for images in the error's userInfo. */
extern NSString* const ASImageErrorKey;

/** NSError codes in ASErrorDomainCode. */
typedef enum {
  /** The image is too small to be used. */
  ASImageTooSmall = 1,
} ASErrorDomainCode;


/**@}*/// End of Errors ///////////////////////////////////////////////////////////////////////////

/**
 * <h3>Example</h3>
 *
 * @code
 * error = [NSError errorWithDomain: ASErrorDomain
 *                             code: ASImageTooSmall
 *                         userInfo: [NSDictionary dictionaryWithObject: image
 *                                                               forKey: ASImageErrorKey]];
 * @endcode
 *
 * @enum ASErrorDomainCode
 */

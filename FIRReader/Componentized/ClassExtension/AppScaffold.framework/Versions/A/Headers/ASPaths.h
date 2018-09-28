//
//  ASPath.h
//
//  Created by apple on 13-12-9.
//  Copyright (c) 2013年 square. All rights reserved.
//

#import <Foundation/Foundation.h>

#if defined __cplusplus
extern "C" {
#endif

/**
 * Create a path with the given bundle and the relative path appended.
 *
 * @param bundle        The bundle to append relativePath to. If nil, [NSBundle mainBundle]
 *                           will be used.
 * @param relativePath  The relative path to append to the bundle's path.
 *
 * @returns The bundle path concatenated with the given relative path.
 */
NSString* ASPathForBundleResource(NSBundle* bundle, NSString* relativePath);

/**
 * Create a path with the documents directory and the relative path appended.
 *
 * @returns The documents path concatenated with the given relative path.
 */
NSString* ASPathForDocumentsResource(NSString* relativePath);

/**
 * Create a path with the Library directory and the relative path appended.
 *
 * @returns The Library path concatenated with the given relative path.
 */
NSString* ASPathForLibraryResource(NSString* relativePath);

/**
 * Create a path with the caches directory and the relative path appended.
 *
 * @returns The caches path concatenated with the given relative path.
 */
NSString* ASPathForCachesResource(NSString* relativePath);

#if defined __cplusplus
};
#endif

/**@}*/// End of Paths ////////////////////////////////////////////////////////////////////////////

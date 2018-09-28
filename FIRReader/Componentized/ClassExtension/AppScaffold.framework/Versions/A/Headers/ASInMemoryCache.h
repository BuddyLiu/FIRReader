//
//  ASInMemoryCache.h
//
//  Created by square on 15/5/25.
//  Copyright (c) 2015年 square. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * For storing and accessing objects in memory.
 *
 * The base class, ASMemoryCache, is a generic object store that may be used for anything that
 * requires support for expiration.
 *
 * @defgroup In-Memory-Caches In-Memory Caches
 * @{
 */

/**
 * An in-memory cache for storing objects with expiration support.
 *
 * The AppScaffold in-memory object cache allows you to store objects in memory with an expiration
 * date attached. Objects with expiration dates drop out of the cache when they have expired.
 */
@interface ASMemoryCache : NSObject

// Designated initializer.
- (id)initWithCapacity:(NSUInteger)capacity;

- (NSUInteger)count;

- (void)storeObject:(id)object withName:(NSString *)name;
- (void)storeObject:(id)object withName:(NSString *)name expiresAfter:(NSDate *)expirationDate;

- (void)removeObjectWithName:(NSString *)name;
- (void)removeAllObjectsWithPrefix:(NSString *)prefix;
- (void)removeAllObjects;

- (id)objectWithName:(NSString *)name;
- (BOOL)containsObjectWithName:(NSString *)name;
- (NSDate *)dateOfLastAccessWithName:(NSString *)name;

- (NSString *)nameOfLeastRecentlyUsedObject;
- (NSString *)nameOfMostRecentlyUsedObject;

- (void)reduceMemoryUsage;

// Subclassing

- (BOOL)shouldSetObject:(id)object withName:(NSString *)name previousObject:(id)previousObject;
- (void)didSetObject:(id)object withName:(NSString *)name;
- (void)willRemoveObject:(id)object withName:(NSString *)name;

@end

/**
 * An in-memory cache for storing images with caps on the total number of pixels.
 *
 * When reduceMemoryUsage is called, the least recently used images are removed from the cache
 * until the numberOfPixels is below maxNumberOfPixelsUnderStress.
 *
 * When an image is added to the cache that causes the memory usage to pass the max, the
 * least recently used images are removed from the cache until the numberOfPixels is below
 * maxNumberOfPixels.
 *
 * By default the image memory cache has no limit to its pixel count. You must explicitly
 * set this value in your application.
 *
 * @attention If the cache is too small to fit the newly added image, then all images
 *                 will end up being removed including the one being added.
 *
 * @see AppScaffold::imageMemoryCache
 * @see AppScaffold::setImageMemoryCache:
 */
@interface ASImageMemoryCache : ASMemoryCache

@property (nonatomic, readonly) unsigned long long numberOfPixels;

@property (nonatomic)           unsigned long long maxNumberOfPixels;             // Default: 0 (unlimited)
@property (nonatomic)           unsigned long long maxNumberOfPixelsUnderStress;  // Default: 0 (unlimited)

@end
//
//  SPCoreData.h
//  StanfordPhotos
//
//  Created by Brian Holder-Chow Lin On on 2/25/13.
//  Copyright (c) 2013 CS193p. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BBCCoreDataManager : NSObject

/**
 * Asynchronously retrieves the singleton managedObjectContext
 * 
 * Return type is void.
 * 
 * The retrieved managedObjectContext is passed to the provided block.
 * The block has no return value and takes one parameter.
 * The block is invoked on the main queue.
 */
+ (void)sharedManagedObjectContext:(void (^)(NSManagedObjectContext *))completionHandler;

@end

//
//  CSRDSCoreDataConnector.h
//  ORA
//
//  Created by Brian Holder-Chow Lin On on 3/8/13.
//  Copyright (c) 2013 CS193p. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Metadata.h"

@interface CSRDSCoreDataConnector : NSObject

// non-blocking, success handler is invoked in main queue
+ (void)fetchAndUpdateCoreDataMetadata:(void (^)(BOOL))successHandler;

// the latest data stored in CoreData
+ (Metadata *)nowPlayingDataWithContext:(NSManagedObjectContext *)context;


// all the metadata stored in CoreData
+ (NSArray *)metadataWithContext:(NSManagedObjectContext *)context;


@end
//
//  CSRDSCoreDataConnector.m
//  ORA
//
//  Created by Brian Holder-Chow Lin On on 3/8/13.
//  Copyright (c) 2013 CS193p. All rights reserved.
//

#import "CSRDSCoreDataConnector.h"
#import "ORACoreDataManager.h"
#import "Metadata+CSRDS.h"
#import "CSRDSMetadataFetcher.h"

#define QUEUE_NAME "CoreDataCSRDSConnectorDownloadQueue"

@implementation CSRDSCoreDataConnector

+ (void)fetchAndUpdateCoreDataMetadata
{
  [ORACoreDataManager sharedManagedObjectContext:^(NSManagedObjectContext *c) {
    [[self class] fetchAndUpdateInManagedObjectContext:c];
  }];
}

#pragma mark private

+ (void)fetchAndUpdateInManagedObjectContext:(NSManagedObjectContext *)context
{
  dispatch_queue_t networkQueue = dispatch_queue_create(QUEUE_NAME, NULL);
  dispatch_async(networkQueue, ^{
    NSDictionary *csrdsMetadata = [CSRDSMetadataFetcher data];
    
    [context performBlock:^{
      [Metadata songMetadataWithCSRDSData:csrdsMetadata
                   inManagedObjectContext:context];
    }];
  });
}

@end

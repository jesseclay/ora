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
#define METADATA_FETCH_LIMIT 1

@implementation CSRDSCoreDataConnector

+ (void)fetchAndUpdateCoreDataMetadata:(void (^)(BOOL))successHandler
{
  [ORACoreDataManager sharedManagedObjectContext:^(NSManagedObjectContext *context) {
    dispatch_queue_t networkQueue = dispatch_queue_create(QUEUE_NAME, NULL);
    
    dispatch_async(networkQueue, ^{
      NSDictionary *csrdsMetadata = [CSRDSMetadataFetcher data];
      [context performBlock:^{
        [Metadata songMetadataWithCSRDSData:csrdsMetadata
                     inManagedObjectContext:context];
      }];
      dispatch_async(dispatch_get_main_queue(), ^{
        successHandler(YES);
      });
    });
    
  }];
}

+ (Metadata *)mostRecentMetadataWithContext:(NSManagedObjectContext *)context
{
  NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Metadata"];
  
  /**
   This sortDescriptor ensures the most recent is returned
   */
  request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"datetime" ascending:NO selector:@selector(compare:)]];
  [request setFetchLimit:METADATA_FETCH_LIMIT];
  
  Metadata *metadata = nil;
  NSError *error = nil;
  NSArray *matches = [context executeFetchRequest:request error:&error];
  
  if (matches && [matches count] == METADATA_FETCH_LIMIT) {
    metadata = [matches lastObject];
  }
  
  return metadata;
}

+ (NSArray *)metadataWithContext:(NSManagedObjectContext *)context
{
  NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Metadata"];
  request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"datetime" ascending:YES selector:@selector(compare:)]];
  
  NSError *error = nil;
  NSArray *matches = [context executeFetchRequest:request error:&error];
  
  return matches;
}

@end
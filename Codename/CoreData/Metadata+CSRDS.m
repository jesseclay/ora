//
//  Metadata+CSRDS.m
//  ORA
//
//  Created by Brian Holder-Chow Lin On on 3/8/13.
//  Copyright (c) 2013 CS193p. All rights reserved.
//

#import "Metadata+CSRDS.h"
#import "CSRDSMetadataFetcher.h"

#define ENTITY_NAME @"Metadata"

@implementation Metadata (CSRDS)

#pragma mark public

+ (Metadata *)songMetadataWithCSRDSData:(NSDictionary *)csrdsData
                 inManagedObjectContext:(NSManagedObjectContext *)context
{
  if ([csrdsData[MD_NOW_TYPE] isEqualToString:MD_TYPE_SONG]) {
    return [[self class] metadataWithCSRDSData:csrdsData inManagedObjectContext:context];
  }
  return nil;
}

#pragma mark private

+ (Metadata *)metadataWithCSRDSData:(NSDictionary *)csrdsData
             inManagedObjectContext:(NSManagedObjectContext *)context
{
  Metadata *metadata = nil;
  
  NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:ENTITY_NAME];
  request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"title" ascending:YES]];
  
  request.predicate = [NSPredicate predicateWithFormat:@"title = %@ AND artiste = %@",
                       csrdsData[MD_NOW_TITLE], csrdsData[MD_NOW_ARTISTE]];
  
  // Execute the fetch
  
  NSError *error = nil;
  NSArray *matches = [context executeFetchRequest:request error:&error];
  
  
  // Check what happened in the fetch
  
  if (!matches || ([matches count] > 1)) {  // nil means fetch failed; more than one impossible
                                            // handle error
  } else if (![matches count]) { // none found, so let's create a Photo for that Flickr photo
    
    metadata = [NSEntityDescription insertNewObjectForEntityForName:ENTITY_NAME
                                             inManagedObjectContext:context];
    
    metadata.type     = csrdsData[MD_NOW_TYPE];
    metadata.title    = csrdsData[MD_NOW_TITLE];
    metadata.artiste  = csrdsData[MD_NOW_ARTISTE];
    metadata.datetime = [NSDate date];
    metadata.artURLStringLarge  = csrdsData[MD_NOW_URL_COVER_LARGE];
    metadata.artURLStringMedium = csrdsData[MD_NOW_URL_COVER_MED];
    
    
  } else { // found the Metadata, just return it from the list of matches (which there will only be one of)
    metadata = [matches lastObject];
  }
  
  return metadata;
}

@end

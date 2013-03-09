//
//  Metadata+CSRDS.h
//  ORA
//
//  Created by Brian Holder-Chow Lin On on 3/8/13.
//  Copyright (c) 2013 CS193p. All rights reserved.
//

#import "Metadata.h"

@interface Metadata (CSRDS)

// returns nil if the metadata is not of type MD_TYPE_SONG
+ (Metadata *)songMetadataWithCSRDSData:(NSDictionary *)csrdsData
                 inManagedObjectContext:(NSManagedObjectContext *)context;

@end
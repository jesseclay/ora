//
//  Metadata.h
//  ORA
//
//  Created by Brian Holder-Chow Lin On on 3/17/13.
//  Copyright (c) 2013 CS193p. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Metadata : NSManagedObject

@property (nonatomic, retain) NSString * artiste;
@property (nonatomic, retain) NSString * artURLStringLarge;
@property (nonatomic, retain) NSString * artURLStringMedium;
@property (nonatomic, retain) NSDate * datetime;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSString * amznUrlString;

@end

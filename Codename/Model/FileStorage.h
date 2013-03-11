//
//  PhotoFileStorage.h
//  StanfordPhotos
//
//  Created by Brian Holder-Chow Lin On on 2/16/13.
//  Copyright (c) 2013 CS193p. All rights reserved.
//

#import <Foundation/Foundation.h>

#define CAPACITY_MB 1

#define NSLOG_FILESTORAGE NO

@interface FileStorage : NSObject

+ (void)put:(NSData *)data forKey:(NSString *)key;
+ (NSData *)get:(NSString *)key;

+ (BOOL)contains:(NSString *)key;

@end
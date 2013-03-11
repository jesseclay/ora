//
//  PersistentPhotoCache.h
//  StanfordPhotos
//
//  Created by Brian Holder-Chow Lin On on 2/17/13.
//  Copyright (c) 2013 CS193p. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface URLCache : NSObject

+ (NSData *)get:(NSURL *)url;
+ (void)put:(NSData *)data url:(NSURL *)url;
+ (BOOL)contains:(NSURL *)url;

@end

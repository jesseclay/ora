//
//  CachedImage.h
//  ORA
//
//  Created by Brian Holder-Chow Lin On on 3/11/13.
//  Copyright (c) 2013 CS193p. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CachedImage : NSObject

+ (UIImage *)imageWithURL:(NSURL *)url; // blocking
+ (UIImage *)imageWithURLString:(NSString *)string; // blocking


@end

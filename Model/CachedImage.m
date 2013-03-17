//
//  CachedImage.m
//  ORA
//
//  Created by Brian Holder-Chow Lin On on 3/11/13.
//  Copyright (c) 2013 CS193p. All rights reserved.
//

#import "CachedImage.h"
#import "URLCache.h"
#import "NetworkActivityIndicator.h"

@implementation CachedImage

+ (UIImage *)imageWithURL:(NSURL *)url
{
  NSData *data;
  if ([URLCache contains:url]) {
    data = [URLCache get:url];
  } else {
    [NetworkActivityIndicator show];
    data = [[NSData alloc] initWithContentsOfURL:url];
    [NetworkActivityIndicator hide];
    [URLCache put:data url:url];
  }
  return [[UIImage alloc] initWithData:data];
  
}

+ (UIImage *)imageWithURLString:(NSString *)string
{
  return [[self class] imageWithURL:[[NSURL alloc] initWithString:string]];
}

@end

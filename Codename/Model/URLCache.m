//
//  PersistentPhotoCache.m
//  StanfordPhotos
//
//  Created by Brian Holder-Chow Lin On on 2/17/13.
//  Copyright (c) 2013 CS193p. All rights reserved.
//

#import "URLCache.h"
#import "FileStorage.h"

@implementation URLCache


+ (NSData *)get:(NSURL *)url
{
  return [FileStorage get:[[self class] filenameFromURL:url]];
}

+ (void)put:(NSData *)data url:(NSURL *)url
{
  [FileStorage put:data forKey:[[self class] filenameFromURL:url]];
}

+ (BOOL)contains:(NSURL *)url
{
  NSData *data = [[self class] get:url];
  return data ? YES : NO;
}

#pragma mark private

+ (NSString *)filenameFromURL:(NSURL *)url
{
  return [[url pathComponents] lastObject];
}
@end

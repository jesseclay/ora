//
//  PhotoFileStorage.m
//  StanfordPhotos
//
//  Created by Brian Holder-Chow Lin On on 2/16/13.
//  Copyright (c) 2013 CS193p. All rights reserved.
//
// rename filestorage TODO
#import "FileStorage.h"

@implementation FileStorage

+ (void)put:(NSData *)data forKey:(NSString *)filename
{
  NSFileManager *fileManager = [[NSFileManager alloc] init];
  
  NSURL *dest = [[[self class] cacheURL] URLByAppendingPathComponent:filename];
  
  [fileManager createFileAtPath:[dest absoluteString] contents:data attributes:nil];
  [data writeToURL:dest atomically:YES];
  
  [[self class] removeExcessDataFromCache];
}

+ (NSData *)get:(NSString *)filename
{
  NSURL *dest = [[[self class] cacheURL] URLByAppendingPathComponent:filename];
  NSData *d = [NSData dataWithContentsOfURL:dest];
  
  return d;
}

+ (BOOL)contains:(NSString *)key
{
  
  return [[self class] get:key] ? YES : NO;
}

#pragma mark private

// with probability 1/n_elems_in_cache, may delete a data item most recently
// put into cache
+ (void)removeExcessDataFromCache
{
  // get array of urls for contents of cache folder
  NSFileManager *fileManager = [[NSFileManager alloc] init];
  NSArray *cacheURLs = [fileManager contentsOfDirectoryAtURL:[[self class] cacheURL]
                                  includingPropertiesForKeys:nil
                                                     options:NSDirectoryEnumerationSkipsHiddenFiles
                                                       error:nil];
  
  NSMutableArray *urls = [[NSMutableArray alloc] initWithArray:cacheURLs
                                                     copyItems:YES];
  

  // index into array fetching the data to get
  NSUInteger sum = 0; // the sum of the sizes of all data
  for (NSURL *url in urls) {
    sum += [[NSData dataWithContentsOfURL:url] length];
  }
  
  if (NSLOG_FILESTORAGE) {
    NSLog(@"FileStorage: %f MB in use", sum / 1024.0 / 1024.0);
  }

  // while this sum exceeds the limit
  while (sum > CAPACITY_MB * 1024 * 1024) { // 1 MB
    // pick a random url from this array,
    int i = arc4random() % [urls count];
    NSURL *urlToRemove = [urls objectAtIndex:i];
    // decrement its size from sum
    sum -= [[NSData dataWithContentsOfURL:urlToRemove] length];
    // delete the entry from cache and urls mutable array
    [fileManager removeItemAtURL:urlToRemove error:nil];
    [urls removeObjectAtIndex:i];
  }
}

+ (NSURL *)cacheURL
{
  NSFileManager *fileManager = [[NSFileManager alloc] init];
  return [[fileManager URLsForDirectory:NSCachesDirectory
                              inDomains:NSUserDomainMask]
          objectAtIndex:0];
}
@end

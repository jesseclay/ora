//
//  SPCoreData.m
//  StanfordPhotos
//
//  Created by Brian Holder-Chow Lin On on 2/25/13.
//  Copyright (c) 2013 CS193p. All rights reserved.
//

#import "BBCCoreDataManager.h"
#import <UIKit/UIManagedDocument.h>


@implementation BBCCoreDataManager

#pragma mark public class functions

+ (void)sharedManagedObjectContext:(void (^)(NSManagedObjectContext *))completionHandler
{
  static UIManagedDocument *doc = nil;
  dispatch_async(dispatch_get_main_queue(), ^{
    @synchronized(self) {
      if (doc == nil) {
        [[self class] initDocument:^(UIManagedDocument *document) {
          doc = document;
          completionHandler(document.managedObjectContext);
        }];
      } else {
        completionHandler(doc.managedObjectContext);
      }
    }    
  });
}

#pragma mark private class functions

+ (void)initDocument:(void (^)(UIManagedDocument *))completionHandler
{
  NSURL *url = [[[NSFileManager defaultManager]
                 URLsForDirectory:NSDocumentDirectory
                 inDomains:NSUserDomainMask] lastObject];
  
  url = [url URLByAppendingPathComponent:[[self class] documentName]];
  
  UIManagedDocument *document = [[UIManagedDocument alloc] initWithFileURL:url];
  
  if (![[NSFileManager defaultManager] fileExistsAtPath:[url path]]) {
    
    // CREATE
    [document saveToURL:url
       forSaveOperation:UIDocumentSaveForCreating
      completionHandler:^(BOOL success) {
        if (success) {
          completionHandler(document);
        }
      }];
    
  } else if (document.documentState == UIDocumentStateClosed) {
    
    // OPEN
    [document openWithCompletionHandler:^(BOOL success) {
      if (success) {
        completionHandler(document);
      }
    }];
    
    
  } else {
    // DOCUMENT IS OPEN
    completionHandler(document);
  }
}

#pragma mark subclasses must override

+ (NSString *)documentName
{
  return nil;
}

@end

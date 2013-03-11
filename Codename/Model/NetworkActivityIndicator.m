//
//  NetworkActivityIndicator.m
//  StanfordPhotos
//
//  Created by Brian Holder-Chow Lin On on 2/16/13.
//  Copyright (c) 2013 CS193p. All rights reserved.
//

#import "NetworkActivityIndicator.h"

@implementation NetworkActivityIndicator

static NSInteger count = 0;

+ (void)show
{
  @synchronized(self) {
    count++;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
  }
}

+ (void)hide
{
  @synchronized(self) {
    count--;
    if (count <= 0) {
      UIApplication *app = [UIApplication sharedApplication];
      app.networkActivityIndicatorVisible = NO;
    }
  }
}

@end

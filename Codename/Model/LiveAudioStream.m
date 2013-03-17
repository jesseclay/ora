//
//  LiveAudioStream.m
//  Codename
//
//  Created by Brian Holder-Chow Lin On on 2/11/13.
//  Copyright (c) 2013 CS193p. All rights reserved.
//

#import "LiveAudioStream.h"
#import "LiveAudioStreamURL.h"

@implementation LiveAudioStream

+ (LiveAudioStream *)sharedInstance
{
  static LiveAudioStream *sharedInstance = nil;
  if (!sharedInstance) {
    NSURL *url = [NSURL URLWithString:STREAM_URL];
    sharedInstance = [[LiveAudioStream alloc] initWithURL:url];
  }
  return sharedInstance;
}

- (void)play:(void (^)(BOOL))successHandler

{
  dispatch_queue_t q = dispatch_queue_create("PLAYBACK_Q", NULL);
  
  dispatch_async(q, ^{
    [super play];
    dispatch_async(dispatch_get_main_queue(), ^{
      successHandler(YES);
    });
  });
}


@end

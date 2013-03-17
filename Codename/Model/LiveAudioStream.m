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


@end

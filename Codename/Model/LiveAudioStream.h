//
//  LiveAudioStream.h
//  Codename
//
//  Created by Brian Holder-Chow Lin On on 2/11/13.
//  Copyright (c) 2013 CS193p. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

#define WEFM_URL @"http://fms.96wefm.com:1936/live/961wefm.sdp/playlist.m3u8"

@interface LiveAudioStream : AVPlayer

@end

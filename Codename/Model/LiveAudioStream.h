//
//  LiveAudioStream.h
//  Codename
//
//  Created by Brian Holder-Chow Lin On on 2/11/13.
//  Copyright (c) 2013 CS193p. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>


@interface LiveAudioStream : AVPlayer

+ (LiveAudioStream *)sharedInstance;

- (void)play:(void (^)(BOOL))successHandler;

@end

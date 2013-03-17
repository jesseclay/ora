//
//  PlayPauseButton.m
//  ORA
//
//  Created by Brian Holder-Chow Lin On on 3/17/13.
//  Copyright (c) 2013 CS193p. All rights reserved.
//

#import "PlayPauseButton.h"
#import <QuartzCore/QuartzCore.h>

#define LOADING_IMAGE @"loadingbutton@2x.png"
#define PAUSE_IMAGE @"pausebutton@2x.png"
#define PLAY_IMAGE @"playbutton@2x.png"

@implementation PlayPauseButton

- (void)spin
{
  UIImage *image = [self imageForState:UIControlStateNormal];
  [self setImage:[UIImage imageNamed:LOADING_IMAGE] forState:UIControlStateNormal];

	[CATransaction begin];

	[CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
	CGRect frame = [self frame];
	self.layer.anchorPoint = CGPointMake(0.5, 0.5);
	self.layer.position = CGPointMake(frame.origin.x + 0.5 * frame.size.width, frame.origin.y + 0.5 * frame.size.height);
	[CATransaction commit];
  
	[CATransaction begin];
	[CATransaction setValue:(id)kCFBooleanFalse forKey:kCATransactionDisableActions];
	[CATransaction setValue:[NSNumber numberWithFloat:2.0] forKey:kCATransactionAnimationDuration];
  
	CABasicAnimation *animation;
	animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
	animation.fromValue = [NSNumber numberWithFloat:0.0];
	animation.toValue = [NSNumber numberWithFloat:2 * M_PI];
	animation.timingFunction = [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionLinear];
	animation.delegate = self;
	[self.layer addAnimation:animation forKey:@"rotationAnimation"];
  
	[CATransaction commit];
  [self setImage:image forState:UIControlStateNormal];
}

- (void)displayPauseImage
{
  [self setImage:[UIImage imageNamed:PAUSE_IMAGE] forState:UIControlStateNormal];
}

- (void)displayPlayImage
{
  [self setImage:[UIImage imageNamed:PLAY_IMAGE] forState:UIControlStateNormal];
}
@end

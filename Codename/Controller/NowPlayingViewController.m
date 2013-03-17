//
//  NowPlayingViewController.m
//  ORA
//
//  Created by Brian Holder-Chow Lin On on 2/19/13.
//  Copyright (c) 2013 CS193p. All rights reserved.
//

#import "NowPlayingViewController.h"
#import "LiveAudioStream.h"
#import "CSRDSCoreDataConnector.h"
#import "ORACoreDataManager.h"
#import "CoverArtCollectionViewCell.h"
#import "URLCache.h"
#import "CachedImage.h"
#import <MediaPlayer/MPVolumeView.h>
#import <MediaPlayer/MPNowPlayingInfoCenter.h>
#import <MediaPlayer/MPMediaItem.h>

#define REUSE_IDENTIFIER @"CoverArt"
#define DEFAULT_COVER_ART_IMAGENAME  @"ora.png" 
#define COVER_ART_QUEUE   "CoverArtNetworkQueue"

#define NSLOG_NPVC NO


@interface NowPlayingViewController ()

@property (strong, nonatomic)LiveAudioStream *liveAudioStream;
@property (strong, nonatomic)NSManagedObjectContext *managedObjectContext;
@property (weak, nonatomic) IBOutlet CoverArtView *coverArtView;
@property (strong, nonatomic) Metadata *metadata;
@property (weak, nonatomic) IBOutlet MPVolumeView *volumeView;
@property (nonatomic) BOOL statusPlaying;
@end

@implementation NowPlayingViewController


#pragma mark Lifecycle


- (void)viewDidAppear:(BOOL)animated
{
  [super viewDidAppear:animated];
  [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
  [self becomeFirstResponder];
}


- (void)viewDidLoad
{
  [super viewDidLoad];
  self.statusPlaying = NO;
  [ORACoreDataManager sharedManagedObjectContext:^(NSManagedObjectContext *c) {
    self.managedObjectContext = c;
    [CSRDSCoreDataConnector fetchAndUpdateCoreDataMetadata:^(BOOL success) {
      if (success) {
        self.metadata = [CSRDSCoreDataConnector mostRecentMetadataWithContext:c];
      }
    }];
  }];
}


- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
  //End recieving events
  [[UIApplication sharedApplication] endReceivingRemoteControlEvents];
  [self resignFirstResponder];
}


#pragma mark MPNowPlayingInfoCenter handling
- (BOOL)canBecomeFirstResponder {
  return YES;
}


- (void)remoteControlReceivedWithEvent:(UIEvent *)event
{
  switch (event.subtype) {
    case UIEventSubtypeRemoteControlTogglePlayPause:
      [self play:event];
      break;
    case UIEventSubtypeRemoteControlPlay:
      [self play:event];
      break;
    case UIEventSubtypeRemoteControlPause:
      break;
    case UIEventSubtypeRemoteControlStop:
      break;
    default:
      break;
  }
}


- (void)setMPNowPlayingInfo:(Metadata *)metadata withImage:(UIImage *)image
{
  /**
   
   Setup MPNowPlayingInfoCenter Attributes
   
   */
  MPMediaItemArtwork *art;
  if (image) {
    art = [[MPMediaItemArtwork alloc] initWithImage:image];
  }
  
  NSDictionary *nowPlayingInfo = @{MPMediaItemPropertyArtist:metadata.artiste,
                                   MPMediaItemPropertyArtwork:art,
                                   MPMediaItemPropertyTitle:metadata.title};
  [[MPNowPlayingInfoCenter defaultCenter] setNowPlayingInfo:nowPlayingInfo];
}


#pragma mark Properties


- (LiveAudioStream *)liveAudioStream
{
  if (!_liveAudioStream) {
    _liveAudioStream = [LiveAudioStream sharedInstance];
  }
  return _liveAudioStream;
}


- (void)setMetadata:(Metadata *)metadata
{
  UIImage *image;
  
  if (metadata.artURLStringMedium) {
    image = [CachedImage imageWithURLString:metadata.artURLStringMedium];
  } else {
    image = [UIImage imageNamed:DEFAULT_COVER_ART_IMAGENAME];
  }
  
  self.coverArtView.image = image;
  [self setMPNowPlayingInfo:metadata withImage:image];
  _metadata = metadata;
}


#pragma mark Actions


- (IBAction)play:(id)sender {
  NSLog(@"%d", self.liveAudioStream.status);
  if (self.statusPlaying == YES) {
    [self.liveAudioStream pause];
  } else {
    [self.liveAudioStream play];
  }
  self.statusPlaying = !self.statusPlaying;
}


@end
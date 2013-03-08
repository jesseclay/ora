//
//  NowPlayingViewController.m
//  ORA
//
//  Created by Brian Holder-Chow Lin On on 2/19/13.
//  Copyright (c) 2013 CS193p. All rights reserved.
//

#import "NowPlayingViewController.h"
#import "LiveAudioStream.h"

@interface NowPlayingViewController ()
@property (strong, nonatomic)LiveAudioStream *liveAudioStream;
@end

@implementation NowPlayingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark Properties

- (LiveAudioStream *)liveAudioStream
{
  if (!_liveAudioStream) {
    NSURL *url = [NSURL URLWithString:WEFM_URL];
    _liveAudioStream = [[LiveAudioStream alloc] initWithURL:url];
  }
  return _liveAudioStream;
}

#pragma mark Actions

- (IBAction)play:(id)sender {
  [self.liveAudioStream play];
}

- (IBAction)pause:(id)sender {
  [self.liveAudioStream pause];
}

@end

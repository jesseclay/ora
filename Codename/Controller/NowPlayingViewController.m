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

#define REUSE_IDENTIFIER @"CoverArt"
#define COVER_ART_QUEUE   "CoverArtNetworkQueue"


@interface NowPlayingViewController () <UICollectionViewDataSource>

@property (strong, nonatomic)LiveAudioStream *liveAudioStream;
@property (strong, nonatomic)NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic)NSArray *metadataHistory;
@property (weak, nonatomic) IBOutlet UICollectionView *coverArtCollectionView;
@end

@implementation NowPlayingViewController

#pragma mark managed object context

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    // Custom initialization
  }
  return self;
}

#pragma mark Lifecycle

- (void)viewDidLoad
{
  [super viewDidLoad];
  [ORACoreDataManager sharedManagedObjectContext:^(NSManagedObjectContext *c) {
    self.managedObjectContext = c;
    [CSRDSCoreDataConnector fetchAndUpdateCoreDataMetadata:^(BOOL success) {
      if (success) {
        self.metadataHistory = [CSRDSCoreDataConnector metadataWithContext:c];
        [self syncUI];
      }
    }];
  }];
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

- (void)refresh
{
  self.navigationController.title = @"hi";
}

#pragma mark UI


- (void)syncUI
{
  [self.coverArtCollectionView reloadData];
}


#pragma mark UICollectionView Data Source - Helpers

- (void)setCell:(CoverArtCollectionViewCell *)cell withArtFromMetadata:(Metadata *)metadata
{
  NSURL *url = [[NSURL alloc] initWithString:metadata.artURLStringMedium];
  dispatch_queue_t q = dispatch_queue_create(COVER_ART_QUEUE, NULL);
  dispatch_async(q, ^{
    NSData *data = [[NSData alloc] initWithContentsOfURL:url];
    
    dispatch_async(dispatch_get_main_queue(), ^{
      cell.coverArtView.image = [[UIImage alloc] initWithData:data];
    });
  });
  
}


#pragma mark UICollectionView Data Source


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
  UICollectionViewCell *cell = [self.coverArtCollectionView
                                dequeueReusableCellWithReuseIdentifier:REUSE_IDENTIFIER
                                forIndexPath:indexPath];
  
  if ([cell isKindOfClass:[CoverArtCollectionViewCell class]]) {
    
    CoverArtCollectionViewCell *artCell = (CoverArtCollectionViewCell *) cell;
    Metadata *metadata = [self.metadataHistory objectAtIndex:indexPath.item];
    // get metadata entry
    
    [self setCell:artCell withArtFromMetadata:metadata];
  }
  return cell;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section
{
  return self.metadataHistory ? [self.metadataHistory count] : 0;
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
  return 1;
}


@end
//
//  ArtCollectionViewController.m
//  ORA
//
//  Created by Brian Holder-Chow Lin On on 3/17/13.
//  Copyright (c) 2013 CS193p. All rights reserved.
//

#import "ArtCollectionViewController.h"


#import "CSRDSCoreDataConnector.h"
#import "ORACoreDataManager.h"
#import "CoverArtCollectionViewCell.h"
#import "CachedImage.h"
#define REUSE_IDENTIFIER @"CoverArt"
#define COVER_ART_QUEUE   "CoverArtNetworkQueue"

#define NSLOG_NPVC NO



@interface ArtCollectionViewController ()

@property (strong, nonatomic)NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic)NSArray *metadataHistory;
@property (weak, nonatomic) IBOutlet UICollectionView *coverArtCollectionView;

@end

@implementation ArtCollectionViewController
//
//  NowPlayingViewController.m
//  ORA
//
//  Created by Brian Holder-Chow Lin On on 2/19/13.
//  Copyright (c) 2013 CS193p. All rights reserved.
//



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


#pragma mark UI


- (void)syncUI
{
  [self.coverArtCollectionView reloadData];
}

#pragma mark Gestures


#pragma mark UICollectionView Data Source - Helpers

- (void)setCell:(CoverArtCollectionViewCell *)cell withArtFromMetadata:(Metadata *)metadata
{
  NSURL *url = [[NSURL alloc] initWithString:metadata.artURLStringMedium];
  dispatch_queue_t q = dispatch_queue_create(COVER_ART_QUEUE, NULL);
  CoverArtView *artView = cell.coverArtView;
  
  dispatch_async(q, ^{
  
    UIImage *image = [CachedImage imageWithURL:url];
    
    dispatch_async(dispatch_get_main_queue(), ^{
      artView.image = image;
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
    
    if (NSLOG_NPVC) {
      NSLog(@"loading position: %d (%@)", indexPath.item, metadata.artiste);
    }
    
    
    // get metadata entry
    
    [self setCell:artCell withArtFromMetadata:metadata];
  }
  return cell;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section
{
  if (NSLOG_NPVC) {
    NSLog(@"number of metadatas: %d", [self.metadataHistory count]);
  }
  
  return self.metadataHistory ? [self.metadataHistory count] : 0;
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
  return 1;
}

@end

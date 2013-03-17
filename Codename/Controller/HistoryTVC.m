//
//  HistoryTVC.m
//  ORA
//
//  Created by Brian Holder-Chow Lin On on 3/11/13.
//  Copyright (c) 2013 CS193p. All rights reserved.
//

#import "HistoryTVC.h"
#import "ORACoreDataManager.h"
#import "Metadata.h"
#import "CSRDSCoreDataConnector.h"
#import "CachedImage.h"

#define TITLE     @"History"
#define REUSE_ID  @"HistoryItemCell"
#define QUEUE     "NetworkQueue"

@interface HistoryTVC ()
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@end

@implementation HistoryTVC

- (void)setManagedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
  _managedObjectContext = managedObjectContext;
  if (managedObjectContext) {
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Metadata"];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"datetime" ascending:NO selector:@selector(compare:)]];
    
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                                                        managedObjectContext:managedObjectContext
                                                                          sectionNameKeyPath:nil
                                                                                   cacheName:nil];
    
  } else {
    
    self.fetchedResultsController = nil;
    
  }
}


#pragma mark - UITableViewDataSource


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:REUSE_ID];
  
  Metadata *metadata = [self.fetchedResultsController objectAtIndexPath:indexPath];
  cell.textLabel.text = metadata.title;
  cell.detailTextLabel.text = metadata.artiste;
  NSURL *url = [[NSURL alloc] initWithString:metadata.artURLStringMedium];
  cell.imageView.image = [CachedImage imageWithURL:url];
  
  /**
   disable segue if amazon link is not present
   */
  if ([metadata.amznUrlString isEqualToString:@""]) {
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.userInteractionEnabled = NO;
  } else {
    // TODO set accessory view
  }

  return cell;
}


#pragma mark Lifecycle

- (void)viewDidLoad
{
  [super viewDidLoad];
  [self setupRefresh];
  self.title = TITLE;
  self.navigationItem.title = TITLE;
  [ORACoreDataManager sharedManagedObjectContext:^(NSManagedObjectContext *context) {
    self.managedObjectContext = context;
    [self refresh];
  }];
}

#pragma mark Refreshing


- (void)setupRefresh
{
  [self.refreshControl addTarget:self
                          action:@selector(refresh)
                forControlEvents:UIControlEventValueChanged];
}


- (void)refresh
{
  [self.refreshControl beginRefreshing];
  [CSRDSCoreDataConnector fetchAndUpdateCoreDataMetadata:^(BOOL success) {
    [self.refreshControl endRefreshing];
  }];
}

#pragma mark Segues


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
  NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
  Metadata *metadata = [self.fetchedResultsController objectAtIndexPath:indexPath];
  
  if ([segue.destinationViewController respondsToSelector:@selector(setUrl:)]) {
    NSURL *url = [[NSURL alloc] initWithString:metadata.amznUrlString];
    [segue.destinationViewController performSelector:@selector(setUrl:)
                                          withObject:url];
    [segue.destinationViewController setTitle:metadata.title];
  }
}


@end

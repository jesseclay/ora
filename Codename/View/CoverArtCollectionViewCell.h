//
//  CoverArtCollectionViewCell.h
//  ORA
//
//  Created by Brian Holder-Chow Lin On on 3/9/13.
//  Copyright (c) 2013 CS193p. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoverArtView.h"

@interface CoverArtCollectionViewCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet CoverArtView *coverArtView;
@end

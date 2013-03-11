//
//  CoverArtCollectionViewCell.m
//  ORA
//
//  Created by Brian Holder-Chow Lin On on 3/9/13.
//  Copyright (c) 2013 CS193p. All rights reserved.
//

#import "CoverArtCollectionViewCell.h"

@interface CoverArtCollectionViewCell ()

@end

@implementation CoverArtCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)prepareForReuse
{
  [super prepareForReuse];
  
  for (UIView *subView in self.coverArtView.subviews) {
    [subView removeFromSuperview];
  }
}

@end

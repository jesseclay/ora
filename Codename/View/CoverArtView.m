//
//  CoverArtView.m
//  ORA
//
//  Created by Brian Holder-Chow Lin On on 3/9/13.
//  Copyright (c) 2013 CS193p. All rights reserved.
//

#import "CoverArtView.h"

@implementation CoverArtView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

#pragma mark Image

- (void)setImage:(UIImage *)image
{
  _image = image;
  if (image) {
    UIImageView *iv = [[UIImageView alloc] initWithImage:image];
    
    CGFloat ratio = iv.bounds.size.height / iv.bounds.size.width;
    CGFloat newHeight = ratio * self.frame.size.width;
    
    iv.frame = CGRectMake(0, 0, self.frame.size.width, newHeight);
    [self addSubview:iv];
  }
}

@end

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
  UIImageView *iv = [[UIImageView alloc] initWithImage:image];
  [self addSubview:iv];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end

//
//  UIBuyButton.m
//  ORA
//
//  Created by Brian Holder-Chow Lin On on 3/17/13.
//  Copyright (c) 2013 CS193p. All rights reserved.
//

#import "UIBuyButton.h"
#import <QuartzCore/QuartzCore.h>

#define WIDTH         40
#define HEIGHT        25
#define CORNER_RADIUS 7
#define FONT_SIZE     13
#define TEXT          @"Buy"
#define FONT_NAME     @"Helvetica-Bold"

@interface UIBuyButton ()
@property (strong,nonatomic) CAGradientLayer *backgroundLayer, *highlightBackgroundLayer;
@property (strong,nonatomic) CALayer *innerGlow;
@end

@implementation UIBuyButton

- (id)init
{
  self = [super init];
  
  if (self) {
    self.frame = CGRectMake(0, 0, WIDTH, HEIGHT);
    
    [self drawText];
    [self drawButton];
//    [self drawInnerGlow];
    [self drawBackgroundLayer];
//    [self drawHighlightBackgroundLayer];
    
    self.highlightBackgroundLayer.hidden = YES;
  }
  
  return self;
}

- (void)drawText
{
  [self setTitle:TEXT forState:UIControlStateNormal];
  self.titleLabel.font = [UIFont fontWithName:FONT_NAME size:FONT_SIZE];
  [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
  [self.titleLabel setShadowColor:[UIColor grayColor]];
  self.titleLabel.shadowOffset = CGSizeMake(-1, -1);
}


- (void)drawButton
{
  // Get the root layer (any UIView subclass comes with one)
  CALayer *layer = self.layer;
  
  layer.cornerRadius = CORNER_RADIUS;
  layer.borderWidth = 0;
  layer.borderColor = [UIColor blackColor].CGColor;
}

- (void)drawInnerGlow
{
  // Instantiate the innerGlow layer
  
  
  self.innerGlow.cornerRadius= CORNER_RADIUS;
  self.innerGlow.borderWidth = 1;
  self.innerGlow.borderColor = [[UIColor whiteColor] CGColor];
  self.innerGlow.opacity = 0.1;
  
  [self.layer insertSublayer:self.innerGlow atIndex:2];
}


- (void)drawBackgroundLayer
{
  // Set the colors
  self.backgroundLayer.colors = (@[
                            (id)[UIColor colorWithRed:60/255.0 green:148/255.0 blue:185/255.0 alpha:1].CGColor,
                            (id)[UIColor colorWithRed:36/255.0 green:87/255.0 blue:136/255.0 alpha:1].CGColor
                            ]);
  
  // Set the stops
  self.backgroundLayer.locations = (@[
                               @0.0f,
                               @1.0f
                               ]);
  
  
  // Set corner radius
  self.backgroundLayer.cornerRadius = CORNER_RADIUS;
  
  // Add the gradient to the layer hierarchy
  [self.layer insertSublayer:self.backgroundLayer atIndex:0];

}

- (void)drawHighlightBackgroundLayer
{
  
}

- (void)setHighlighted:(BOOL)highlighted
{
  // Hide/show inverted gradient
  _highlightBackgroundLayer.hidden = !highlighted;
  
  [super setHighlighted:highlighted];
}


- (void)layoutSubviews
{
  // Set inner glow frame (1pt inset)
  self.innerGlow.frame = CGRectInset(self.bounds, 1, 1);
  
  // Set gradient frame (fill the whole button))
  self.backgroundLayer.frame = self.bounds;
  
  // Set inverted gradient frame
  self.highlightBackgroundLayer.frame = self.bounds;
  
  [super layoutSubviews];
}

- (CALayer *)innerGlow
{
  if (!_innerGlow) _innerGlow = [CALayer layer];
  return _innerGlow;
}


- (CAGradientLayer *)backgroundLayer
{
  if (!_backgroundLayer) _backgroundLayer = [CAGradientLayer layer];
  return _backgroundLayer;
}

+ (UIBuyButton *)buttonWithType:(UIButtonType)type
{
  return [super buttonWithType:UIButtonTypeCustom];
}


@end

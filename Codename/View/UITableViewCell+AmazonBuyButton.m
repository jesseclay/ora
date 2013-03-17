//
//  UITableViewCell+BuyButton.m
//  ORA
//
//  Created by Brian Holder-Chow Lin On on 3/17/13.
//  Copyright (c) 2013 CS193p. All rights reserved.
//

#import "UITableViewCell+AmazonBuyButton.h"
#import "UIBuyButton.h"

@implementation UITableViewCell (AmazonBuyButton)

- (void)showBuyButton:(BOOL)show
{
  if (show) {
    UIBuyButton *btn = [[UIBuyButton alloc] init];
    self.accessoryView = btn;
  } else {
    self.accessoryView = nil;
    self.accessoryType = UITableViewCellAccessoryNone;
    self.userInteractionEnabled = NO;
  }
}


@end

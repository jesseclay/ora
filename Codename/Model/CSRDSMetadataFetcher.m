//
//  MetadataFetcher.m
//  ORA
//
//  Created by Brian Holder-Chow Lin On on 3/8/13.
//  Copyright (c) 2013 CS193p. All rights reserved.
//

#import "CSRDSMetadataFetcher.h"
#import "NetworkActivityIndicator.h"

#define ENDPOINT_URL_STRING @"http://star947tt.com/sites/all/modules/csrds/csrds_now_playing.php"

@implementation CSRDSMetadataFetcher


// communicates with server using HTTP; we receive JSON
+ (NSDictionary *)data
{
  NSData *jsonData = [[self class] jsonData];
  NSError *error = nil;
  NSDictionary *results = jsonData ? [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers|NSJSONReadingMutableLeaves error:&error] : nil;
  return results;
}

#pragma mark private
+ (NSData *)jsonData
{
  [NetworkActivityIndicator show];

  NSData *jsonData = [[NSString stringWithContentsOfURL:[NSURL URLWithString:ENDPOINT_URL_STRING]
                                               encoding:NSUTF8StringEncoding error:nil]
                      dataUsingEncoding:NSUTF8StringEncoding];
  [NetworkActivityIndicator hide];
  return jsonData;
}
@end

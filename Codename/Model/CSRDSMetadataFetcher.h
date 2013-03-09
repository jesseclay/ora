//
//  MetadataFetcher.h
//  ORA
//
//  Created by Brian Holder-Chow Lin On on 3/8/13.
//  Copyright (c) 2013 CS193p. All rights reserved.
//

#import <Foundation/Foundation.h>

#define MD_NOW_TYPE             @"csrds_now_type"
#define MD_NOW_TITLE            @"csrds_now_title"
#define MD_NOW_ARTISTE          @"csrds_now_artist"
#define MD_NOW_URL_COVER_MED    @"csrds_now_coverurl_large"
#define MD_NOW_URL_COVER_LARGE  @"csrds_now_coverurl_medium"

#define MD_TYPE_SONG  @"Song"
#define MD_TYPE_SEGUE @"Segue"
#define MD_TYPE_SPOT  @"Spot"

@interface CSRDSMetadataFetcher : NSObject

+ (NSDictionary *)data; // blocking network call

@end

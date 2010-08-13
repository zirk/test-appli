//
//  AUMCache.h
//  iAUM
//
//  Created by Dirk Amadori on 12/08/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface AUMCache : NSObject {
	UIImageView* imageView;
}

@property (nonatomic, retain) UIImageView* imageView;

- (id) init;
- (void) loadImage:(NSString*)urlString forImageView:(UIImageView*)someImageView;
- (void) imageDownloaded:(NSString*)urlString;

@end

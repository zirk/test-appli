//
//  AUMCache.h
//  iAUM
//
//  Created by dirk on 12/08/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface iAUMCache : NSObject {
	id object;
	NSMutableDictionary* memCache;
}

@property (nonatomic, retain) id object;
@property (nonatomic, retain) NSMutableDictionary* memCache;

- (id) init;
- (void) loadImage:(NSString*)urlString forObject:(id)someObject;
- (void) imageDownloaded:(NSString*)urlString;

@end

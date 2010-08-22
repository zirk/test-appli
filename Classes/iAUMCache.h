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
	NSString* imageCachePath;
}

@property (nonatomic, retain) id object;
@property (nonatomic, retain) NSString* imageCachePath;

- (id) init;
- (void) loadImage:(NSString*)urlString forObject:(id)someObject;
- (void) downloadImage:(NSString*)urlString;

+ (BOOL) initCache;
+ (NSString*) cachePath:(NSString *)subPath;
+ (unsigned long long int) cacheSize:(NSString *)subPath;
+ (BOOL) clearCache:(NSString *)subPath removeSubFolders:(BOOL)removeSubFolders;

@end

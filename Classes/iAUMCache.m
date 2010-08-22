//
//  AUMCache.m
//  iAUM
//
//  Created by dirk on 12/08/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "iAUMTools.h"
#import "iAUMCache.h"
#import "iAUMConstants.h"

@implementation iAUMCache

@synthesize object, imageCachePath;

/**
 VOIR NSCache
 */

-(id)init {
	if (self = [super init]) {
		self.object = nil;
		self.imageCachePath = [iAUMCache cachePath:kAppCachePathImages];
	}
	return self;
}

+ (BOOL) initCache
{
	BOOL result = YES;
	NSError* error = [[NSError alloc] init];
	//create all folders n shit
	NSFileManager* fileManager = [NSFileManager defaultManager];
	result = [fileManager createDirectoryAtPath:[iAUMCache cachePath:kAppCachePathImages] withIntermediateDirectories:YES attributes:nil error:&error];
	[error release];
	return result;
}

+ (NSString*) cachePath:(NSString*)subPath
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	documentsDirectory = [documentsDirectory stringByAppendingPathComponent:kAppCachePath];
	if (subPath != nil)
		return [documentsDirectory stringByAppendingPathComponent:subPath];
	return documentsDirectory;
}

+ (BOOL) clearCache:(NSString*)subPath removeSubFolders:(BOOL)removeSubFolders
{
	BOOL result = YES;
	NSError* error = [[NSError alloc] init];
	NSFileManager* fileManager = [NSFileManager defaultManager];
	NSString* cachePath = [iAUMCache cachePath:subPath];
	NSArray* files = [fileManager subpathsOfDirectoryAtPath:cachePath error:&error];
	if (files == nil) {
		[error release];
		return 0;
	}

	for (NSString* file in files) {
		file = [cachePath stringByAppendingPathComponent:file];
		NSDictionary* attributes = [fileManager attributesOfItemAtPath:file error:&error];
		if (attributes == nil) {
			result = NO;
			continue ;
		}
		if ([attributes objectForKey:NSFileType] == NSFileTypeRegular)
			result = [fileManager removeItemAtPath:file error:&error];
		else if ([attributes objectForKey:NSFileType] == NSFileTypeDirectory && removeSubFolders == YES)
			result = [fileManager removeItemAtPath:file error:&error];
	}
	[error release];
	return result;
}

+ (unsigned long long int) cacheSize:(NSString*)subPath
{
	unsigned long long int totalSize = 0;
	NSError* error = [[NSError alloc] init];
	NSFileManager* fileManager = [NSFileManager defaultManager];
	NSString* cachePath = [iAUMCache cachePath:subPath];
	NSArray* files = [fileManager subpathsOfDirectoryAtPath:cachePath error:&error];
	if (files == nil) {
		[error release];
		return 0;
	}

	for (NSString* file in files) {
		NSDictionary* attributes = [fileManager attributesOfItemAtPath:[cachePath stringByAppendingPathComponent:file] error:&error];
		if (attributes != nil && [attributes objectForKey:NSFileType] == NSFileTypeRegular) {
			NSNumber* fileSize = [attributes objectForKey:NSFileSize];
			totalSize += [fileSize unsignedLongLongValue];
		}
	}
	[error release];
	return totalSize;
}

- (void) loadImage:(NSString*)urlString forObject:(id)someObject
{
	self.object = someObject;
	
	NSString* imageFile = [self.imageCachePath stringByAppendingPathComponent:[iAUMTools hashMD5:urlString]];
	UIImage* image = [UIImage imageWithContentsOfFile:imageFile];

	if (image == nil){
		//NSLog(@"image [%@] not in disk cache, downloading", urlString);
		[iAUMTools queueOperation:@selector(downloadImage:) withTarget:self withObject:urlString];
	}
	else{
		[self.object setImage:image];
	}
}


-(void) downloadImage:(NSString*)urlString
{
	NSData* imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
	UIImage* image = [UIImage imageWithData:imageData];
	NSString* imageFile = [self.imageCachePath stringByAppendingPathComponent:[iAUMTools hashMD5:urlString]];

	[imageData writeToFile:imageFile atomically:YES];
	[self.object performSelectorOnMainThread:@selector(setImage:) withObject:image waitUntilDone:NO];
}

- (void) dealloc
{
	[self.object release];
	[self.imageCachePath release];
	[super dealloc];
}

@end

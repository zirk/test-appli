//
//  AUMCache.m
//  iAUM
//
//  Created by dirk on 12/08/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "iAUMTools.h"
#import "iAUMCache.h"

@implementation iAUMCache

@synthesize object, memCache;

-(id)init {
	if (self = [super init]) {
		self.object = nil;
		self.memCache = [[NSMutableDictionary alloc] init];
		[self.memCache release];
	}
	return self;
}

- (void) loadImage:(NSString*)urlString forObject:(id)someObject
{
	UIImage* image = [UIImage imageWithData:[self.memCache objectForKey:[iAUMTools hashMD5:urlString]]];
	self.object = someObject;
	if (image == nil) {
		NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
		NSString *documentsDirectory = [paths objectAtIndex:0];
		NSString *imageFile = [documentsDirectory stringByAppendingPathComponent:[iAUMTools hashMD5:urlString]];
		image = [UIImage imageWithContentsOfFile:imageFile];
	}
	if (image == nil){
		[iAUMTools queueOperation:@selector(imageDownloaded:) withTarget:self withObject:urlString];
	}
	else{
		[self.object setImage:image];
		[self.memCache setObject:image forKey:[iAUMTools hashMD5:urlString]];
	}
}


-(void) imageDownloaded:(NSString*)urlString
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	
	NSData* imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
	UIImage* image = [UIImage imageWithData:imageData];
	//[imageData writeToFile:[iAUMTools hashMD5:urlString] atomically:YES];
	// the path to write file
	NSString *imageFile = [documentsDirectory stringByAppendingPathComponent:[iAUMTools hashMD5:urlString]];
	
	[imageData writeToFile:imageFile atomically:YES];
	[self.memCache setObject:image forKey:[iAUMTools hashMD5:urlString]];	
	[self.object performSelectorOnMainThread:@selector(setImage:) withObject:image waitUntilDone:NO];
}

- (void) dealloc
{
	[self.object release];
	[self.memCache release];
	[super dealloc];
}

@end

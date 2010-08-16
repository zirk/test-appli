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

@synthesize object;

-(id)init {
	if (self = [super init]) {
		self.object = nil;
	}
	return self;
}

- (void) loadImage:(NSString*)urlString forObject:(id)someObject
{
	self.object = someObject;
	
	UIImage* image = nil;
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *imageFile = [documentsDirectory stringByAppendingPathComponent:[iAUMTools hashMD5:urlString]];
	image = [UIImage imageWithContentsOfFile:imageFile];

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
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	
	NSData* imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
	UIImage* image = [UIImage imageWithData:imageData];
	//[imageData writeToFile:[iAUMTools hashMD5:urlString] atomically:YES];
	// the path to write file
	NSString *imageFile = [documentsDirectory stringByAppendingPathComponent:[iAUMTools hashMD5:urlString]];
	
	[imageData writeToFile:imageFile atomically:YES];
	[self.object performSelectorOnMainThread:@selector(setImage:) withObject:image waitUntilDone:NO];
}

- (void) dealloc
{
	[self.object release];
	[super dealloc];
}

@end

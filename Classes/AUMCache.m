//
//  AUMCache.m
//  iAUM
//
//  Created by Dirk Amadori on 12/08/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AumTools.h"
#import "AUMCache.h"


@implementation AUMCache

@synthesize imageView;

-(id)init {
	if (self = [super init]) {
		self.imageView = nil;
	}
	return self;
}

- (void) loadImage:(NSString*)urlString forImageView:(UIImageView *)someImageView
{
	self.imageView = someImageView;
	self.imageView.image = [UIImage imageWithContentsOfFile:[AumTools hashMD5:urlString]];
	if (self.imageView.image == nil){
		[AumTools queueOperation:@selector(imageDownloaded:) withTarget:self withObject:urlString];
	}
}


-(void) imageDownloaded:(NSString*)urlString
{
	NSLog(@"loading image @ %@, hash %@", urlString, [AumTools hashMD5:urlString]);
	NSData* imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
	UIImage* image = [UIImage imageWithData:imageData];
	[imageData writeToFile:[AumTools hashMD5:urlString] atomically:YES];
	[self.imageView performSelectorOnMainThread:@selector(setImage:) withObject:image waitUntilDone:NO];
}

@end

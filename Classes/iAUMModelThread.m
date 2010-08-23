//
//  iAUMModelThread.m
//  iAUM
//
//  Created by John Doe on 22/08/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "iAUMModelThread.h"


@implementation iAUMModelThread

@synthesize status, threadId, preview, date, contact;

- (id) init {
	if ((self = [super init])) {
		self.status = iAUMThreadStatusUnknown;
		self.threadId = nil;
		self.preview = nil;
		self.date = nil;
		self.contact = nil;
	}
	return self;
}

- (id) initWithDictionary:(NSDictionary*)dico
{
	if ((self = [self init])) {
		self.status = [[dico objectForKey:@"status"] intValue];
		self.preview = [dico objectForKey:@"preview"];
		self.threadId = [dico objectForKey:@"id"];
		self.date = [dico objectForKey:@"time"];
		self.contact = [[iAUMModelMiniProfile alloc] initWithDictionary:[dico objectForKey:@"contact"]];
		[self.contact release];
	}
	return self;
}

- (void) dealloc {
	[self.threadId release];
	[self.preview release];
	[self.date release];
	[self.contact release];
	[super dealloc];
}

@end

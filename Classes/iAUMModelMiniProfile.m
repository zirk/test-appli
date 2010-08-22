//
//  iAUMMiniProfile.m
//  iAUM
//
//  Created by John Doe on 22/08/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "iAUMModelMiniProfile.h"


@implementation iAUMModelMiniProfile

@synthesize age, name, city, aumId, pictureUrl, online;

- (id) init {
	if ((self = [super init])) {
		self.age = nil;
		self.name = nil;
		self.city = nil;
		self.aumId = nil;
		self.pictureUrl = nil;
		self.online = NO;
	}
	return self;
}

- (id) initWithDictionary:(NSDictionary*)dico
{
	if ((self = [self init])) {
		self.age = [dico objectForKey:@"age"];
		self.name = [dico objectForKey:@"name"];
		self.city = [dico objectForKey:@"city"];
		self.pictureUrl = [dico objectForKey:@"pictureUrl"];
		self.aumId = [dico objectForKey:@"aumId"];
		self.online = [[dico objectForKey:@"online"] boolValue];
	}
	return self;
}

- (void) dealloc {
	[self.age release];
	[self.name release];
	[self.city release];
	[self.aumId release];
	[self.pictureUrl release];
	[super dealloc];
}

@end

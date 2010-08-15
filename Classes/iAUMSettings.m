//
//  AUMSettings.m
//  iAUM
//
//  Created by dirk on 11/08/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "iAUMSettings.h"


@implementation iAUMSettings

+ (void) set:(NSString*)key withValue:(NSString*)value
{
	NSLog(@"saving %@ : [%@]", key, value);
	[[NSUserDefaults standardUserDefaults] setObject:value forKey:key];
}

+ (NSString*) get:(NSString*)key;
{
	NSLog(@"getting %@ : [%@]", key, [[NSUserDefaults standardUserDefaults] stringForKey:key]);
	return [[NSUserDefaults standardUserDefaults] stringForKey:key];
}

@end

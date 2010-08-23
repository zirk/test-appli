//
//  AUMSettings.m
//  iAUM
//
//  Created by dirk on 11/08/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "iAUMSettings.h"
#import "iAUMConstants.h"

@implementation iAUMSettings

+ (void) set:(NSString*)key withValue:(id)value
{
	NSLog(@"saving %@ : [%@]", key, value);
	[[NSUserDefaults standardUserDefaults] setObject:value forKey:key];
}

+ (NSString*) get:(NSString*)key
{
	NSLog(@"getting %@ : [%@]", key, [[NSUserDefaults standardUserDefaults] stringForKey:key]);
	return [[NSUserDefaults standardUserDefaults] stringForKey:key];
}

+ (id) apiConfig:(NSString*)key
{
	if (key == nil)
		return nil;
	NSDictionary* apiConfig = [[NSUserDefaults standardUserDefaults] dictionaryForKey:kAppSettingsApiConfig];
	if (apiConfig == nil || apiConfig.count < 1) {
		apiConfig = [NSDictionary dictionaryWithObjectsAndKeys:
						@"0", kAppSettingsApiConfigVersion, 
						kApiHost, kAppSettingsApiConfigHost,
						@"", kAppSettingsApiConfigActionUpdate,
						nil];
		[[NSUserDefaults standardUserDefaults] setObject:apiConfig forKey:kAppSettingsApiConfig];
	}
	NSLog(@"API CONFIG GET : %@ => %@", key, [apiConfig objectForKey:key]);
	return [apiConfig objectForKey:key];
}

@end

//
//  NSSortableDictionary.m
//  iAUM
//
//  Created by Dirk Amadori on 8/08/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AumTools.h"

@implementation AumTools

+(NSMutableArray*) getSortedKeysWithDictionary:(NSDictionary *)originalDico
{
	NSMutableArray* keys = [NSMutableArray arrayWithArray:[originalDico allKeys]];
	
	for (int i = 0; i < [keys count]; ++i) {
		for (int j = 0; j < [keys count] - i - 1; ++j) {
			if (strcmp([[keys objectAtIndex:j] cString], [[keys objectAtIndex:j + 1] cString]) > 0){
				[keys exchangeObjectAtIndex:j withObjectAtIndex:j+1];
			}
		}
	}
	
	return keys;
}

+(NSString*) serializeDictionary:(NSDictionary*) dico withKeys:(NSArray*) keys
{
	NSMutableString* paramString = [[NSMutableString alloc] init];
	for (NSString* key in (keys == nil ? [dico allKeys] : keys)) {
		[paramString appendFormat:@"&%@=%@", key, [dico valueForKey:key]];
	}
	return paramString;
}

@end



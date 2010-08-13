//
//  NSSortableDictionary.m
//  iAUM
//
//  Created by Dirk Amadori on 8/08/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <CommonCrypto/CommonDigest.h>
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
	NSString* result = [NSString stringWithString:paramString];
	[paramString release];
	return result;
}


+(NSString*) hashMD5:(NSString*)data
{
	unsigned char digest[CC_MD5_DIGEST_LENGTH] = {0};

	CC_MD5([data UTF8String], [data length], digest);
	NSMutableString* tmp = [[NSMutableString alloc] init];

	for (int i = 0; i < CC_MD5_DIGEST_LENGTH; ++i) {
		[tmp appendFormat:@"%02x", digest[i]];
	}

	NSString* hash = [NSString stringWithString:tmp];
	[tmp release];
	return hash;
}

+(void)queueOperation:(SEL)selector withTarget:(id)target withObject:(id)object
{
	NSLog(@"queuing operation");
	NSInvocationOperation* op = [[NSInvocationOperation alloc] initWithTarget:target selector:selector object:object];
	NSLog(@"1");
	NSOperationQueue* queue = [[[NSOperationQueue alloc] init] autorelease];
	NSLog(@"2");
	[queue addOperation:op];
	NSLog(@"3");
	[op release];
	NSLog(@"operation queued");
}

@end



//
//  NSSortableDictionary.m
//  iAUM
//
//  Created by dirk on 8/08/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonHMAC.h>
#import "iAUMTools.h"
#import "iAUMConstants.h"

@implementation iAUMTools

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

+(NSString*) hashSHA1:(NSString*)data
{
	unsigned char digest[CC_SHA1_DIGEST_LENGTH] = {0};

	CCHmacContext hctx;
	CCHmacInit(&hctx, kCCHmacAlgSHA1, kApiPrivateKey, strlen(kApiPrivateKey));
	CCHmacUpdate(&hctx, [data UTF8String], [data length]);
	CCHmacFinal(&hctx, digest);
	NSMutableString* tmp = [[NSMutableString alloc] init];
	
	for (int i = 0; i < CC_SHA1_DIGEST_LENGTH; ++i) {
		[tmp appendFormat:@"%02x", digest[i]];
	}
	NSString* hash = [NSString stringWithString:tmp];
	[tmp release];
	return hash;
}

+(void)queueOperation:(SEL)selector withTarget:(id)target withObject:(id)object
{
	NSInvocationOperation* op = [[NSInvocationOperation alloc] initWithTarget:target selector:selector object:object];
	NSOperationQueue* queue = [[[NSOperationQueue alloc] init] autorelease];
	[queue addOperation:op];
	[op release];
}

+(BOOL) isValidAumId:(NSString*)aumId
{
	if (aumId == nil || aumId.length < 1)
		return NO;
	if ([aumId characterAtIndex:0] != '1' && [aumId characterAtIndex:0] != '2')
		return NO;
	return YES;
}

+(NSUInteger) getUsersSex:(NSString*)aumId
{
	if ([iAUMTools isValidAumId:aumId] == NO)
		return iAUMUserSexUnknown;
	if ([aumId characterAtIndex:0] == '2')
		return iAUMUserSexMale;
	if ([aumId characterAtIndex:0] == '1')
		return iAUMUserSexFemale;
	return iAUMUserSexUnknown;
}

+(BOOL) isValidEmail:(NSString*)email
{
    NSString *emailRegEx =
    @"(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"
    @"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"
    @"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"
    @"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"
    @"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"
    @"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"
    @"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])";

    NSPredicate *regExPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
	return ([regExPredicate evaluateWithObject:[email lowercaseString]]);
}

@end



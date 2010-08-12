//
//  HttpRequest.m
//  iAUM
//
//  Created by dirk on 8/08/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "HttpRequest.h"
#import "AumTools.h"
#import <CommonCrypto/CommonHMAC.h>
#import "JSON/JSON.h"


@implementation HttpRequest
@synthesize login, password, signature, url, method, params, response;

-(id) init
{
	if(self = [super init]){
		self.params = [[NSMutableDictionary alloc] init];
		self.method = @"POST";
		self.url = @"/";
		self.response = nil;
	}
	return self;
}

-(id) initWithUrl:(NSString*) URL
{
	if(self = [self init]){
		self.url = URL;
	}
	return self;
}


-(void) addParam:(NSString*) name value:(NSString*) value
{
	[self.params setObject:value forKey:name];
}

-(void) resetParams
{
	[self.params removeAllObjects];
}

-(NSString*) sign
{
	unsigned char digest[CC_SHA1_DIGEST_LENGTH] = {0};

	[self addParam:@"email" value:self.login];
	[self addParam:@"password" value:self.password];
	
	NSString* paramString = [AumTools serializeDictionary:self.params withKeys:[AumTools getSortedKeysWithDictionary:self.params]];
	
	CCHmacContext hctx;
	CCHmacInit(&hctx, kCCHmacAlgSHA1, PRIVATE_KEY, strlen(PRIVATE_KEY));
	CCHmacUpdate(&hctx, [paramString UTF8String], [paramString length]);
	CCHmacFinal(&hctx, digest);
	NSMutableString* tmp = [[NSMutableString alloc] init];
	
	for (int i = 0; i < CC_SHA1_DIGEST_LENGTH; ++i) {
		[tmp appendFormat:@"%02x", digest[i]];
	}
	
	self.signature = [NSString stringWithString:tmp];
	[tmp release];
	[paramString release];
	return self.signature;
}

-(BOOL) send
{
	//prepar request
	NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
	[request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", API_URL, self.url]]];
	[request setHTTPMethod:self.method];
	
	//set headers
	[request addValue:self.signature forHTTPHeaderField:@"Authorization"];
	
	// TEMPORARY, REMOVE WHEN NECESSARY
	[self addParam:@"auth" value:self.signature];
	
	//create the body	
	NSMutableData *postBody = [NSMutableData data];
	[postBody appendData:[[AumTools serializeDictionary:self.params withKeys:nil] dataUsingEncoding:NSUTF8StringEncoding]];

	//post
	[request setHTTPBody:postBody];
	
	//get response
	NSHTTPURLResponse* urlResponse = nil;  
	NSError *error = [[NSError alloc] init];  
	NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];  
	NSString *result = [[[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding] autorelease];
	NSLog(@"Response Code: %d", [urlResponse statusCode]);
	if ([urlResponse statusCode] >= 200 && [urlResponse statusCode] < 300) {
		NSLog(@"Response: %@", result);
		self.response = [result JSONValue];
		NSLog(@"SOME RESPONSE FROM JSON %@", [self.response objectForKey:@"response"]);
		return YES;
	}
	
	return NO;
}
-(void) release
{
	[params release];
	[login release]; 
	[password release];
	[signature release];
	[url release];
	[method release];
	[params release];
	[response release];
}


@end

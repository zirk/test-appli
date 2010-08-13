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
#import "AUMSettings.h"
#import "iAUMConstants.h";

@implementation HttpRequest
@synthesize login, url, method, params, paramsTest, response;

-(id) init
{
	if(self = [super init]){
		NSMutableDictionary* someDico = [[NSMutableDictionary alloc] init];
		self.params = someDico;
		self.paramsTest = nil;//someDico;
	//	[someDico release];
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

	NSString* paramString = [AumTools serializeDictionary:self.params withKeys:[AumTools getSortedKeysWithDictionary:self.params]];
	
	CCHmacContext hctx;
	CCHmacInit(&hctx, kCCHmacAlgSHA1, PRIVATE_KEY, strlen(PRIVATE_KEY));
	CCHmacUpdate(&hctx, [paramString UTF8String], [paramString length]);
	CCHmacFinal(&hctx, digest);
	NSMutableString* tmp = [[NSMutableString alloc] init];

	for (int i = 0; i < CC_SHA1_DIGEST_LENGTH; ++i) {
		[tmp appendFormat:@"%02x", digest[i]];
	}
	NSString* signature = [NSString stringWithString:tmp];
	[tmp release];
	return signature;
}

-(BOOL) send
{	
	[self addParam:@"email" value:[AUMSettings get:kAppSettingsLogin]];
	[self addParam:@"password" value:[AUMSettings get:kAppSettingsPassword]];
	[self addParam:@"format" value:@"json"];

	NSString* signature = [self sign];
	
	//prepar request
	NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
	[request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", API_URL, self.url]]];
	[request setHTTPMethod:self.method];
	
	//set headers
	[request addValue:signature forHTTPHeaderField:@"Authorization"];
	
	// TEMPORARY, REMOVE WHEN NECESSARY
	[self addParam:@"auth" value:signature];
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
	[self resetParams];
	NSLog(@"Response Code: %d", [urlResponse statusCode]);
	if ([urlResponse statusCode] >= 200 && [urlResponse statusCode] < 300) {
		NSLog(@"Response: %@", result);
		
		self.response = [result JSONValue];
		NSLog(@"in send response: %d" , [response retainCount]);
		if([self.response isKindOfClass:[NSDictionary class]] == NO){
			self.response = nil;
			NSLog(@"rdgsdgdfsgfdc response: %d" , [response retainCount]);
			NSLog(@"rsponse was not a dictionary");
		}
		else {
			NSLog(@"SOME RESPONSE FROM JSON %@", [self.response objectForKey:@"response"]);
		}		
		return YES;
	}
	else {
		self.response = nil;
	}
	return NO;
}
-(void) release
{

	NSLog(@"rc params: %d" , [self.params retainCount]);
	NSLog(@"rc paramsTest: %d" , [self.paramsTest retainCount]);
	//NSLog(@"rc login: %d" , [self.login retainCount]);
	//NSLog(@"rc password: %d" , [password retainCount]);
	//NSLog(@"rc signature: %d" , [signature retainCount]);
	//NSLog(@"rc url: %d" , [url retainCount]);
	//NSLog(@"rc method: %d" , [method retainCount]);
	NSLog(@"rc response: %d" , [self.response retainCount]);
	//[self.login release]; 
	//[password release];
	//[signature release];
	
	[self.paramsTest release];
	[self.params release];
//	[params release];


	[self.response release];
}


@end

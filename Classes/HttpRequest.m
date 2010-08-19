//
//  HttpRequest.m
//  iAUM
//
//  Created by dirk on 8/08/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "HttpRequest.h"
#import "iAUMTools.h"
#import "JSON/JSON.h"
#import "iAUMSettings.h"
#import "iAUMConstants.h";

@implementation HttpRequest
@synthesize url, method, params, response;

-(id) init
{
	if(self = [super init]){
		NSMutableDictionary* someDico = [[NSMutableDictionary alloc] init];
		self.params = someDico;
		[someDico release];
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
	NSString* paramString = [iAUMTools serializeDictionary:self.params withKeys:[iAUMTools getSortedKeysWithDictionary:self.params]];
	return [iAUMTools hashSHA1:paramString];
}

-(BOOL) send
{
	if (![iAUMSettings get:kAppSettingsLogin])
		return NO;
	[self addParam:kApiLogin value:[iAUMSettings get:kAppSettingsLogin]];
	[self addParam:kApiPassword value:[iAUMSettings get:kAppSettingsPassword]];
	[self addParam:kApiFormat value:kApiFormatType];

	NSString* signature = [self sign];
	
	//prepar request
	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
	[request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", kApiHost, self.url]]];
	[request setHTTPMethod:self.method];
	
	//set headers
	[request addValue:signature forHTTPHeaderField:kApiAutorization];

	//create the body	
	NSMutableData *postBody = [NSMutableData data];
	[postBody appendData:[[iAUMTools serializeDictionary:self.params withKeys:nil] dataUsingEncoding:NSUTF8StringEncoding]];

	//post
	[request setHTTPBody:postBody];
	
	//get response
	NSHTTPURLResponse* urlResponse = nil;  
	NSError *error = [[NSError alloc] init];  
	NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
	NSString *result = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
	[self resetParams];
	NSLog(@"Response Code: %d => %@", [urlResponse statusCode], self.url);
	
	if ([urlResponse statusCode] >= 200 && [urlResponse statusCode] < 300) {
		NSLog(@"Response: %@", result);
		self.response = [result JSONValue];
		if([self.response isKindOfClass:[NSDictionary class]] == NO){
			self.response = nil;
			NSLog(@"rsponse was not a dictionary");
		}
		else {
			self.response = [self.response objectForKey:kApiResponse];
			NSLog(@"SOME RESPONSE FROM JSON %@", self.response);
		}
		[request release];
		[result release];
		[error release];
		return YES;
	}
	else {
		NSLog(@"FUCKING ERROR: %@", result);
		self.response = nil;
	}
	[request release];
	[error release];
	[result release];
	return NO;
}

- (void) dealloc
{
	[self.params release];
	[self.response release];
	[super dealloc];
}

@end

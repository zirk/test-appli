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
@synthesize url, method, params, response, status;

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

-(NSMutableURLRequest*) initRequest
{
	if (![iAUMSettings get:kAppSettingsLogin])
		return nil;
	[self addParam:kApiLogin value:[iAUMSettings get:kAppSettingsLogin]];
	[self addParam:kApiPassword value:[iAUMSettings get:kAppSettingsPassword]];
	[self addParam:kApiFormat value:kApiFormatType];
	
	//prepar request
	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
	[request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", kApiHost, self.url]]];
	[request setHTTPMethod:self.method];
	
	//set headers
	[request addValue:[self sign] forHTTPHeaderField:kApiAutorization];
	
	//create the body	
	NSMutableData *postBody = [NSMutableData data];
	[postBody appendData:[[iAUMTools serializeDictionary:self.params withKeys:nil] dataUsingEncoding:NSUTF8StringEncoding]];
	
	//post
	[request setHTTPBody:postBody];
	return request;
}

-(NSUInteger) sendRequest:(NSMutableURLRequest*)request result:(NSString**)result
{
	NSHTTPURLResponse* urlResponse = nil;  
	NSError *error = [[NSError alloc] init];  
	NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
	*result = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
	NSLog(@"Response Code: %d => %@", [urlResponse statusCode], self.url);
	[error release];
	if ([urlResponse statusCode] >= 200 && [urlResponse statusCode] < 300)
		return iAUMResponseSuccess;
	if ([urlResponse statusCode] == 400)
		return iAUMResponseBadRequest;
	if ([urlResponse statusCode] == 403)
		return iAUMResponseCantLogin;
	if ([urlResponse statusCode] == 405)
		return iAUMResponseNotAllowed;
	if ([urlResponse statusCode] == 417)
		return iAUMResponseAuthorization;
	if ([urlResponse statusCode] == 501)
		return iAUMResponseNotImplemented;
	if ([urlResponse statusCode] == 503) // aum server error => retry
		return iAUMResponseAumError;
	return iAUMResponseApiError; // 500 and others, api server error => retry
}

-(BOOL) send
{
	NSMutableURLRequest* request = [self initRequest];
	if (request == nil)
		return NO;
	self.response = nil;
	NSString* result = nil;
	self.status = iAUMResponseApiError;
	for (int i = 0; i < kApiRequestRetries && (self.status == iAUMResponseApiError || self.status == iAUMResponseAumError); ++i) {
		NSLog(@"REQUEST TRY n%d", i + 1);
		self.status = [self sendRequest:request result:&result];
	}
	NSLog(@"STATUS %d\n\
		  %d = iAUMResponseSuccess,			// 200 - 299\n\
		  %d = iAUMResponseBadRequest,		// 400, bad/missing parameter\n\
		  %d = iAUMResponseCantLogin,		// 403, cant login on AUM\n\
		  %d = iAUMResponseNotAllowed,		// 405, the user cant perform some action (not allowed to send messages to someone)\n\
		  %d = iAUMResponseAuthorization,	// 417, usualy bad signature\n\
		  %d = iAUMResponseNotImplemented,	// 501, if the method does not exist in the API\n\
		  %d = iAUMResponseAumError,			// 503, AUM server returned an error\n\
		  %d = iAUMResponseApiError			// 500 and everything else", self.status,
		  iAUMResponseSuccess,
		  iAUMResponseBadRequest,
		  iAUMResponseCantLogin,
		  iAUMResponseNotAllowed,
		  iAUMResponseAuthorization,
		  iAUMResponseNotImplemented,
		  iAUMResponseAumError,
		  iAUMResponseApiError
		  );
	NSLog(@"RAW RESPONSE:\n%@", result);
	if (self.status != iAUMResponseApiError && self.status != iAUMResponseAumError)
	{
		if ([result length] > 0)
			self.response = [result JSONValue];
		if([self.response isKindOfClass:[NSDictionary class]] == NO)
			self.response = nil;
		else {
			self.response = [self.response objectForKey:kApiResponse];
			NSLog(@"JSON CONVERTED RESPONSE\n%@", self.response);
		}
	}
	else
		NSLog(@"REQUEST EPIC FAIL AFTER %d TRIES", kApiRequestRetries);
	[self resetParams];
	[result release];
	[request release];
	return (self.status == iAUMResponseSuccess);
}

- (void) dealloc
{
	[self.params release];
	[self.response release];
	[super dealloc];
}

@end

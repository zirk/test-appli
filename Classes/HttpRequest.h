//
//  HttpRequest.h
//  iAUM
//
//  Created by dirk on 8/08/10.
//  Copyright 2010 Showire corp registered limited. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 Aum_Response
 const STATUS_CODE_SUCCUSS = 200;
 const STATUS_CODE_BAD_REQUEST = 400;
 const STATUS_CODE_BAD_SIGNATURE = 417;
 const STATUS_CODE_CANT_LOGIN = 403;
 const STATUS_CODE_NOT_ALLOWED = 405;
 const STATUS_CODE_ERROR_INTERNAL = 500;
 const STATUS_CODE_NOT_IMPLEMENTED = 501;
 const STATUS_CODE_ERROR_AUM = 503;
 */

enum iAUMResponse {
	iAUMResponseSuccess,		// 200 - 299
	iAUMResponseBadRequest,		// 400, bad/missing parameter
	iAUMResponseCantLogin,		// 403, cant login on AUM
	iAUMResponseNotAllowed,		// 405, the user cant perform some action (not allowed to send messages to someone)
	iAUMResponseAuthorization,	// 417, usualy bad signature
	iAUMResponseNotImplemented, // 501, if the method does not exist in the API
	iAUMResponseAumError,		// 503, AUM server returned an error
	iAUMResponseApiError		// 500 and everything else
};

@interface HttpRequest : NSObject {
	NSMutableDictionary* params;
	NSString* method;
	NSString* url;
	NSMutableArray* paramKeys;
	NSDictionary* response;
	NSUInteger status;
}

-(NSString*) sign;
-(id) init;
-(id) initWithUrl:(NSString*) URL;
-(void) addParam:(NSString*) name value:(NSString*) value;
-(void) resetParams;
-(BOOL) send;

@property (nonatomic, assign) NSString* method;
@property (nonatomic, assign) NSString* url;
@property (nonatomic, retain) NSMutableDictionary* params;
@property (nonatomic, retain) NSDictionary* response;
@property (nonatomic, assign) NSUInteger status;

@end

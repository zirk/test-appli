//
//  HttpRequest.h
//  iAUM
//
//  Created by dirk on 8/08/10.
//  Copyright 2010 Showire corp registered limited. All rights reserved.
//

#import <Foundation/Foundation.h>

#define PRIVATE_KEY "h0ly_d1ck"
#define API_URL     @"http://aum.showire.eu"

@interface HttpRequest : NSObject {
	NSString* login;
	NSString* password;
	NSString* signature;
	NSMutableDictionary* params;
	NSString* method;
	NSString* url;
	NSMutableArray* paramKeys;
	NSDictionary* response;
}

-(NSString*) sign;
-(id) init;
-(id) initWithUrl:(NSString*) URL;
-(void) addParam:(NSString*) name value:(NSString*) value;
-(void) resetParams;
-(void) release;
-(BOOL) send;

@property (nonatomic, retain) NSString* login;
@property (nonatomic, retain) NSString* password;
@property (nonatomic, retain) NSString* signature;
@property (nonatomic, retain) NSString* method;
@property (nonatomic, retain) NSString* url;
@property (nonatomic, retain) NSMutableDictionary* params;
@property (nonatomic, retain) NSDictionary* response;


@end

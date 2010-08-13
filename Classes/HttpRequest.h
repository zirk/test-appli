//
//  HttpRequest.h
//  iAUM
//
//  Created by dirk on 8/08/10.
//  Copyright 2010 Showire corp registered limited. All rights reserved.
//

#import <Foundation/Foundation.h>

#define PRIVATE_KEY "h0ly_d1ck"
//#define API_URL     @"http://aum.showire.eu"
#define API_URL     @"http://localhost:8888/public/"

@interface HttpRequest : NSObject {
//	NSString* login;
//	NSString* password;
	NSMutableDictionary* params;
	NSMutableDictionary* paramsTest;
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
//@property (nonatomic, retain) NSString* password;
@property (nonatomic, assign) NSString* method;
@property (nonatomic, assign) NSString* url;
@property (nonatomic, retain) NSMutableDictionary* params;
@property (nonatomic, retain) NSMutableDictionary* paramsTest;
@property (nonatomic, retain) NSDictionary* response;


@end

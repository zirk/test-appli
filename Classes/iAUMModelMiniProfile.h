//
//  iAUMMiniProfile.h
//  iAUM
//
//  Created by John Doe on 22/08/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface iAUMModelMiniProfile : NSObject {
	NSString* age;
	NSString* aumId;
	NSString* city;
	NSString* name;
	BOOL online;
	NSString* pictureUrl;
}

@property (nonatomic, retain) NSString* age;
@property (nonatomic, retain) NSString* city;
@property (nonatomic, retain) NSString* name;
@property (nonatomic, retain) NSString* aumId;
@property (nonatomic, retain) NSString* pictureUrl;
@property (nonatomic, assign, getter=isOnline) BOOL online;

- (id) initWithDictionary:(NSDictionary *)dico;

@end

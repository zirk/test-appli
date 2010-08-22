//
//  iAUMModelThread.h
//  iAUM
//
//  Created by John Doe on 22/08/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "iAUMModelMiniProfile.h"

@interface iAUMModelThread : NSObject {
	NSString* threadId;
	NSString* preview;
	NSString* status;
	NSString* date;
	iAUMModelMiniProfile* contact;
}

@property (nonatomic, retain) NSString* threadId;
@property (nonatomic, retain) NSString* preview;
@property (nonatomic, retain) NSString* date;
@property (nonatomic, retain) NSString* status;
@property (nonatomic, retain) iAUMModelMiniProfile* contact;

- (id) initWithDictionary:(NSDictionary *)dico;

@end

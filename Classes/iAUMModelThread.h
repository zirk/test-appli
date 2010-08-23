//
//  iAUMModelThread.h
//  iAUM
//
//  Created by John Doe on 22/08/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "iAUMModelMiniProfile.h"

/*
 Aum_Model_Mail
 const MAIL_STATUS_READ      = '0'; // "lu"
 const MAIL_STATUS_ANSWERED  = '1'; // "repondu"
 const MAIL_STATUS_NEW       = '2'; // "nouveau"
 const MAIL_STATUS_UNKNOWN   = '3'; // just in case
 */

enum iAUMThreadStatuses {
	iAUMThreadStatusRead = 0,
	iAUMThreadStatusAnswered,
	iAUMThreadStatusNew,
	iAUMThreadStatusUnknown
};

@interface iAUMModelThread : NSObject {
	NSString* threadId;
	NSString* preview;
	NSUInteger status;
	NSString* date;
	iAUMModelMiniProfile* contact;
}

@property (nonatomic, retain) NSString* threadId;
@property (nonatomic, retain) NSString* preview;
@property (nonatomic, retain) NSString* date;
@property (nonatomic, assign) NSUInteger status;
@property (nonatomic, retain) iAUMModelMiniProfile* contact;

- (id) initWithDictionary:(NSDictionary *)dico;

@end

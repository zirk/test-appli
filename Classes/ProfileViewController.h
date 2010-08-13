//
//  ProfileViewController.h
//  iAUM
//
//  Created by Dirk Amadori on 12/08/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HttpRequest.h"

@interface ProfileViewController : UIViewController {
	IBOutlet UIButton* buttonAccept;
	IBOutlet UIButton* buttonRefuse;
	NSString* userId;
	
}
-(void) asynchronouslyAccept;
-(id) initWithUserId:(NSString*) someUserId;
-(void) initButtons;
-(void) accept;//:(HttpRequest*) httpRequest;

@property (retain) UIButton* buttonAccept;
@property (retain) UIButton* buttonRefuse;
@property (retain) NSString* userId;


@end

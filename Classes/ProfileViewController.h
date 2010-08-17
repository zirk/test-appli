//
//  ProfileViewController.h
//  iAUM
//
//  Created by dirk on 12/08/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HttpRequest.h"
#import "iAUMLabel.h"

@interface ProfileViewController : UIViewController {
	IBOutlet iAUMLabel* nameLabel;
	IBOutlet iAUMLabel* aboutLabel;
	IBOutlet iAUMLabel* ageLabel;
	IBOutlet iAUMLabel* popularityLabel;
	IBOutlet UIImageView* pictureView;

	IBOutlet UIButton* buttonAccept;
	IBOutlet UIButton* buttonRefuse;
	NSString* userId;
	NSDictionary* profile;
	BOOL kicked;
}

-(void) asynchronouslyLoadProfile;
-(void) loadProfile;

-(id) initWithUserId:(NSString*) someUserId;
-(void) initButtons;
-(void) initLabels;
-(void) initPictures;

@property (retain) IBOutlet UILabel* nameLabel;
@property (retain) IBOutlet UILabel* aboutLabel;
@property (retain) IBOutlet UILabel* ageLabel;
@property (retain) IBOutlet UILabel* popularityLabel;
@property (retain) IBOutlet UIImageView* pictureView;
@property (retain) IBOutlet UIButton* buttonAccept;
@property (retain) IBOutlet UIButton* buttonRefuse;
@property (retain) NSString* userId;
@property (retain) NSDictionary* profile;
@property (assign) BOOL kicked;

@end

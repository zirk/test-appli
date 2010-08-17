//
//  _ProfileViewController.h
//  iAUM
//
//  Created by Dirk Amadori on 16/08/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

enum Sections {
	kSectionGeneralInfos = 0,
	kSectionDetails,
	kSectionFunctions,
	kSectionAccessories,
	kSectionRivales,
	kSectionPhoto,
	NUM_SECTIONS
};

enum SectionGeneralInfoRows {
	kRowName = 0,
	kRowAge,
	kRowCity,
	kRowAbout,
	NUM_ROWS_GENERAL_INFO
};

enum SectionDetailsRows {
	prout =0 ,
	NUM_ROW_DETAILS
};

enum SectionFunctionsRows {
	NUM_ROW_FUNCTIONS
};

enum SectionAccessoriesRows {
	NUM_ROW_ACCESSORIES
};

enum SectionRivalesRows {
	NUM_ROW_RIVALES
};

enum SectionPhotosRows {
	NUM_ROW_PHOTOS
};





@interface ProfileViewController : UITableViewController {
	NSString* userId;
	NSDictionary* profile;
}

-(id) initWithUserId:(NSString*) someUserId;
-(void) asynchronouslyLoadProfile;
-(void) loadProfile;

@property (retain) NSString* userId;
@property (retain) NSDictionary* profile;


@end

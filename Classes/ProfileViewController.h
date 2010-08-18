//
//  _ProfileViewController.h
//  iAUM
//
//  Created by dirk on 16/08/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProfileDetailsViewCell.h"
#import "ProfileListViewCell.h"

enum Sections {
	kSectionGeneralInfos = 0,
	kSectionPhysical,
	kSectionAccessories,
	kSectionFunctions,
	kSectionRivales,
	kSectionPhoto,
	NUM_SECTIONS
};

enum SectionGeneralInfoRows {
	NUM_ROWS_GENERAL_INFO = 1
};

enum SectionPhysicalsRows {
	NUM_ROW_DETAILS = 1
};

enum SectionFunctionsRows {
	NUM_ROW_FUNCTIONS = 1
};

enum SectionAccessoriesRows {
	NUM_ROW_ACCESSORIES = 1
};

enum SectionRivalesRows {
	NUM_ROW_RIVALES = 1
};

enum SectionPhotosRows {
	NUM_ROW_PHOTOS = 1
};





@interface ProfileViewController : UITableViewController {
	NSString* userId;
	NSDictionary* profile;
	
	NSDictionary* physicalFieldsDisplayName;
	NSDictionary* accessoriesFieldsDisplayName;
	
}

-(id) initWithUserId:(NSString*) someUserId andName:(NSString*)name;
-(void) asynchronouslyLoadProfile;
-(void) loadProfile;
-(void) fillMainProfileCell:(ProfileDetailsViewCell*)cell;
-(void) fillProfileListViewCell:(ProfileListViewCell*)cell with:(NSDictionary*)dico;

-(CGFloat)computeDetailsCellHeight;
-(CGFloat)computePhysicalCellHeight;
-(CGFloat)computeAccessoriesCellHeight;
-(CGFloat)computeFunctionsCellHeight;
-(CGFloat)heightForFields:(NSDictionary*)fields;

@property (retain) NSString* userId;
@property (retain) NSDictionary* profile;
@property (retain) NSDictionary* physicalFieldsDisplayName;
@property (retain) NSDictionary* accessoriesFieldsDisplayName;


@end

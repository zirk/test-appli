//
//  SettingsViewController.h
//  iAUM
//
//  Created by dirk on 10/08/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SettingsDetailCell.h"

@interface SettingsViewController : UITableViewController <UITextFieldDelegate>
{
	NSArray*		        cells;
}
@property (nonatomic, retain) NSArray* cells;

- (void) initCells;
- (void) initTabBar;

@end

//
//  CharmsViewController.h
//  iAUM
//
//  Created by Dirk Amadori on 11/08/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CharmsViewController : UITableViewController {
	NSArray* list;
}

-(void) refreshList:(NSArray*) list;
-(void) asynchronouslyLoadCharms;

@property (nonatomic, retain) NSArray* list;

@end

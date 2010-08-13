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
	UIActivityIndicatorView* loadingIndicator;
	BOOL isLoading;
}

-(void) refreshList:(NSArray*) list;
-(void) asynchronouslyLoadCharms;

@property (nonatomic, retain) NSArray* list;
@property (nonatomic, retain) UIActivityIndicatorView* loadingIndicator;
@property (nonatomic, assign) BOOL isLoading;

@end

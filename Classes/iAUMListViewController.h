//
//  AUMListViewController.h
//  iAUM
//
//  Created by dirk on 14/08/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iAUMConstants.h"
#import "MiniProfileCellActionView.h"
#import "ProfileViewController.h"
#import "HttpRequest.h"
#import "iAUMSettings.h"
#import "iAUMTools.h"

@interface iAUMListViewController : UITableViewController {
	NSString* listApiUrl;
	NSMutableArray* list;
	UIActivityIndicatorView* loadingIndicator;
	BOOL isLoading;
	NSInteger swappedViewCell;
	MiniProfileCellActionView* actionView;
}

-(void) refreshList:(NSArray*) list;
-(void) refreshTabBarItem;
-(void) loadList;
-(void) asynchronouslyLoadList;
-(void) initButtons;
-(void) initActionView;
-(void) displayProfile;

@property (nonatomic, retain) NSMutableArray* list;
@property (nonatomic, assign) NSString* listApiUrl;
@property (nonatomic, retain) UIActivityIndicatorView* loadingIndicator;
@property (nonatomic, assign) NSInteger swappedViewCell;
@property (nonatomic, assign) BOOL isLoading;
@property (nonatomic, retain) MiniProfileCellActionView* actionView;

@end

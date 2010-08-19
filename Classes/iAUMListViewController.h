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
#import "iAUMListLoadingView.h"

#define kAppListSearchBarHeight 40.0

@interface iAUMListViewController : UITableViewController <UISearchBarDelegate> {
	NSString* listApiUrl;
	iAUMListLoadingView* loadingView;
	MiniProfileCellActionView* actionView;
	UISearchBar* searchBar;
	NSMutableArray* searchedList; //displayed list, contains full or filtered people list
	NSMutableArray* list; //contains full people list
	BOOL isLoading;
	NSInteger swappedViewCell;
}

-(void) refreshList:(NSArray*) list;
-(void) refreshTabBarItem;
-(void) loadList;
-(void) asynchronouslyLoadList;
-(void) initButtons;
-(void) initActionView;
-(void) displayProfile;
-(void) kickFromList:(id)object;
-(void) swapActionViewBeforeSearch:(BOOL)animated;

@property (nonatomic, retain) NSMutableArray* list;
@property (nonatomic, assign) NSString* listApiUrl;
@property (nonatomic, retain) iAUMListLoadingView* loadingView;
@property (nonatomic, assign) NSInteger swappedViewCell;
@property (nonatomic, assign) BOOL isLoading;
@property (nonatomic, retain) MiniProfileCellActionView* actionView;
@property (nonatomic, assign) UISearchBar* searchBar;
@property (nonatomic, assign) NSMutableArray* searchedList;

@end

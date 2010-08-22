//
//  AUMListViewController.h
//  iAUM
//
//  Created by dirk on 14/08/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iAUMConstants.h"
#import "iAUMCell.h"
#import "iAUMCellActionView.h"
#import "HttpRequest.h"
#import "iAUMTools.h"
#import "iAUMListLoadingView.h"
#import "iAUMModelMiniProfile.h"

#define kAppListSearchBarHeight 40.0

@interface iAUMListViewController : UITableViewController <UISearchBarDelegate> {
	NSString* cellIdentifier;

	NSString* listApiUrl;
	NSString* listKeyInResponse;
	iAUMListLoadingView* loadingView;
	iAUMCellActionView* actionView;
	UISearchBar* searchBar;
	NSMutableArray* searchedList; //displayed list, contains full or filtered list
	NSMutableArray* list; //contains full list
	BOOL isLoading;
	NSInteger swappedViewCell;
}

-(void) refreshList:(NSArray*) list;
-(void) refreshTabBarItem;
-(void) loadList;
-(void) asynchronouslyLoadList;
-(void) initButtons;
-(void) initActionView;
-(void) kickFromList:(id)object;
-(void) swapActionViewBeforeSearch:(BOOL)animated;
-(void) displayProfile:(iAUMModelMiniProfile*)miniProfile;
-(iAUMCell*) createNewCell;
-(void) fillListWithObjects:(NSArray *)objects;

@property (nonatomic, assign) NSString* cellIdentifier;

@property (nonatomic, assign) NSMutableArray* list;
@property (nonatomic, assign) NSString* listApiUrl;
@property (nonatomic, assign) NSString* listKeyInResponse;
@property (nonatomic, retain) iAUMListLoadingView* loadingView;
@property (nonatomic, assign) NSInteger swappedViewCell;
@property (nonatomic, assign) BOOL isLoading;
@property (nonatomic, retain) iAUMCellActionView* actionView;
@property (nonatomic, assign) UISearchBar* searchBar;
@property (nonatomic, assign) NSMutableArray* searchedList;

@end

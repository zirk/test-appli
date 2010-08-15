//
//  AUMListViewController.h
//  iAUM
//
//  Created by dirk on 14/08/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iAUMConstants.h"
#import "MiniProfileCell.h"
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
	UIView* actionView;
}

-(void) refreshList:(NSArray*) list;
-(void) refreshTableView;
-(void) loadList;
-(void) asynchronouslyLoadList;

@property (nonatomic, retain) NSMutableArray* list;
@property (nonatomic, assign) NSString* listApiUrl;
@property (nonatomic, retain) UIActivityIndicatorView* loadingIndicator;
@property (nonatomic, assign) NSInteger swappedViewCell;
@property (nonatomic, assign) BOOL isLoading;
@property (nonatomic, retain) UIView* actionView;

@end

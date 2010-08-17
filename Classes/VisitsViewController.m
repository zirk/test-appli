//
//  VisitsViewController.m
//  iAUM
//
//  Created by dirk on 14/08/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "VisitsViewController.h"
#import "MiniProfileCellActionView.h"
#import "MiniProfileCellActionViewVisits.h"

@implementation VisitsViewController

#pragma mark -
#pragma mark Initialization

- (id)initWithStyle:(UITableViewStyle)style {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    if ((self = [super initWithStyle:style])) {
		self.listApiUrl = @"/visits/list";
		self.title = @"Visites";
		UITabBarItem *barItem = [[UITabBarItem alloc] initWithTitle:@"Visites" image:[UIImage imageNamed:@"tabBarVisits.png"] tag:0];
		self.tabBarItem = barItem;
		[barItem release];
    }
    return self;
}

- (void) initActionView
{
	self.actionView = [[MiniProfileCellActionViewVisits alloc] init];
	[self.actionView release];
	[super initActionView];
}

- (void) initButtons
{
	//[[self.actionView buttonForName:@"CharmRefuse"] addTarget:self action:@selector(asynchronouslyRefuse) forControlEvents:UIControlEventTouchUpInside];
	[super initButtons];
}
@end

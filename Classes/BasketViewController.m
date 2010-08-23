//
//  BasketViewController.m
//  iAUM
//
//  Created by dirk on 14/08/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "iAUMSettings.h"
#import "BasketViewController.h"
#import "MiniProfileCellActionViewBaskets.h"

@implementation BasketViewController

#pragma mark -
#pragma mark Initialization

- (id)initWithStyle:(UITableViewStyle)style {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    if ((self = [super initWithStyle:style])) {
		self.listApiUrl = [iAUMSettings apiConfig:kAppSettingsApiConfigActionBasketList];
		self.title = @"Panier";
		UITabBarItem *barItem = [[UITabBarItem alloc] initWithTitle:@"Panier" image:[UIImage imageNamed:@"tabBarBasket.png"] tag:0];
		self.tabBarItem = barItem;
		[barItem release];
    }
    return self;
}

- (void) initActionView
{
	self.actionView = [[MiniProfileCellActionViewBaskets alloc] init];
	[self.actionView release];
	[super initActionView];
}

- (void) initButtons
{
	//[[self.actionView buttonForName:@"BasketKickOut"] addTarget:self action:@selector(asynchronouslyKickFromBasket) forControlEvents:UIControlEventTouchUpInside];
	[super initButtons];
}

@end

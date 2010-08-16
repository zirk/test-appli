//
//  BasketViewController.m
//  iAUM
//
//  Created by dirk on 14/08/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "BasketViewController.h"

@implementation BasketViewController

#pragma mark -
#pragma mark Initialization

- (id)initWithStyle:(UITableViewStyle)style {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    if ((self = [super initWithStyle:style])) {
		self.listApiUrl = @"/baskets/list";
		UITabBarItem *barItem = [[UITabBarItem alloc] initWithTitle:@"Panier" image:[UIImage imageNamed:@"tabBarBasket.png"] tag:0];
		self.tabBarItem = barItem;
		[barItem release];
    }
    return self;
}

- (void) initButtons
{
	
}

@end

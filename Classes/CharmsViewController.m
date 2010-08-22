//
//  CharmsViewController.m
//  iAUM
//
//  Created by dirk on 11/08/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MiniProfileCell.h"
#import "MiniProfileCellActionViewCharms.h"
#import "CharmsViewController.h"
#import "ProfileViewController.h"

@implementation CharmsViewController

#pragma mark -
#pragma mark Initialization


- (id)initWithStyle:(UITableViewStyle)style {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    if ((self = [super initWithStyle:style])) {
		self.listApiUrl = @"/charms/list-new";
		self.title = @"Charmes";
		UITabBarItem *barItem = [[UITabBarItem alloc] initWithTitle:@"Charmes" image:[UIImage imageNamed:@"tabBarCharms.png"] tag:0];
		self.tabBarItem = barItem;
		[barItem release];
    }
    return self;
}

- (void) initActionView
{
	self.actionView = [[MiniProfileCellActionViewCharms alloc] init];
	[self.actionView release];
	[super initActionView];
}

- (void) initButtons
{	
	[[self.actionView buttonForName:@"CharmAccept"] addTarget:self action:@selector(asynchronouslyAccept) forControlEvents:UIControlEventTouchUpInside];
	[[self.actionView buttonForName:@"CharmRefuse"] addTarget:self action:@selector(asynchronouslyRefuse) forControlEvents:UIControlEventTouchUpInside];
	[super initButtons];
}

- (IBAction) asynchronouslyAccept
{
	if(self.swappedViewCell != -1)
	{
		[self.actionView disableButtons];
		[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
		[iAUMTools queueOperation:@selector(accept:) withTarget:self withObject:[self.searchedList objectAtIndex:self.swappedViewCell]];
		NSLog(@"queue gedin operation");
	}
}


- (IBAction) asynchronouslyRefuse
{
	if(self.swappedViewCell != -1)
	{
		[self.actionView disableButtons];
		[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
		[iAUMTools queueOperation:@selector(refuse:) withTarget:self withObject:[self.searchedList objectAtIndex:self.swappedViewCell]];
		NSLog(@"queue gedaoude operation");
	}
}


-(void) accept:(iAUMModelMiniProfile*)miniProfile
{
	if (miniProfile != nil && miniProfile.aumId != nil)
	{
		HttpRequest* httpRequest = [[HttpRequest alloc] initWithUrl:@"/charms/accept"];
		[httpRequest addParam:@"aumId" value:miniProfile.aumId];

		//if ([httpRequest send] == YES)
		[NSThread sleepForTimeInterval:5];
		if (YES) // FOR TESTING
		{
			[self performSelectorOnMainThread:@selector(kickFromList:) withObject:miniProfile waitUntilDone:NO];
			NSLog(@"successfuly accepted %@", miniProfile.aumId);
		}
		else {
			NSLog(@"Failed at accepting %@ ", miniProfile.aumId);
		}
		[httpRequest release];
	}
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
	[self.actionView performSelectorOnMainThread:@selector(enableButtons) withObject:nil waitUntilDone:NO];
}

- (IBAction) refuse:(iAUMModelMiniProfile*)miniProfile
{
	if (miniProfile != nil && miniProfile.aumId != nil)
	{
		HttpRequest* httpRequest = [[HttpRequest alloc] initWithUrl:@"/charms/refuse"];
		[httpRequest addParam:@"aumId" value:miniProfile.aumId];

		//if ([httpRequest send] == YES)
		[NSThread sleepForTimeInterval:5];
		if (YES) // FOR TESTING
		{
			[self performSelectorOnMainThread:@selector(kickFromList:) withObject:miniProfile waitUntilDone:NO];
			NSLog(@"successfuly kicked %@", miniProfile.aumId);
		}
		else {
			NSLog(@"Failed at kicking %@ ", miniProfile.aumId);
		}
		[httpRequest release];
	}
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
	[self.actionView performSelectorOnMainThread:@selector(enableButtons) withObject:nil waitUntilDone:NO];
}

@end


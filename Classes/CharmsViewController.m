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
		[iAUMTools queueOperation:@selector(accept:) withTarget:self withObject:[NSNumber numberWithInt:self.swappedViewCell]];
		NSLog(@"queue gedin operation");
	}
}


- (IBAction) asynchronouslyRefuse
{
//	NSLog(@"gedaoue %@", self.userId);
	if(self.swappedViewCell != -1)
	{
		[self.actionView disableButtons];
		[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
		[iAUMTools queueOperation:@selector(refuse:) withTarget:self withObject:[NSNumber numberWithInt:self.swappedViewCell]];
		NSLog(@"queue gedaoude operation");
	}
}


-(void) accept:(NSNumber*)rowNumber
{
	if(self.swappedViewCell != -1)
	{
		NSString* userId = [[self.list objectAtIndex:self.swappedViewCell] objectForKey:@"aumId"];
		HttpRequest* httpRequest = [[HttpRequest alloc] initWithUrl:@"/charms/accept"];
		[httpRequest addParam:@"aumId" value:userId];
		
		if ([httpRequest send] == YES)
		{
			[self.kickingQueue addObject:rowNumber];
			self.cellToRemove = self.swappedViewCell;
			[self performSelectorOnMainThread:@selector(kickFromListWithId:) withObject:rowNumber waitUntilDone:NO];
			NSLog(@"successfuly accepted %@", userId);
		}
		else {
			NSLog(@"Failed at accepting %@ ", userId);
		}
		[httpRequest release];
	}
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
	[self.actionView enableButtons];
}

- (IBAction) refuse:(NSNumber*)rowNumber
{
	if(self.swappedViewCell != -1)
	{
		NSString* userId = [[self.list objectAtIndex:self.swappedViewCell] objectForKey:@"aumId"];
		HttpRequest* httpRequest = [[HttpRequest alloc] initWithUrl:@"/charms/refuse"];
		[httpRequest addParam:@"aumId" value:userId];
		
		if ([httpRequest send] == YES)
		{
			[self.kickingQueue addObject:rowNumber];
			self.cellToRemove = self.swappedViewCell;
			[self performSelectorOnMainThread:@selector(kickFromListWithId:) withObject:rowNumber waitUntilDone:NO];
			NSLog(@"successfuly kicked %@", userId);
		}
		else {
			NSLog(@"Failed at kicking %@ ", userId);
		}
		[httpRequest release];
	}
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
	[self.actionView enableButtons];
}

@end


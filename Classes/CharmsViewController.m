//
//  CharmsViewController.m
//  iAUM
//
//  Created by dirk on 11/08/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MiniProfileCell.h"
#import "CharmsViewController.h"

@implementation CharmsViewController

#pragma mark -
#pragma mark Initialization


- (id)initWithStyle:(UITableViewStyle)style {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    if ((self = [super initWithStyle:style])) {
		self.listApiUrl = @"/charms/list-new";
		UITabBarItem *barItem = [[UITabBarItem alloc] initWithTitle:@"Charmes" image:[UIImage imageNamed:@"charm.png"] tag:0];
		self.tabBarItem = barItem;
		[barItem release];
    }
    return self;
}




- (void) initButtons
{	
	UIButton* buttonAccept = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	buttonAccept.frame = CGRectMake(10.0, 10.0, 100.0, 50.0);
	[buttonAccept setTitle:@"gedin" forState:UIControlStateNormal];
	[buttonAccept addTarget:self action:@selector(asynchronouslyAccept) forControlEvents:UIControlEventTouchUpInside];
	
	UIButton* buttonRefuse = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	buttonRefuse.frame = CGRectMake(110.0, 10.0, 100.0, 50.0);
	[buttonRefuse setTitle:@"gedaoude" forState:UIControlStateNormal];
	[buttonRefuse addTarget:self action:@selector(asynchronouslyRefuse) forControlEvents:UIControlEventTouchUpInside];
	
	[self.actionView addSubview:buttonAccept];
	[self.actionView addSubview:buttonRefuse];
}

- (IBAction) asynchronouslyAccept
{
	if(self.swappedViewCell != -1)
	{
		[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
		[iAUMTools queueOperation:@selector(accept) withTarget:self withObject:nil];
		NSLog(@"queue gedin operation");
	}
}


- (IBAction) asynchronouslyRefuse
{
//	NSLog(@"gedaoue %@", self.userId);
	if(self.swappedViewCell != -1)
	{
		[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
		[iAUMTools queueOperation:@selector(refuse) withTarget:self withObject:nil];
		NSLog(@"queue gedaoude operation");
	}
}


-(void) accept
{
	if(self.swappedViewCell != -1)
	{
		NSString* userId = [[self.list objectAtIndex:self.list.count - self.swappedViewCell - 1] objectForKey:@"aumId"];
		NSLog(@"in accept");
		HttpRequest* httpRequest = [[HttpRequest alloc] initWithUrl:@"/charms/accept"];
		[httpRequest addParam:@"aumId" value:userId];
		
		if ([httpRequest send] == YES)
		{
			[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
			[self performSelectorOnMainThread:@selector(kickFromListWithId:) withObject:userId waitUntilDone:NO];
			NSLog(@"successfuly accepted %@", userId);
		}
		else {
			NSLog(@"Failed at accepting %@ ", userId);
		}
		[httpRequest release];
	}
}

- (IBAction) refuse
{
	if(self.swappedViewCell != -1)
	{
		NSString* userId = [[self.list objectAtIndex:self.list.count - self.swappedViewCell - 1] objectForKey:@"aumId"];
		NSLog(@"gedaoude %@", userId);
		HttpRequest* httpRequest = [[HttpRequest alloc] initWithUrl:@"/charms/refuse"];
		[httpRequest addParam:@"aumId" value:userId];
		
		if ([httpRequest send] == YES)
		{
			[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
			[self performSelectorOnMainThread:@selector(kickFromListWithId:) withObject:userId waitUntilDone:NO];
			NSLog(@"successfuly kicked %@", userId);
		}
		else {
			NSLog(@"Failed at kicking %@ ", userId);
		}
		[httpRequest release];
	}
}

@end


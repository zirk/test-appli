    //
//  ProfileViewController.m
//  iAUM
//
//  Created by dirk on 12/08/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ProfileViewController.h"
#import "iAUMConstants.h"
#import "iAUMSettings.h"
#import "iAUMTools.h"

@implementation ProfileViewController

@synthesize buttonAccept, buttonRefuse, userId, profile, nameLabel, ageLabel, aboutLabel, popularityLabel, pictureView, kicked;

- (id) initWithUserId:(NSString*) someUserId
{
	if(self = [super init])
	{
		self.kicked = NO;
		self.userId = someUserId;
		NSLog(@"userid: %@", self.userId);
	}
	return self;
}

- (void) initLabels
{
	UILabel* nameL = [[UILabel alloc] init];
	self.nameLabel = nameL;
	self.nameLabel.frame = CGRectMake(110.0, 10.0, 100.0, 50.0);
	self.nameLabel.textColor = [UIColor redColor];
	[self.view addSubview:self.nameLabel];
	[nameL release];
}

- (void) initButtons
{	
	self.buttonAccept = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	self.buttonAccept.frame = CGRectMake(10.0, 10.0, 100.0, 50.0);
	[self.buttonAccept setTitle:@"gedin" forState:UIControlStateNormal];
	[self.buttonAccept addTarget:self action:@selector(asynchronouslyAccept) forControlEvents:UIControlEventTouchUpInside];
	
	self.buttonRefuse = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	self.buttonRefuse.frame = CGRectMake(10.0, 100.0, 100.0, 50.0);
	[self.buttonRefuse setTitle:@"gedaoude" forState:UIControlStateNormal];
	[self.buttonRefuse addTarget:self action:@selector(asynchronouslyRefuse) forControlEvents:UIControlEventTouchUpInside];
	
	[self.view addSubview:self.buttonAccept];
	[self.view addSubview:self.buttonRefuse];
	[self.view setBackgroundColor:[UIColor greenColor]];
}

- (void) refreshView
{
	NSLog(@"Name : %@", [self.profile objectForKey:@"name"]);
	self.nameLabel.text = [self.profile objectForKey:@"name"];
}

- (void) asynchronouslyLoadProfile
{
	NSLog(@"downloading profile");
	//////////////////////////////////////////////////////////////
	//self.userId = @"22793764";
	//////////////////////////////////////////////////////////////
	[iAUMTools queueOperation:@selector(loadProfile) withTarget:self withObject:nil];
}

- (IBAction) asynchronouslyAccept
{
	NSLog(@"gedin %@", self.userId);
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
	[iAUMTools queueOperation:@selector(accept) withTarget:self withObject:nil];
	NSLog(@"queue gedin operation");
}


- (IBAction) asynchronouslyRefuse
{
	NSLog(@"gedaoue %@", self.userId);
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
	[iAUMTools queueOperation:@selector(refuse) withTarget:self withObject:nil];
	NSLog(@"queue gedaoude operation");
}


-(void) accept
{
	NSLog(@"in accept");
	HttpRequest* httpRequest = [[HttpRequest alloc] initWithUrl:@"/charms/accept"];
	[httpRequest addParam:@"aumId" value:self.userId];
	
	if ([httpRequest send] == YES)
	{
		[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
		//[[UIApplication sharedApplication] performSelectorOnMainThread:@selector(setNetworkActivityIndicatorVisible) withObject:NO waitUntilDone:NO];
		NSLog(@"successfuly accepted %@", self.userId);
		self.kicked = YES;
	}
	else {
		NSLog(@"Failed at accepting %@ ", self.userId);
	}
	[httpRequest release];
}

- (IBAction) refuse
{
	NSLog(@"gedaoude %@", self.userId);
	NSLog(@"in accept");
	HttpRequest* httpRequest = [[HttpRequest alloc] initWithUrl:@"/charms/refuse"];
	[httpRequest addParam:@"aumId" value:self.userId];
	
	if ([httpRequest send] == YES)
	{
		[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
		//[self performSelectorOnMainThread:@selector(refuse) withObject:[[[httpRequest.response objectForKey:@"response"] objectForKey:@"data"] objectForKey:@"guys"] waitUntilDone:NO];
		NSLog(@"successfuly kicked %@", self.userId);
		self.kicked = YES;
	}
	else {
		NSLog(@"Failed at kicking %@ ", self.userId);
	}
	[httpRequest release];
}

- (void) loadProfile
{
	NSLog(@"in loadProfile");
	HttpRequest* httpRequest = [[HttpRequest alloc] initWithUrl:@"/profiles/visit"];
	[httpRequest addParam:@"aumId" value:self.userId];
	
	if ([httpRequest send] == YES)
	{
		[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
		//[self performSelectorOnMainThread:@selector(refuse) withObject:[[[httpRequest.response objectForKey:@"response"] objectForKey:@"data"] objectForKey:@"guys"] waitUntilDone:NO];
		self.profile = [httpRequest.response objectForKey:@"data"];
		[self performSelectorOnMainThread:@selector(refreshView) withObject:nil waitUntilDone:NO];
		NSLog(@"successfuly loaded %@", self.userId);
	}
	else {
		NSLog(@"Failed at loading %@ ", self.userId);
	}
	[httpRequest release];
}

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {

}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	[self initButtons];
	[self initLabels];
	[self asynchronouslyLoadProfile];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
	[self.buttonAccept release];
	[self.buttonRefuse release];
}


@end

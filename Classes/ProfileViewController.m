    //
//  ProfileViewController.m
//  iAUM
//
//  Created by Dirk Amadori on 12/08/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ProfileViewController.h"
#import "iAUMConstants.h"
#import "AUMSettings.h"
#import "AumTools.h"

@implementation ProfileViewController

@synthesize buttonAccept, buttonRefuse, userId;

- (id) initWithUserId:(NSString*) someUserId
{
	if(self = [super init])
	{
		self.userId = someUserId;
		NSLog(@"userid: %@", self.userId);
		[self initButtons];
	}
	return self;
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
	[self.buttonRefuse addTarget:self action:@selector(refuse) forControlEvents:UIControlEventTouchUpInside];
	
	[self.view addSubview:self.buttonAccept];
	[self.view addSubview:self.buttonRefuse];
	[self.view setBackgroundColor:[UIColor greenColor]];
}

- (IBAction) asynchronouslyAccept
{
	NSLog(@"gedin %@", self.userId);

	[AumTools queueOperation:@selector(accept) withTarget:self withObject:nil];
	NSLog(@"queue gedin operation");
}

-(void) accept
{
	NSLog(@"in accept");
	HttpRequest* httpRequest = [[HttpRequest alloc] initWithUrl:@"/charms/accept"];
	[httpRequest addParam:@"aumId" value:self.userId];
	
	if ([httpRequest send] == YES)
	{
		//[self performSelectorOnMainThread:@selector(refuse) withObject:[[[httpRequest.response objectForKey:@"response"] objectForKey:@"data"] objectForKey:@"guys"] waitUntilDone:NO];
		NSLog(@"successfuly accepted %@", self.userId);
	}
	else {
		NSLog(@"Failed at accepting %@ ", self.userId);
	}
	[httpRequest release];
}

- (IBAction) refuse
{
	NSLog(@"gedaoude %@", self.userId);
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

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

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

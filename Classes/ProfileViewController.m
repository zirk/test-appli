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
#import "iAUMCache.h"
#import "iAUMImageViewer.h"

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
	self.nameLabel = [[[iAUMLabel alloc] init] autorelease];
	self.nameLabel.frame = CGRectMake(0.0, 110, 100.0, 20.0);
	self.nameLabel.shadowColor = [UIColor grayColor];
	[self.view addSubview:self.nameLabel];

	self.ageLabel = [[[iAUMLabel alloc] init] autorelease];
	self.ageLabel.frame = CGRectMake(0.0, 135.0, 100.0, 20.0);
	[self.view addSubview:self.ageLabel];
	
	self.aboutLabel = [[[iAUMLabel alloc] init] autorelease];
	self.aboutLabel.frame = CGRectMake(0.0, 160.0, 100.0, 20.0);
	[self.view addSubview:self.aboutLabel];
	
	self.popularityLabel = [[[iAUMLabel alloc] init] autorelease];
	self.popularityLabel.frame = CGRectMake(0.0, 185.0, 100.0, 20.0);
	[self.view addSubview:self.popularityLabel];
	
	self.pictureView = [[[UIImageView alloc] init] autorelease];
	self.pictureView.frame = CGRectMake(0.0, 310.0, 100.0, 20.0);
	[self.view addSubview:self.pictureView];
	
	
}

- (void) initButtons
{	
	
	self.buttonAccept = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	self.buttonAccept.frame = CGRectMake(10.0, 200.0, 100.0, 50.0);
	[self.buttonAccept setTitle:@"photos" forState:UIControlStateNormal];
	[self.buttonAccept addTarget:self action:@selector(displayImages) forControlEvents:UIControlEventTouchUpInside];
	/*
	self.buttonRefuse = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	self.buttonRefuse.frame = CGRectMake(10.0, 100.0, 100.0, 50.0);
	[self.buttonRefuse setTitle:@"gedaoude" forState:UIControlStateNormal];
	[self.buttonRefuse addTarget:self action:@selector(asynchronouslyRefuse) forControlEvents:UIControlEventTouchUpInside];
	*/
	[self.view addSubview:self.buttonAccept];
	[self.view addSubview:self.buttonRefuse];/*
	[self.view setBackgroundColor:[UIColor greenColor]];
	 */
}

-(void)displayImages
{
	iAUMImageViewer* imageViewer = [[iAUMImageViewer alloc] init];
	
	
	
	
	
	for (NSString* imageUrl in [self.profile objectForKey:@"secondaryPhotoThumbs"]) 
	{
		NSLog(@"dling %@", imageUrl);
		[imageViewer addImage:imageUrl];
	}
	//[self.view addSubview:imageViewer.view];
	[self presentModalViewController:imageViewer animated:YES];
	[imageViewer release];
}

-(void) initPictures
{
	self.pictureView = [[[UIImageView alloc] init] autorelease];
	self.pictureView.frame = CGRectMake(0.0, 0.0, 100.0, 100.0);
	[self.view addSubview:self.pictureView];
}

- (void) refreshView
{
	NSLog(@"refreshing view Name : %@", [self.profile objectForKey:@"name"]);
	iAUMCache* cache = [[iAUMCache alloc] init];
	self.nameLabel.text = [self.profile objectForKey:@"name"];
	self.ageLabel.text = [self.profile objectForKey:@"age"];
	self.popularityLabel.text = [self.profile objectForKey:@"popularity"];
	
	[cache loadImage:[self.profile objectForKey:@"mainPhotoThumb"] forObject:self];
	//self.aboutLabel.text = [self.profile objectForKey:@"about"];
}

-(void)setImage:(UIImage*) image
{
	self.pictureView.image = image;
}

- (void) asynchronouslyLoadProfile
{
	NSLog(@"downloading profile");
	//////////////////////////////////////////////////////////////
	//self.userId = @"22793764";
	//////////////////////////////////////////////////////////////
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
	[iAUMTools queueOperation:@selector(loadProfile) withTarget:self withObject:nil];
}

- (void) loadProfile
{
	NSLog(@"in loadProfile for %@", self.userId);
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
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 80.0;
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
	self.view.backgroundColor = [UIColor whiteColor];
	[self initButtons];
	[self initLabels];
	[self initPictures];
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
	
	//[self.buttonAccept release];
	//[self.buttonRefuse release];
	[self.nameLabel release];
	[self.ageLabel release];
	[self.aboutLabel release];
	[self.popularityLabel release];
	[self.pictureView release];
	
    [super dealloc];
}


@end

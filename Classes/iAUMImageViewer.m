//
//  iAUMImageViewer.m
//  iAUM
//
//  Created by dirk on 16/08/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "iAUMImageViewer.h"
#import "iAUMCache.h"

@implementation iAUMImageViewer
@synthesize imageViews, exitButton;

- (id)init {
    if ((self = [super init])) {
        self.imageViews = [[[NSMutableArray alloc] init] autorelease];
    }
    return self;
}

- (void) addImage:(NSString*)imageUrl
{
	
	UIImageView* imageView = [[UIImageView alloc] init];
	iAUMCache* cache = [[iAUMCache alloc] init];
	[cache loadImage:imageUrl forObject:imageView];
	
	int width = self.view.frame.size.width / 4;
	int height = width;
	
	imageView.frame = CGRectMake((self.imageViews.count % 4) * width, (self.imageViews.count / 4) * height, width, height);

	[self.imageViews addObject:imageView];
	[self.view addSubview:imageView];
	[imageView release];
	[cache release];
	
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
	self.exitButton =  [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[self.exitButton setTitle:@"back" forState:UIControlStateNormal];
	self.exitButton.frame = CGRectMake(0.0, 200.0, 100.0, 40.0);
	[self.exitButton addTarget:self action:@selector(gedaoude) forControlEvents:UIControlEventTouchDown];
	[self.view addSubview:exitButton];
}
 
-(void)gedaoude
{
	[self dismissModalViewControllerAnimated:YES];
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
	[self.imageViews release];
	[self.exitButton release];
    [super dealloc];
}


@end

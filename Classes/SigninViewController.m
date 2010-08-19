    //
//  SigninViewController.m
//  iAUM
//
//  Created by John Doe on 18/08/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "SigninViewController.h"
#import "iAUMSettings.h"
#import "iAUMConstants.h"
#import <CoreGraphics/CoreGraphics.h>
#import <QuartzCore/QuartzCore.h>

@implementation SigninViewController

@synthesize loginTextField, passwordTextField, signinButton, activityIndicator, tmp;

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
	self.view.backgroundColor = [UIColor darkGrayColor];
	
	//tabbar
	self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Login" image:[UIImage imageNamed:@"tabBarSettings.png"] tag:0];
	[self.tabBarItem release];

	//text fields
	self.loginTextField = [self buildSigninTextField:@"Login" withFrame:CGRectMake(50, 150, 220, 25)];
	[self.loginTextField release];
	self.loginTextField.text = [iAUMSettings get:kAppSettingsLogin];
	self.passwordTextField = [self buildSigninTextField:@"Password" withFrame:CGRectMake(50, 180, 220, 25)];
	[self.passwordTextField release];
	self.passwordTextField.secureTextEntry = YES;
	self.passwordTextField.text = [iAUMSettings get:kAppSettingsPassword];
	
	//button
	self.signinButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	self.signinButton.frame = CGRectMake(110, 230, 100, 45);
	[self.signinButton setTitle:@"Sign In" forState:UIControlStateNormal];
	self.signinButton.titleLabel.textColor = [UIColor darkGrayColor];
	[self.signinButton addTarget:self action:@selector(signIn) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:self.signinButton];
	
	//activity indicator
	self.activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(145, 290, 30, 30)];
	[self.activityIndicator release];
	self.activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
	[self.view addSubview:self.activityIndicator];

	// some temp shit
	self.tmp = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 280, 140)];
	self.tmp.textColor = [UIColor blackColor];
	self.tmp.font = [UIFont boldSystemFontOfSize:40];
	self.tmp.text = @"Don't click";
	self.tmp.textAlignment = UITextAlignmentCenter;
	self.tmp.backgroundColor= [UIColor clearColor];
	[self.view addSubview:self.tmp];
}

- (UITextField*)buildSigninTextField:(NSString*)placeholder withFrame:(CGRect)frame
{
	UITextField* someTextField = [[UITextField alloc] initWithFrame:frame];
	someTextField.autocorrectionType = UITextAutocorrectionTypeNo;
	someTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
	someTextField.placeholder = placeholder;
	someTextField.textColor = [UIColor whiteColor];
	someTextField.textAlignment = UITextAlignmentCenter;
	someTextField.layer.shadowOpacity = 1.0;
	someTextField.layer.shadowColor = [UIColor blackColor].CGColor;
	someTextField.layer.shadowRadius = 3.0;
	someTextField.layer.shadowOffset = CGSizeZero;
	//someTextField.background = [UIImage imageNamed:@""];
	[self.view addSubview:someTextField];
	return someTextField;
}

- (IBAction) signIn
{
	[self.activityIndicator startAnimating];
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
	[self.loginTextField release];
	[self.passwordTextField release];
	[self.signinButton release];
	[self.tmp release];
    [super dealloc];
}


@end

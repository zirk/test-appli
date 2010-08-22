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
#import "HttpRequest.h"
#import "iAUMTools.h"
#import "iAUMAlertView.h"
#import <CoreGraphics/CoreGraphics.h>
#import <QuartzCore/QuartzCore.h>

@implementation SigninViewController

@synthesize loginTextField, passwordTextField, signinButton, activityIndicator, alertView, tmp;

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
	self.loginTextField.returnKeyType = UIReturnKeyNext;
	//self.loginTextField.text = [iAUMSettings get:kAppSettingsLogin];
	self.passwordTextField = [self buildSigninTextField:@"Password" withFrame:CGRectMake(50, 180, 220, 25)];
	[self.passwordTextField release];
	self.passwordTextField.secureTextEntry = YES;
	self.passwordTextField.returnKeyType = UIReturnKeyDone;
	//self.passwordTextField.text = [iAUMSettings get:kAppSettingsPassword];
	
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
	
	//alert view
	self.alertView = [[iAUMAlertView alloc] initWithTitle:@"Failor" message:@"some fail" delegate:self cancelButtonTitle:@"whatever" otherButtonTitles:nil];
	[self.alertView release];

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
	someTextField.delegate = self;
	someTextField.textColor = [UIColor whiteColor];
	someTextField.textAlignment = UITextAlignmentCenter;
	someTextField.layer.shadowOpacity = 1.0;
	someTextField.layer.shadowColor = [UIColor blackColor].CGColor;
	someTextField.layer.shadowRadius = 3.0;
	someTextField.layer.shadowOffset = CGSizeZero;
	//someTextField.background = [UIImage imageNamed:@""];
	[self.view addSubview:someTextField];
	return someTextField; //nevermind
}

- (BOOL)checkTextFields
{
	BOOL result = YES;
	self.loginTextField.text = [self.loginTextField.text lowercaseString];
	if (self.loginTextField.text.length < 1) {
		self.loginTextField.placeholder = @"fill this bitch";
		result = NO;
	}
	else if ([iAUMTools isValidEmail:self.loginTextField.text] == NO) {
		[self displayError:@"sucky email"];
		result = NO;
	}
	if (self.passwordTextField.text.length < 1) {
		self.passwordTextField.placeholder = @"yeah, right";
		result = NO;
	}
	return result;
}

- (IBAction) signIn
{
	if ([self checkTextFields] == NO)
		return ;
	if ([self.loginTextField isFirstResponder] == YES)
		[self.loginTextField resignFirstResponder];
	else if ([self.passwordTextField isFirstResponder] == YES)
		[self.passwordTextField resignFirstResponder];
	[iAUMSettings set:kAppSettingsLogin withValue:self.loginTextField.text];
	[iAUMSettings set:kAppSettingsPassword withValue:self.passwordTextField.text];
	[self.activityIndicator startAnimating];
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
	[iAUMTools queueOperation:@selector(remoteSignIn) withTarget:self withObject:nil];
}

- (void)signInEnded:(NSNumber*)success
{
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
	[self.activityIndicator stopAnimating];
	if ([success boolValue] == YES) {
		NSUInteger sex = [iAUMTools getUsersSex:[iAUMSettings get:kAppSettingsAumId]];
		if (sex == iAUMUserSexUnknown) {
			//TODO The sex is unknown, ask the user what's his profile's sex
			NSLog(@"TODO The sex is unknown, ask the user what's his profile's sex");
		}
		if (sex == iAUMUserSexMale) {
			//TODO reconfigure the app for some dude here
			NSLog(@"TODO reconfigure the app for some dude here");
		}
		else if (sex == iAUMUserSexFemale) {
			//TODO reconfigure the app for some chick here
			NSLog(@"TODO reconfigure the app for some chick here");
		}
		[self dismissModalViewControllerAnimated:YES];
	}
}

- (void)remoteSignIn
{
	BOOL result = NO;
	HttpRequest* httpRequest = [[HttpRequest alloc] initWithUrl:@"/"];		
	if ([httpRequest send] == YES)
	{
		NSString* aumId = [[httpRequest.response objectForKey:kApiResponseExtra] objectForKey:@"aumId"];
		if ([iAUMTools isValidAumId:aumId] == YES) {
			[iAUMSettings set:kAppSettingsAumId withValue:aumId];
			NSLog(@"successfuly identified %@, it's a %d (0=Girl,1=Boy,2=Alien)", aumId, [iAUMTools getUsersSex:aumId]);
			result = YES;
		}
		else
			[self performSelectorOnMainThread:@selector(displayError:) withObject:@"could not identify, perhaps bad login/password ?" waitUntilDone:NO];
	}
	else {
		NSString* message = nil;
		if (httpRequest.status == iAUMResponseCantLogin)
			message = @"Wrong login or password";
		else if (httpRequest.status == iAUMResponseApiError || httpRequest.status == iAUMResponseAumError)
			message = @"Some kind of server error, please try later";
		else
			message = @"ball in API/App, sux :/";
		[self performSelectorOnMainThread:@selector(displayError:) withObject:message waitUntilDone:NO];
	}
	[self performSelectorOnMainThread:@selector(signInEnded:) withObject:[NSNumber numberWithBool:result] waitUntilDone:NO];
	[httpRequest release];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	if (textField.returnKeyType == UIReturnKeyDone)
		[textField resignFirstResponder];
	else if (textField.returnKeyType == UIReturnKeyNext)
		[self.passwordTextField becomeFirstResponder];
	return YES;
}

- (void)displayError:(NSString*)message
{
	self.alertView.message = message;
	[self.alertView show];
	/*/
	UIView* brol = [[UIView alloc] initWithFrame:CGRectMake(20.0, -100.0, 240.0, 80.0)];
	brol.alpha = 0;
	UILabel* proute = [[UILabel alloc] initWithFrame:brol.frame];
	proute.text = message;
	[brol addSubview:proute];
	[self.view addSubview:brol];
	[UIView beginAnimations:@"rofl" context:nil];
	[UIView setAnimationDuration:1];
	brol.layer.transform = CATransform3DMakeTranslation(0, 300.0, 0);
	brol.alpha = 1;
	[UIView commitAnimations];
	[UIView beginAnimations:@"rofl2" context:nil];
	[UIView setAnimationDuration:1];
	[UIView setAnimationDelay:3];
	brol.layer.transform = CATransform3DMakeTranslation(0, -300.0, 0);
	brol.alpha = 0;
	[UIView commitAnimations];
	[proute release];
	[brol release];
	//*/
	NSLog(@"%@", message);
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
	[self.activityIndicator release];
	[self.loginTextField release];
	[self.passwordTextField release];
	[self.signinButton release];
	[self.tmp release];
	[self.alertView release];
    [super dealloc];
}


@end

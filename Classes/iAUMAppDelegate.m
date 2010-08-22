//
//  iAUMAppDelegate.m
//  iAUM
//
//  Created by dirk on 8/08/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "iAUMAppDelegate.h"
#import "iAUMSettings.h"
#import "SettingsViewController.h"
#import "VisitsViewController.h"
#import "BasketViewController.h"
#import "SigninViewController.h"
#import "ThreadListViewController.h"
#import "iAUMCache.h"

@implementation iAUMAppDelegate

@synthesize window, tabBar;


#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    [application setStatusBarStyle:UIStatusBarStyleBlackOpaque];
	
	if ([iAUMCache initCache] == NO)
		NSLog(@"cache init chied");
    // Override point for customization after application launch.
	self.tabBar = [[UITabBarController alloc] init];
	[self.tabBar release];
	SettingsViewController* settingsVC = [[SettingsViewController alloc] initWithStyle:UITableViewStyleGrouped];

	CharmsViewController* charmsVC = [[CharmsViewController alloc] init];
	UINavigationController* charmsNC = [[UINavigationController alloc] initWithRootViewController:charmsVC];
	charmsNC.navigationBar.tintColor = [UIColor darkGrayColor];

	VisitsViewController* visitsVC = [[VisitsViewController alloc] init];
	UINavigationController* visitsNC = [[UINavigationController alloc] initWithRootViewController:visitsVC];
	visitsNC.navigationBar.tintColor = [UIColor darkGrayColor];

	BasketViewController* basketsVC = [[BasketViewController alloc] init];
	UINavigationController* basketsNC = [[UINavigationController alloc] initWithRootViewController:basketsVC];
	basketsNC.navigationBar.tintColor = [UIColor darkGrayColor];
	
	ThreadListViewController* mailListVC = [[ThreadListViewController alloc] init];
	UINavigationController* mailsNC = [[UINavigationController alloc] initWithRootViewController:mailListVC];
	mailsNC.navigationBar.tintColor = [UIColor darkGrayColor];

	NSArray* viewControllers = [[NSArray alloc] initWithObjects:charmsNC, visitsNC, basketsNC, mailsNC, settingsVC, nil];

	[self.tabBar setViewControllers:viewControllers animated:YES];
	self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	[self.window addSubview:self.tabBar.view];
    [self.window makeKeyAndVisible];	
	[viewControllers release];
	[settingsVC release];
	[charmsVC release];
	[charmsNC release];
	[visitsVC release];
	[visitsNC release];
	[basketsVC release];
	[basketsNC release];
	[mailListVC release];
	[mailsNC release];
	if ([iAUMSettings get:kAppSettingsAumId] == nil)
		[self showSignInScreen];
	return YES;
}

- (void)showSignInScreen
{
	SigninViewController* signinVC = [[SigninViewController alloc] init];
	[self.tabBar presentModalViewController:signinVC animated:NO];
	[signinVC release];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
    [self.window release];
	[self.tabBar release];
    [super dealloc];
}


@end

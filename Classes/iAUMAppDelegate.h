//
//  iAUMAppDelegate.h
//  iAUM
//
//  Created by dirk on 8/08/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CharmsViewController.h"

@interface iAUMAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	UITabBarController* tabBar;
}

@property (nonatomic, retain) UIWindow *window;
@property (nonatomic, retain) UITabBarController *tabBar;

- (void)showSignInScreen;
- (void)initControllers;

@end


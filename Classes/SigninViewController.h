//
//  SigninViewController.h
//  iAUM
//
//  Created by John Doe on 18/08/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SigninViewController : UIViewController <UITextFieldDelegate, UIAlertViewDelegate> {
	UITextField* loginTextField;
	UITextField* passwordTextField;
	UIButton* signinButton;
	UIActivityIndicatorView* activityIndicator;
	UILabel* tmp;
	UIAlertView* alertView;
}

@property (nonatomic, retain) UITextField* loginTextField;
@property (nonatomic, retain) UITextField* passwordTextField;
@property (nonatomic, retain) UIButton* signinButton;
@property (nonatomic, retain) UIActivityIndicatorView* activityIndicator;
@property (nonatomic, assign) UILabel* tmp;
@property (nonatomic, retain) UIAlertView* alertView;

- (UITextField*)buildSigninTextField:(NSString*)placeholder withFrame:(CGRect)frame;
- (IBAction)signIn;
- (BOOL)remoteSignIn;
- (void)displayError:(NSString *)message;

@end

//
//  iAUMListLoadingView.h
//  iAUM
//
//  Created by John Doe on 18/08/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface iAUMListLoadingView : UIView {
	UIActivityIndicatorView* activityIndicator;
	UILabel* statusLabel;
}

@property (nonatomic, retain) UIActivityIndicatorView* activityIndicator;
@property (nonatomic, retain) UILabel* statusLabel;

- (void) isLoading:(BOOL)loading;

@end

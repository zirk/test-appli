//
//  iAUMListLoadingView.m
//  iAUM
//
//  Created by John Doe on 18/08/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "iAUMListLoadingView.h"
#import "iAUMConstants.h"

@implementation iAUMListLoadingView

@synthesize activityIndicator, statusLabel;

- (id)init {
	CGRect frame = CGRectMake(0, -kAppListCellHeight, [UIScreen mainScreen].bounds.size.width, kAppListCellHeight);
    if ((self = [super initWithFrame:frame])) {
        // Initialization code
		self.statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 50.0, frame.size.width, 25.0)];
		[self.statusLabel release];
		self.statusLabel.text = @"PULL TO UPDATE";
		self.statusLabel.textAlignment = UITextAlignmentCenter;
		self.statusLabel.textColor = [UIColor whiteColor];
		self.statusLabel.shadowOffset = CGSizeMake(1, 1);
		self.statusLabel.shadowColor = [UIColor blackColor];
		self.statusLabel.backgroundColor = [UIColor clearColor];
		self.statusLabel.font = [UIFont boldSystemFontOfSize:15];
		self.activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(147.5, 20.0, 25.0, 25.0)];
		[self.activityIndicator release];
		self.activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
		self.activityIndicator.hidesWhenStopped = YES;
		[self addSubview:self.activityIndicator];
		[self addSubview:self.statusLabel];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)isLoading:(BOOL)loading
{
	if (loading)
	{
		self.statusLabel.text = @"UPDATING...";
		[self.activityIndicator startAnimating];
	}
	else
	{
		self.statusLabel.text = @"PULL TO UPDATE";
		[self.activityIndicator stopAnimating];
	}
}

- (void)dealloc {
	[self.statusLabel release];
	[self.activityIndicator release];
    [super dealloc];
}


@end

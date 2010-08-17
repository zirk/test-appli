//
//  MiniProfileCellActionViewVisits.m
//  iAUM
//
//  Created by John Doe on 17/08/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MiniProfileCellActionViewVisits.h"


@implementation MiniProfileCellActionViewVisits

- (id)init {
    if ((self = [super init])) {
		[self build];
    }
    return self;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 [super drawRect: rect];
 }
 */

- (void)build
{
	[super build];
	// background image
	self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"actionViewVisitBgPattern.png"]];
	[self placeButtons];
}

- (void)disableButtons
{
	[super disableButtons];
	//[self buttonForName:@"CharmAccept"].enabled = NO;
}

- (void)enableButtons
{
	[super enableButtons];
	//[self buttonForName:@"CharmAccept"].enabled = YES;
}

- (void)dealloc {
    [super dealloc];
}

@end

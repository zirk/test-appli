//
//  MiniProfileCellActionViewCharms.m
//  iAUM
//
//  Created by John Doe on 16/08/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "iAUMConstants.h"
#import "MiniProfileCellActionViewCharms.h"

@implementation MiniProfileCellActionViewCharms

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
	self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"actionViewCharmBgPattern.png"]];

	//accept charm
	[self addButton:@"CharmAccept" withTitle:@"Accepter le charme"];
	[self addButton:@"CharmRefuse" withTitle:@"Refuser le charme"];
	[self placeButtons];

}

- (void)disableButtons
{
	[super disableButtons];
	[self buttonForName:@"CharmAccept"].enabled = NO;
	[self buttonForName:@"CharmRefuse"].enabled = NO;
}

- (void)enableButtons
{
	[super enableButtons];
	[self buttonForName:@"CharmAccept"].enabled = YES;
	[self buttonForName:@"CharmRefuse"].enabled = YES;
}

- (void)dealloc {
    [super dealloc];
}

@end

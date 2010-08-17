//
//  MiniProfileCellActionViewCharms.m
//  iAUM
//
//  Created by John Doe on 16/08/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "iAUMConstants.h"
#import "MiniProfileCellActionViewCharms.h"
#import <QuartzCore/QuartzCore.h>
#import <CoreGraphics/CoreGraphics.h>

@implementation MiniProfileCellActionViewCharms

@synthesize acceptButton, refuseButton, viewProfileButton;

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
		[self build];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
	[super drawRect: rect];
	// gorgeous inner glow
	CGContextRef currentContext = UIGraphicsGetCurrentContext();
	CGContextSaveGState(currentContext);
	size_t shadowGradientNumLocations = 3;
	CGFloat shadowGradientLocations[3] = {0.0, 0.5, 1.0};
	CGFloat shadowGradientComponents[12] = {
		0.0, 0.0, 0.0, 0.9, // Start color
		0.0, 0.0, 0.0, 0.5,
		0.0, 0.0, 0.0, 0.9}; // End color
	CGPoint shadowGradientStartPoint, shadowGradientEndPoint;
	CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
	CGGradientRef shadowGradient = CGGradientCreateWithColorComponents(colorspace, shadowGradientComponents, shadowGradientLocations, shadowGradientNumLocations);

	shadowGradientStartPoint.x = 0.0;
	shadowGradientStartPoint.y = 0.0;
	shadowGradientEndPoint.x = 0.0;
	shadowGradientEndPoint.y = kAppListCellHeight;
	CGContextDrawLinearGradient(currentContext, shadowGradient, shadowGradientStartPoint, shadowGradientEndPoint, 0);
	CGGradientRelease(shadowGradient);
	CGColorSpaceRelease(colorspace);
	CGContextRestoreGState(currentContext);
}


- (void)build
{
	// background image
	self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"actionViewCharmBgPattern.png"]];
		
	//accept charm
	self.acceptButton = [UIButton buttonWithType:UIButtonTypeCustom];
	self.acceptButton.frame = CGRectMake(10.0, 10.0, 30.0, 30.0);
	[self.acceptButton setImage:[UIImage imageNamed:@"actionViewCharmAcceptNormal.png"] forState:UIControlStateNormal];
	[self.acceptButton setImage:[UIImage imageNamed:@"actionViewCharmAcceptHighlighted.png"] forState:UIControlStateHighlighted];
	[self.acceptButton setImage:[UIImage imageNamed:@"actionViewCharmAcceptSelected.png"] forState:UIControlStateSelected];
	[self.acceptButton setTitle:@"accepter" forState:UIControlStateNormal];

	//refuse charm
	self.refuseButton = [UIButton buttonWithType:UIButtonTypeCustom];
	self.refuseButton.frame = CGRectMake(50.0, 10.0, 100.0, 50.0);
	[self.refuseButton setTitle:@"refuser" forState:UIControlStateNormal];

	//view profile
	self.viewProfileButton = [UIButton buttonWithType:UIButtonTypeCustom];
	self.viewProfileButton.frame = CGRectMake(170.0, 10.0, 50.0, 50.0);
	[self.viewProfileButton setImage:[UIImage imageNamed:@"actionViewProfile.png"] forState:UIControlStateNormal];
	[self.viewProfileButton setTitle:@"voir profil" forState:UIControlStateNormal];

	//write message
	
	[self addSubview:self.acceptButton];
	[self addSubview:self.refuseButton];
	[self addSubview:self.viewProfileButton];
	
	
}

- (void)disableButtons
{
	self.acceptButton.enabled = NO;
	self.refuseButton.enabled = NO;
}

- (void)enableButtons
{
	self.acceptButton.enabled = YES;
	self.refuseButton.enabled = YES;
}

- (void)dealloc {
    [super dealloc];
	[self.acceptButton release];
	[self.refuseButton release];
	[self.viewProfileButton release];
}


@end

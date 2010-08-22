//
//  iAUMCell.m
//  iAUM
//
//  Created by John Doe on 21/08/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "iAUMCell.h"
#import <QuartzCore/QuartzCore.h>

@implementation iAUMCell

@synthesize currentView, actionView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
		self.currentView = iAUMCellViewTypeContent;
    }
    return self;
}

-(void) displayContentView:(BOOL) animate
{
	if(self.currentView != iAUMCellViewTypeContent) {
		self.currentView = iAUMCellViewTypeContent;
		[[self.cellView viewWithTag:iAUMCellViewTypeAction] removeFromSuperview];
		if(animate)
		{
			CATransition *applicationLoadViewIn = [CATransition animation];
			[applicationLoadViewIn setDuration:0.3];
			[applicationLoadViewIn setType:kCATransitionPush];
			[applicationLoadViewIn setSubtype:kCATransitionFromLeft];
			[applicationLoadViewIn setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
			[[self.cellView layer] addAnimation:applicationLoadViewIn forKey:kCATransitionReveal];
		}
		[self setNeedsDisplay];
	}
}

- (void) displayActionView:(BOOL) animate
{
	if (self.currentView != iAUMCellViewTypeAction) {
		self.currentView = iAUMCellViewTypeAction;
		if(animate)
		{
			CATransition *applicationLoadViewIn = [CATransition animation];
			[applicationLoadViewIn setDuration:0.3];
			[applicationLoadViewIn setType:kCATransitionPush];
			[applicationLoadViewIn setSubtype:kCATransitionFromRight];
			[applicationLoadViewIn setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
			[[self.cellView layer] addAnimation:applicationLoadViewIn forKey:kCATransitionReveal];
		}
		[self.cellView addSubview:self.actionView];
		[self setNeedsDisplay];
	}
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
	
    [super setSelected:selected animated:animated];
	[self setSelectionStyle:UITableViewCellSelectionStyleNone];
    // Configure the view for the selected state
}

- (void) drawContentView:(CGRect)r
{
	[[UIColor redColor] set];
	[@"iAUMCell::drawContentView" drawAtPoint:CGPointZero withFont:[UIFont systemFontOfSize:15]];
	NSLog(@"iAUMCell::drawContentView sayz : \"pliz overide me :( kthxbye\"");
}

- (void) loadObject:(id)object
{
	NSLog(@"iAUMCell::loadObject sayz : \"pliz overide me :( kthxbye\"\nbtw here's the object :\n%@", object);
}

- (void)dealloc {
	[self.actionView release];
	[super dealloc];
}

@end

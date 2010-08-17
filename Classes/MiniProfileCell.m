//
//  MiniProfileCell.m
//  iAUM
//
//  Created by dirk on 11/08/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "iAUMCache.h"
#import "iAUMConstants.h"
#import "MiniProfileCell.h"
#import <QuartzCore/QuartzCore.h>

@implementation MiniProfileCell

@synthesize name, city, age, picture, online, currentView, actionView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
		self.online = NO;
		self.currentView = MiniProfileViewTypeProfile;
    }
    return self;
}

-(void) displayProfileViewWithTransition:(BOOL) animate
{
	if(self.currentView != MiniProfileViewTypeProfile) {
		self.currentView = MiniProfileViewTypeProfile;
		[[self.cellView viewWithTag:MiniProfileViewTypeAction] removeFromSuperview];
		if(animate)
		{
			CATransition *applicationLoadViewIn = [CATransition animation];
			[applicationLoadViewIn setDuration:0.4];
			[applicationLoadViewIn setType:kCATransitionPush];
			[applicationLoadViewIn setSubtype:kCATransitionFromLeft];
			[applicationLoadViewIn setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
			[[self.cellView layer] addAnimation:applicationLoadViewIn forKey:kCATransitionReveal];
		}
		[self setNeedsDisplay];
	}
}

- (void) displayActionViewWithTransition:(BOOL) animate
{
	if (self.currentView != MiniProfileViewTypeAction) {
		self.currentView = MiniProfileViewTypeAction;
		if(animate)
		{
			CATransition *applicationLoadViewIn = [CATransition animation];
			[applicationLoadViewIn setDuration:0.4];
			[applicationLoadViewIn setType:kCATransitionPush];
			[applicationLoadViewIn setSubtype:kCATransitionFromRight];
			[applicationLoadViewIn setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
			[[self.cellView layer] addAnimation:applicationLoadViewIn forKey:kCATransitionReveal];
		}
		[self.cellView addSubview:self.actionView];
		[self setNeedsDisplay];
	}
	
}

- (void) loadFromDictionary:(NSDictionary*)dico
{
	NSString* tmp;
	tmp = [dico objectForKey:@"name"];
	if ([tmp isKindOfClass:[NSNull class]] == NO)
		self.name = tmp;
	tmp = [dico objectForKey:@"age"];
	if ([tmp isKindOfClass:[NSNull class]] == NO)
		self.age = tmp;
	tmp = [dico objectForKey:@"city"];
	if ([tmp isKindOfClass:[NSNull class]] == NO)
		self.city = tmp;
	iAUMCache* cache = [[iAUMCache alloc] init];
	[cache loadImage:[dico objectForKey:@"pictureUrl"] forObject:self];
	[cache release];
	[self setNeedsDisplay];
}

-(void) setImage:(UIImage*) image
{
	self.picture = image;
	[self setNeedsDisplay];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
	
    [super setSelected:selected animated:animated];
	[self setSelectionStyle:UITableViewCellSelectionStyleNone];
    // Configure the view for the selected state
}

- (void)drawContentView:(CGRect)r
{
	if (self.currentView == MiniProfileViewTypeAction)
		return ;
	CGContextRef context = UIGraphicsGetCurrentContext();
	UIColor *backgroundColor = [UIColor whiteColor];
	UIColor *textColor = [UIColor blackColor];

	[backgroundColor set];
	CGContextFillRect(context, r);
	
	CGPoint p;
	p.x = 0;
	p.y = 0;
	[self.picture drawInRect:CGRectMake(0.0, 0.0, kAppListCellHeight, kAppListCellHeight)];
	
	[textColor set];

	p.x += kAppListCellHeight + 6; // space between words
	[self.name drawAtPoint:p withFont:[UIFont boldSystemFontOfSize:20]];
	p.y += 25;
	[self.age drawAtPoint:p withFont:[UIFont systemFontOfSize:15]];
	p.y += 20;
	[self.city drawAtPoint:p withFont:[UIFont systemFontOfSize:15]];

	//‰CGContextRelease(context);
}

- (void)dealloc {
	[self.name release];
	[self.city release];
	[self.age release];
	[self.picture release];
	[self.actionView release];
    [super dealloc];
}


@end

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
#import "iAUMCGEffects.h"
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
			[applicationLoadViewIn setDuration:0.3];
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

- (void) loadFromDictionary:(NSDictionary*)dico
{
	self.name = [dico objectForKey:@"name"];
	self.age = [dico objectForKey:@"age"];
	self.city = [dico objectForKey:@"city"];
	self.online = [[dico objectForKey:@"online"] boolValue];
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
	if (self.currentView != MiniProfileViewTypeProfile)
		return ;
	CGContextRef context = UIGraphicsGetCurrentContext();
	[[UIColor colorWithPatternImage:[UIImage imageNamed:@"MiniProfileCellBgPattern.png"]] set];
	CGContextFillRect(context, r);
	[iAUMCGEffects drawWithShadow:@selector(drawCellContent) onTarget:self inContext:context];
}

- (void)drawCellContent
{
	CGRect imageFrame = CGRectMake(0.0, 0.0, kAppListCellHeight, kAppListCellHeight);
	[[iAUMCGEffects roundCornersOfImage:self.picture withRadius:8.0] drawInRect:imageFrame];
	[[UIImage imageNamed:@"MiniProfileCellPictureGlare.png"] drawInRect:imageFrame];
	imageFrame = CGRectMake(295.0, 5.0, 21.0, 21.0);
	if (self.online == YES)
		[[UIImage imageNamed:@"MiniProfileCellStatusOnline.png"] drawInRect:imageFrame];
	else
		[[UIImage imageNamed:@"MiniProfileCellStatusOffline.png"] drawInRect:imageFrame];
	CGPoint p = CGPointMake(kAppListCellHeight + 10.0, 4.0);
	[[UIColor whiteColor] set];
	[self.name drawAtPoint:p withFont:[UIFont boldSystemFontOfSize:20]];
	p.y += 25;
	[[UIColor lightGrayColor] set];
	[self.age drawAtPoint:p withFont:[UIFont systemFontOfSize:15]];
	p.y += 20;
	[self.city drawAtPoint:p withFont:[UIFont systemFontOfSize:15]];
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

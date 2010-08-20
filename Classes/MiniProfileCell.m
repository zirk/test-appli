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
	static CGRect imageFrame;
	static CGContextRef context = nil;
	static UIImage* background = nil;
	static UIImage* glassPictureCover = nil;
	if (context == nil) {
		imageFrame = CGRectMake(0.0, 0.0, kAppListCellHeight, kAppListCellHeight);
		context = UIGraphicsGetCurrentContext();
		background = [UIImage imageNamed:@"MiniProfileCellBgPattern.png"];
		glassPictureCover = [UIImage imageNamed:@"MiniProfileCellPictureGlare.png"];
	}
	[[UIColor colorWithPatternImage:background] set];
	CGContextFillRect(context, r);
	[iAUMCGEffects drawWithShadow:@selector(drawCellContent) onTarget:self inContext:context];
	[glassPictureCover drawInRect:imageFrame];
}

- (void)drawCellContent
{
	static UIImage* onlineIcon = nil;
	static UIImage* offlineIcon = nil;
	static CGRect pictureFrame;
	static CGRect iconFrame;
	static UIFont* nameFont = nil;
	static UIFont* ageFont = nil;
	static UIFont* cityFont = nil;
	if (onlineIcon == nil) {
		pictureFrame = CGRectMake(0.0, 0.0, kAppListCellHeight, kAppListCellHeight);
		iconFrame = CGRectMake(295.0, 5.0, 21.0, 21.0);
		onlineIcon = [UIImage imageNamed:@"MiniProfileCellStatusOnline.png"];
		offlineIcon = [UIImage imageNamed:@"MiniProfileCellStatusOffline.png"];
		nameFont = [UIFont boldSystemFontOfSize:20];
		ageFont = [UIFont systemFontOfSize:15];
		cityFont = ageFont;
	}

	[[iAUMCGEffects roundCornersOfImage:self.picture withRadius:18.18] drawInRect:pictureFrame];

	if (self.online == YES)
		[onlineIcon drawInRect:iconFrame];
	else
		[offlineIcon drawInRect:iconFrame];
	[[UIColor whiteColor] set];
	CGPoint p = CGPointMake(kAppListCellHeight + 10.0, 4.0);
	[self.name drawAtPoint:p withFont:nameFont];
	p.y += 25;
	[[UIColor lightGrayColor] set];
	[self.age drawAtPoint:p withFont:ageFont];
	p.y += 20;
	[self.city drawAtPoint:p withFont:cityFont];
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

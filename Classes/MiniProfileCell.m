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

@synthesize picture, profile;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
		self.profile = nil;
		self.picture = nil;
    }
    return self;
}

-(void) setImage:(UIImage *)image
{
	self.picture = image;
	[self setNeedsDisplay];
}

-(void) loadObject:(id)object
{
	self.profile = (iAUMModelMiniProfile*)object;
	iAUMCache* cache = [[iAUMCache alloc] init];
	[cache loadImage:self.profile.pictureUrl forObject:self];
	[cache release];
	[self setNeedsDisplay];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
	
    [super setSelected:selected animated:animated];
	[self setSelectionStyle:UITableViewCellSelectionStyleNone];
    // Configure the view for the selected state
}

- (void)drawContentView:(CGRect)r
{
	if (self.currentView != iAUMCellViewTypeContent)
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
	static UIColor* nameColor = nil;
	if (onlineIcon == nil) {
		pictureFrame = CGRectMake(0.0, 0.0, kAppListCellHeight, kAppListCellHeight);
		iconFrame = CGRectMake(295.0, 5.0, 21.0, 21.0);
		onlineIcon = [UIImage imageNamed:@"MiniProfileCellStatusOnline.png"];
		offlineIcon = [UIImage imageNamed:@"MiniProfileCellStatusOffline.png"];
		nameFont = [UIFont boldSystemFontOfSize:20];
		ageFont = [UIFont systemFontOfSize:15];
		cityFont = ageFont;
		nameColor = [[UIColor colorWithRed:0.4 green:0.7 blue:1.0 alpha:1.0] retain];
	}

	[[iAUMCGEffects roundCornersOfImage:self.picture withRadius:18.18] drawInRect:pictureFrame];

	if ([self.profile isOnline] == YES)
		[onlineIcon drawInRect:iconFrame];
	else
		[offlineIcon drawInRect:iconFrame];
	[nameColor set];
	CGPoint p = CGPointMake(kAppListCellHeight + 10.0, 4.0);
	[self.profile.name drawAtPoint:p withFont:nameFont];
	p.y += 25;
	[[UIColor lightGrayColor] set];
	[self.profile.age drawAtPoint:p withFont:ageFont];
	p.y += 20;
	[self.profile.city drawAtPoint:p withFont:cityFont];
}

- (void)dealloc {
	[self.picture release];
	[self.profile release];
    [super dealloc];
}

@end

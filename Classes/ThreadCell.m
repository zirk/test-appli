//
//  ThreadCell.m
//  iAUM
//
//  Created by John Doe on 22/08/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ThreadCell.h"
#import "iAUMCache.h"
#import "iAUMCGEffects.h"
#import "iAUMConstants.h"

@implementation ThreadCell

@synthesize thread, picture;

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
	static CGRect pictureFrame;
	static CGRect iconFrame;
	static UIFont* nameFont = nil;
	static UIFont* ageFont = nil;
	static UIFont* cityFont = nil;
	static UIColor* nameColor = nil;
	if (nameFont == nil) {
		pictureFrame = CGRectMake(0.0, 0.0, kAppListCellHeight, kAppListCellHeight);
		iconFrame = CGRectMake(295.0, 5.0, 21.0, 21.0);
		nameFont = [UIFont boldSystemFontOfSize:20];
		ageFont = [UIFont systemFontOfSize:15];
		cityFont = ageFont;
		nameColor = [[UIColor colorWithRed:0.4 green:0.7 blue:1.0 alpha:1.0] retain];
	}
	
	[[iAUMCGEffects roundCornersOfImage:self.picture withRadius:18.18] drawInRect:pictureFrame];

	[nameColor set];
	CGPoint p = CGPointMake(kAppListCellHeight + 10.0, 4.0);
	[self.thread.contact.name drawAtPoint:p withFont:nameFont];
	[[UIColor lightGrayColor] set];
	CGSize dateSize = [self.thread.date sizeWithFont:ageFont];
	p.x = self.cellView.frame.size.width - 5 - dateSize.width;
	[self.thread.date drawAtPoint:p withFont:ageFont];
	p.x = kAppListCellHeight + 10.0;
	p.y += 25;
	//[self.thread.preview drawAtPoint:p withFont:ageFont];
	[self.thread.preview drawInRect:CGRectMake(p.x, p.y, self.cellView.frame.size.width - 10 - kAppListCellHeight, 40) withFont:ageFont lineBreakMode:UILineBreakModeWordWrap];
}

-(void) setImage:(UIImage*)newPicture
{
	self.picture = newPicture;
	[self setNeedsDisplay];
}

-(void) loadObject:(id)object
{
	self.thread = (iAUMModelThread*)object;
	iAUMCache* cache = [[iAUMCache alloc] init];
	[cache loadImage:self.thread.contact.pictureUrl forObject:self];
	[cache release];
	[self setNeedsDisplay];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
	
    [super setSelected:selected animated:animated];
	[self setSelectionStyle:UITableViewCellSelectionStyleNone];
    // Configure the view for the selected state
}

- (void) dealloc
{
	[self.thread release];
	[self.picture release];
	[super dealloc];
}

@end

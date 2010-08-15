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

@synthesize name, city, age, picture, online, currentView, profileView, actionView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
		self.online = NO;
		self.currentView = MiniProfileViewTypeProfile;
		[self initViews];
    }
    return self;
}

- (void) initViews
{
	/*
	self.profileView = [[[UIView alloc] initWithFrame:[self.contentView frame]] autorelease];
	self.profileView.tag = MiniProfileViewTypeProfile;
	self.pictureView = [[[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, kAppListCellHeight, kAppListCellHeight)] autorelease];
	self.pictureView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
	[self.profileView addSubview:self.pictureView];

	self.nameLabel = [[[UILabel alloc] initWithFrame:CGRectMake(self.pictureView.frame.origin.x + self.pictureView.frame.size.width + 10.0, 0.0, 220.0, 15.0)] autorelease];
	self.nameLabel.font = [UIFont systemFontOfSize:14.0];
	self.nameLabel.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
	self.nameLabel.text = @"PD";
	[self.profileView addSubview:self.nameLabel];
	
	
	self.ageLabel = [[[UILabel alloc] initWithFrame:CGRectMake(self.pictureView.frame.origin.x + self.pictureView.frame.size.width + 10.0, 20.0, 220.0, 25.0)] autorelease];
	self.ageLabel.font = [UIFont systemFontOfSize:12.0];
	self.ageLabel.textColor = [UIColor darkGrayColor];
	self.ageLabel.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
	[self.profileView addSubview:self.ageLabel];
	
	self.cityLabel = [[[UILabel alloc] initWithFrame:CGRectMake(self.pictureView.frame.origin.x + self.pictureView.frame.size.width + 10.0, 40.0, 220.0, 25.0)] autorelease];
	self.cityLabel.font = [UIFont systemFontOfSize:12.0];
	self.cityLabel.textColor = [UIColor darkGrayColor];
	self.cityLabel.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
	[self.profileView addSubview:self.cityLabel];
	
	UIGraphicsBeginImageContext(self.contentView.frame.size);
	[self.profileView.layer renderInContext:UIGraphicsGetCurrentContext()];

	self.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	//UIImageView* iv = [[UIImageView alloc] initWithFrame:self.contentView.frame];
	//iv.image = viewImage;
	//[self.contentView addSubview:iv];
//	[self.contentView addSubview:self.profileView];
	*/

}

-(void) displayProfileViewWithTransition:(BOOL) animate
{
	NSInteger cView = self.currentView;
	self.currentView = MiniProfileViewTypeProfile;
	if(cView != MiniProfileViewTypeProfile){
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
	NSInteger cView = self.currentView;
	self.currentView = MiniProfileViewTypeAction;
	if (cView != MiniProfileViewTypeAction) {
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
	
	CGContextRef context = UIGraphicsGetCurrentContext();
	UIColor *backgroundColor = [UIColor whiteColor];
	UIColor *textColor = [UIColor blackColor];
	
	if (self.currentView == MiniProfileViewTypeAction) {
		[[UIColor whiteColor] set];
		CGContextFillRect(context, r);
	}
	else{
		[backgroundColor set];
		CGContextFillRect(context, r);
		
		CGPoint p;
		p.x = 0;
		p.y = 0;
		[self.picture drawInRect:CGRectMake(0.0, 0.0, kAppListCellHeight, kAppListCellHeight)];
		
		[textColor set];
		
		
		p.x += kAppListCellHeight + 6; // space between words
		[self.name drawAtPoint:p withFont:[UIFont systemFontOfSize:20]];
		p.y += 25;
		[self.age drawAtPoint:p withFont:[UIFont systemFontOfSize:15]];
		p.y += 20;
		[self.city drawAtPoint:p withFont:[UIFont systemFontOfSize:15]];
		
	}
}

- (void)dealloc {
	[self.name release];
	[self.city release];
	[self.age release];
	[self.picture release];
    [super dealloc];
}


@end

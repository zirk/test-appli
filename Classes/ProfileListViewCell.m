//
//  PhysicalView.m
//  iAUM
//
//  Created by dirk on 18/08/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "profileListViewCell.h"
#import "iAUMLabel.h"
#import "iAUMConstants.h"
#import "iAUMCGEffects.h"
#import <QuartzCore/QuartzCore.h>

@implementation ProfileListViewCell

@synthesize  fields;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
		self.selectionStyle = UITableViewCellSelectionStyleNone;
		self.fields = [[[NSMutableDictionary alloc] init] autorelease];
    }
    return self;
}

-(void) setField:(NSString*)fieldName withValue:(NSString*)fieldValue
{
	if(fieldValue != nil && [fieldValue length] > 0){
		[self.fields setObject:fieldValue forKey:fieldName];
		[self setNeedsDisplay];
	}
	

}

-(void)drawContentView:(CGRect)rect
{
	
	// Draws the rounded rectangle needed for the grouped style of the tableview
	// TODO: add border
	CGContextRef context = UIGraphicsGetCurrentContext();
	[[UIColor groupTableViewBackgroundColor] set];
	CGContextFillRect(context, rect);
	
    CGFloat radius = 12;
    CGFloat width = CGRectGetWidth(rect);
    CGFloat height = CGRectGetHeight(rect);
	
    // Make sure corner radius isn't larger than half the shorter side
    if (radius > width/2.0)
        radius = width/2.0;
    if (radius > height/2.0)
        radius = height/2.0;    
	
    CGFloat minx = CGRectGetMinX(rect) + 10;
    CGFloat midx = CGRectGetMidX(rect);
    CGFloat maxx = CGRectGetMaxX(rect) - 10;
    CGFloat miny = CGRectGetMinY(rect);
    CGFloat midy = CGRectGetMidY(rect);
    CGFloat maxy = CGRectGetMaxY(rect);
	
    [[UIColor whiteColor] setFill];
	[[UIColor redColor] setStroke];
	
    CGContextBeginPath(context);
	
    CGContextMoveToPoint(context, minx, midy);
	
    CGContextAddArcToPoint(context, minx, miny, midx, miny, radius);
    CGContextAddArcToPoint(context, maxx, miny, maxx, midy, radius);
    CGContextAddArcToPoint(context, maxx, maxy, midx, maxy, radius);
    CGContextAddArcToPoint(context, minx, maxy, minx, midy, radius);
	
    CGContextClip(context);
    CGContextFillRect(context, rect);
	
	// display values
	CGRect fieldRect =  CGRectMake(15.0, 10.0, 280.0, 10.0);
	UIColor* textColor = [UIColor blackColor];
	[textColor set];
	
	for (NSString* key in [self.fields allKeys]) {
		[key drawInRect:fieldRect withFont:[UIFont systemFontOfSize:15]];
		fieldRect.origin.x += 100.0;
		[((NSString*)[self.fields objectForKey:key]) drawInRect:fieldRect withFont:[UIFont systemFontOfSize:15]];
		fieldRect.origin.y += kProfileCellFieldHeight;
		fieldRect.origin.x = 15.0;
	}
	//[super drawRect:rect];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
	[self.fields release];
    [super dealloc];
}


@end

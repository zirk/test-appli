//
//  iAUMAlertView.m
//  iAUM
//
//  Created by John Doe on 20/08/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "iAUMAlertView.h"
#import <QuartzCore/QuartzCore.h>

@implementation iAUMAlertView


- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        // Initialization code
		self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"MiniProfileCellBGPattern.png"]];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
	rect.origin.x += 2;
	rect.origin.y += 2;
	rect.size.width -= 4;
	rect.size.height -= 4;
	// grab the current view graphics context
	// the context is basically our invisible canvas that we draw into.
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	// Drawing lines with an RGB based color
	CGContextSetRGBStrokeColor(context, 0.3, 0.6, 1.0, 1.0);
	
	// Draw them with a 2.0 stroke width so they are a bit more visible.
	CGContextSetLineWidth(context, 3.0);
	
	// lets set the starting point of our line, at x position 10, and y position 30
	CGContextMoveToPoint(context, 0.0, 0.0);

	CGContextAddRect(context, rect);
	CGContextStrokePath(context);
}


- (void)dealloc {
    [super dealloc];
}


@end

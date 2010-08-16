//
//  iAUMLabel.m
//  iAUM
//
//  Created by Dirk Amadori on 16/08/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "iAUMLabel.h"


@implementation iAUMLabel


- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        [self initStyle];
    }
    return self;
}

- (id)init
{
    if ((self = [super init])) {
		[self initStyle];
    }
    return self;
}

- (void) initStyle
{
	self.shadowColor = [UIColor grayColor];
	self.shadowOffset = CGSizeMake(1,1);
	self.alpha = 25.0;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)dealloc {
    [super dealloc];
}


@end

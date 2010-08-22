//
//  ThreadCell.h
//  iAUM
//
//  Created by John Doe on 22/08/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "iAUMCell.h"
#import "iAUMModelThread.h"

@interface ThreadCell : iAUMCell {
	iAUMModelThread* thread;
	UIImage* picture;
}

@property (nonatomic, retain) iAUMModelThread* thread;
@property (nonatomic, retain) UIImage* picture;

@end

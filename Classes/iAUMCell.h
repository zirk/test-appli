//
//  iAUMCell.h
//  iAUM
//
//  Created by John Doe on 21/08/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ABTableViewCell.h"
#import "iAUMCellActionView.h"

enum iAUMCellViewTypes {
	iAUMCellViewTypeContent = 1,
	iAUMCellViewTypeAction
};

@interface iAUMCell : ABTableViewCell {
	iAUMCellActionView* actionView;
	NSUInteger currentView;
}


@property (nonatomic, assign) NSUInteger currentView;
@property (nonatomic, retain) iAUMCellActionView* actionView;

- (void) drawContentView:(CGRect)r;
- (void) loadObject:(id)object;
- (void) displayContentView:(BOOL)animated;
- (void) displayActionView:(BOOL)animated;


@end

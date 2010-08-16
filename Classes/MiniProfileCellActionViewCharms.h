//
//  MiniProfileCellActionViewCharms.h
//  iAUM
//
//  Created by john doe on 16/08/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MiniProfileCellActionViewCharms : UIView {
	UIButton* acceptButton;
	UIButton* refuseButton;
}

@property (nonatomic, retain) UIButton* acceptButton;
@property (nonatomic, retain) UIButton* refuseButton;

- (void)initButtons;
- (void)enableButtons;
- (void)disableButtons;

@end

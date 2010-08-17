//
//  MiniProfileActionView.h
//  iAUM
//
//  Created by John Doe on 17/08/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MiniProfileCellActionView : UIView {
	NSMutableDictionary* actionButtons;
	NSMutableArray* actionButtonsOrder;
	UILabel* buttonTitleLabel;
}

@property (nonatomic, retain) NSMutableDictionary* actionButtons;
@property (nonatomic, retain) NSMutableArray* actionButtonsOrder;
@property (nonatomic, retain) UILabel* buttonTitleLabel;

- (void)build;
- (void)addButton:(NSString*)name withTitle:(NSString*)title;
- (UIButton*)buttonForName:(NSString*)name;
- (void)removeButton:(NSString*)name;
- (void)removeAllButtons;
- (void)placeButtons;
- (void)disableButtons;
- (void)enableButtons;

@end

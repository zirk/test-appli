//
//  iAUMImageViewer.h
//  iAUM
//
//  Created by Dirk Amadori on 16/08/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface iAUMImageViewer : UIViewController {
	NSMutableArray* imageViews;
	UIButton* exitButton;
}

@property(retain) NSMutableArray* imageViews;
@property(retain) UIButton* exitButton;

- (void) addImage:(NSString*)imageUrl;
- (void) gedaoude;

@end

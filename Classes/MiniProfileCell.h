//
//  MiniProfileCell.h
//  iAUM
//
//  Created by dirk on 11/08/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ABTableViewCell.h"
#import "MiniProfileCellActionView.h"

enum MiniProfileViewType {
	MiniProfileViewTypeProfile = 1,
	MiniProfileViewTypeAction
};

@interface MiniProfileCell : ABTableViewCell {
	MiniProfileCellActionView* actionView;

	NSUInteger currentView;

	NSString* name;
	NSString* city;
	NSString* age;
	BOOL online;
	UIImage* picture;
}

@property (nonatomic, retain) NSString* name;
@property (nonatomic, retain) NSString* city;
@property (nonatomic, retain) NSString* age;
@property (nonatomic, assign) BOOL online;
@property (nonatomic, assign) NSUInteger currentView;
@property (nonatomic, retain) UIImage* picture;

@property (nonatomic, retain) MiniProfileCellActionView* actionView;

- (void) loadFromDictionary:(NSDictionary *)dico;
- (void) displayProfileViewWithTransition:(BOOL) animated;
- (void) displayActionViewWithTransition:(BOOL) animated;

@end

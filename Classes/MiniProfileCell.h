//
//  MiniProfileCell.h
//  iAUM
//
//  Created by dirk on 11/08/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ABTableViewCell.h"

enum MiniProfileViewType {
	Dummy, MiniProfileViewTypeProfile, MiniProfileViewTypeAction
};

@interface MiniProfileCell : ABTableViewCell {

	UIView* profileView;
	UIView* actionView;
	
	NSInteger currentView;
	
	NSString *name;
	NSString *city;
	NSString *age;
	BOOL online;
	UIImage *picture;
}

@property (nonatomic, retain) NSString* name;
@property (nonatomic, retain) NSString* city;
@property (nonatomic, retain) NSString* age;
@property (nonatomic, assign) BOOL online;
@property (nonatomic, assign) NSInteger currentView;
@property (nonatomic, retain) UIImage* picture;

@property (nonatomic, retain) UIView* profileView;
@property (nonatomic, retain) UIView* actionView;

- (void) initViews;
- (void) loadFromDictionary:(NSDictionary *)dico;
- (void) displayProfileViewWithTransition:(BOOL) animated;
- (void) displayActionViewWithTransition:(BOOL) animated;

@end

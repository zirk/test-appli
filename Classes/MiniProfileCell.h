//
//  MiniProfileCell.h
//  iAUM
//
//  Created by Dirk Amadori on 11/08/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MiniProfileCell : UITableViewCell {
	UILabel* nameLabel;
	UILabel* cityLabel;
	UILabel* ageLabel;
	BOOL online;
	UIImageView* pictureView;
}

@property (nonatomic, retain) UILabel* nameLabel;
@property (nonatomic, retain) UILabel* cityLabel;
@property (nonatomic, retain) UILabel* ageLabel;
@property (nonatomic, assign) BOOL online;
@property (nonatomic, retain) UIImageView* pictureView;

- (void) initViews;
- (void) loadFromDictionary:(NSDictionary *)dico;

@end

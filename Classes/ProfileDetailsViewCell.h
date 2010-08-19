//
//  ProfileViewCell.h
//  iAUM
//
//  Created by dirk on 16/08/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ABTableViewCell.h"

@interface ProfileDetailsViewCell : UITableViewCell {
	UILabel* nameLabel;
	UILabel* ageLabel;
	UILabel* cityLabel;
	UILabel* popularityLabel;
	UIImageView*  pictureView;
}

@property (retain) UILabel* nameLabel;
@property (retain) UILabel* ageLabel;
@property (retain) UILabel* cityLabel;
@property (retain) UILabel* popularityLabel;

@property (retain) UIImageView*  pictureView;

@end

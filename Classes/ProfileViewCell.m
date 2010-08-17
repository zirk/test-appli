//
//  ProfileViewCell.m
//  iAUM
//
//  Created by dirk on 16/08/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ProfileViewCell.h"
#import "iAUMLabel.h"
#import <QuartzCore/QuartzCore.h>

#define PICTURE_WIDTH 100.0


@implementation ProfileViewCell

@synthesize nameLabel, ageLabel, cityLabel, pictureView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
        // Initialization code
		
		
		self.pictureView = [[[UIImageView alloc] init] autorelease];
		self.pictureView.frame = CGRectMake(0.0, 0.0, 100.0, 100.0);
		self.pictureView.layer.masksToBounds = YES;
		self.pictureView.layer.cornerRadius = 5.0;
		[self.contentView addSubview:self.pictureView];
		
		self.nameLabel = [[[iAUMLabel alloc] init] autorelease];
		self.nameLabel.frame = CGRectMake(110.0, 1.0, 180.0, 20.0);
		[self.contentView addSubview:self.nameLabel];
		
		self.ageLabel = [[[iAUMLabel alloc] init] autorelease];
		self.ageLabel.frame = CGRectMake(110.0, 25.0, 180.0, 20.0);
		[self.contentView addSubview:self.ageLabel];
		
		self.cityLabel = [[[iAUMLabel alloc] init] autorelease];
		self.cityLabel.frame = CGRectMake(110.0, 45.0, 180.0, 20.0);
		[self.contentView addSubview:self.cityLabel];
		
		
		
		
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (void) setImage:(UIImage*) image
{
	self.pictureView.image = image;
}


- (void)dealloc {
	[self.nameLabel release];
	[self.pictureView release];
	[self.ageLabel release];
	[self.cityLabel release];
    [super dealloc];
}


@end

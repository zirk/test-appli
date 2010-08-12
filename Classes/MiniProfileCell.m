//
//  MiniProfileCell.m
//  iAUM
//
//  Created by Dirk Amadori on 11/08/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MiniProfileCell.h"


@implementation MiniProfileCell

@synthesize nameLabel, cityLabel, ageLabel, pictureView, online;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
		self.cityLabel = [[UILabel alloc] init];
		self.online = NO;
		[self initViews];
    }
    return self;
}

- (void) initViews
{
	self.nameLabel = [[[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 220.0, 15.0)] autorelease];
	self.nameLabel.font = [UIFont systemFontOfSize:14.0];
	self.nameLabel.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleHeight;
	[self.contentView addSubview:self.nameLabel];
	
	
	self.ageLabel = [[[UILabel alloc] initWithFrame:CGRectMake(0.0, 20.0, 220.0, 25.0)] autorelease];
	self.ageLabel.font = [UIFont systemFontOfSize:12.0];
	self.ageLabel.textColor = [UIColor darkGrayColor];
	self.ageLabel.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleHeight;
	[self.contentView addSubview:self.ageLabel];
	
	self.pictureView = [[[UIImageView alloc] initWithFrame:CGRectMake(225.0, 0.0, 45.0, 45.0)] autorelease];
	self.pictureView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleHeight;
	[self.contentView addSubview:self.pictureView];
}

- (void) loadFromDictionary:(NSDictionary*)dico
{
    self.nameLabel.text = [dico objectForKey:@"name"];
	self.ageLabel.text = [dico objectForKey:@"age"];
	
	if(self.pictureView.image == nil){
		NSURL *url = [NSURL URLWithString:[dico objectForKey:@"pictureUrl"]];
		NSInvocationOperation* op = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(loadImage:) object:url];
		NSOperationQueue* queue = [NSOperationQueue new];
	
		[queue addOperation:op];
		[op release];
	}
}


-(void) loadImage:(id) url
{
	NSLog(@"loading image @ %@", url);
	UIImage* image = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
	[self performSelectorOnMainThread:@selector(displayImage:) withObject:image waitUntilDone:NO];
}

-(void) displayImage:(id) image
{
	NSLog(@"finished loading!");
	self.pictureView.image = image;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
	
    [super setSelected:selected animated:animated];
	
    // Configure the view for the selected state
}


- (void)dealloc {
	[self.nameLabel release];
	[self.cityLabel release];
	[self.ageLabel release];
	[self.pictureView release];
    [super dealloc];
}


@end
//
//  MiniProfileActionView.m
//  iAUM
//
//  Created by John Doe on 17/08/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MiniProfileCellActionView.h"
#import "iAUMConstants.h"

@implementation MiniProfileCellActionView

@synthesize buttonTitleLabel, actionButtons, actionButtonsOrder, numberOfButtons;

- (id)init {
    if ((self = [super initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, kAppListCellHeight)])) {
		self.numberOfButtons = 0;
		self.actionButtons = [[NSMutableDictionary alloc] init];
		[self.actionButtons release];
		self.actionButtonsOrder = [[NSMutableArray alloc] init];
		[self.actionButtonsOrder release];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
	[super drawRect: rect];
	// gorgeous inner glow
	CGContextRef currentContext = UIGraphicsGetCurrentContext();
	CGContextSaveGState(currentContext);
	size_t shadowGradientNumLocations = 3;
	CGFloat shadowGradientLocations[3] = {0.0, 0.5, 1.0};
	CGFloat shadowGradientComponents[12] = {
	0.0, 0.0, 0.0, 0.7, // Start color
	0.0, 0.0, 0.0, 0.5,
	0.0, 0.0, 0.0, 0.7}; // End color
	CGPoint shadowGradientStartPoint, shadowGradientEndPoint;
	CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
	CGGradientRef shadowGradient = CGGradientCreateWithColorComponents(colorspace, shadowGradientComponents, shadowGradientLocations, shadowGradientNumLocations);

	shadowGradientStartPoint.x = 0.0;
	shadowGradientStartPoint.y = 0.0;
	shadowGradientEndPoint.x = 0.0;
	shadowGradientEndPoint.y = kAppListCellHeight;
	CGContextDrawLinearGradient(currentContext, shadowGradient, shadowGradientStartPoint, shadowGradientEndPoint, 0);
	CGGradientRelease(shadowGradient);
	CGColorSpaceRelease(colorspace);
	CGContextRestoreGState(currentContext);
}

- (void)build
{
	self.backgroundColor = [UIColor grayColor];
	[self addButton:@"ViewProfile" withTitle:@"voir profil"];

	self.buttonTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 40.0, [UIScreen mainScreen].bounds.size.width, 30.0)];
	[self.buttonTitleLabel release];
	self.buttonTitleLabel.textColor = [UIColor whiteColor];
	self.buttonTitleLabel.backgroundColor = [UIColor clearColor];
	self.buttonTitleLabel.textAlignment = UITextAlignmentCenter;
	[self addSubview:self.buttonTitleLabel];
}

- (void)addButton:(NSString *)name withTitle:(NSString*)title
{
	NSLog(@"adding button %@", name);
	UIButton* someButton = [UIButton buttonWithType:UIButtonTypeCustom];
	[someButton setImage:[UIImage imageNamed:[NSString stringWithFormat:@"actionView%@Normal.png", name]] forState:UIControlStateNormal];
	[someButton setImage:[UIImage imageNamed:[NSString stringWithFormat:@"actionView%@Highlighted.png", name]] forState:UIControlStateHighlighted];
	[someButton setImage:[UIImage imageNamed:[NSString stringWithFormat:@"actionView%@Selected.png", name]] forState:UIControlStateSelected];
	[someButton setTitle:title forState:UIControlStateNormal];
	[someButton addTarget:self action:@selector(setLabelText:) forControlEvents:UIControlEventTouchDown];
	[someButton addTarget:self action:@selector(clearLabelText) forControlEvents:UIControlEventTouchUpInside];
	[someButton addTarget:self action:@selector(clearLabelText) forControlEvents:UIControlEventTouchUpOutside];
	[self.actionButtons setObject:someButton forKey:name];
	[self.actionButtonsOrder addObject:name];
	++self.numberOfButtons;
}

- (void)placeButtons
{
	CGSize imageSize = CGSizeZero;
	CGFloat y_offset = 0.0;
	CGFloat x_offset = 0.0;
	for (NSString* buttonName in self.actionButtonsOrder) {
		UIButton* actionButton = [self.actionButtons objectForKey:buttonName];
		if (imageSize.width == 0.0) {
			imageSize = actionButton.imageView.image.size;
			y_offset = (kAppListCellHeight - imageSize.height) / 2.0;
			x_offset = imageSize.width * self.numberOfButtons * 2.0 - imageSize.width;
			x_offset = ([UIScreen mainScreen].bounds.size.width - x_offset) / 2.0;
		}
		actionButton.frame = CGRectMake(x_offset, y_offset, imageSize.width, imageSize.height);
		x_offset += imageSize.width * 2.0;
		NSLog(@"showing button %@", buttonName);
		[self addSubview:actionButton];
	}
}

- (void)removeButton:(NSString *)name
{
	if (self.numberOfButtons < 1)
		return ;
	// in order to be sure that we decrement numberOfButtons ONLY when we remove an existing button
	for (NSString* buttonName in self.actionButtonsOrder)
		if ([name compare:buttonName] == NSOrderedSame) {
			[self.actionButtons removeObjectForKey:name];
			[self.actionButtonsOrder removeObject:name];
			self.numberOfButtons--;
			break ;
		}
}

- (UIButton*)buttonForName:(NSString *)name
{
	return [self.actionButtons objectForKey:name];
}

- (void)removeAllButtons
{
	[self.actionButtons removeAllObjects];
	[self.actionButtonsOrder removeAllObjects];
	self.numberOfButtons = 0;
}

- (void)setLabelText:(UIButton*)sender
{
	self.buttonTitleLabel.text = sender.titleLabel.text;
}

- (void)clearLabelText
{
	self.buttonTitleLabel.text = nil;
}

- (void) disableButtons
{
	
}

- (void) enableButtons
{
	
}

- (void)dealloc {
	[self.actionButtons release];
	[self.actionButtonsOrder release];
	[self.buttonTitleLabel release];
    [super dealloc];
}

@end

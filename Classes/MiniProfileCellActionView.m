//
//  MiniProfileActionView.m
//  iAUM
//
//  Created by John Doe on 17/08/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MiniProfileCellActionView.h"
#import "iAUMConstants.h"
#import <QuartzCore/QuartzCore.h>
#import <CoreGraphics/CoreGraphics.h>

@implementation MiniProfileCellActionView

@synthesize buttonTitleLabel, actionButtons, actionButtonsOrder;

- (id)init {
    if ((self = [super initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, kAppListCellHeight)])) {
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
	size_t shadowGradientNumLocations = 4;
	CGFloat shadowGradientLocations[4] = {0.0, 0.25, 0.75, 1.0};
	CGFloat shadowGradientComponents[16] = {
	0.0, 0.0, 0.0, 0.8, // Start color
	0.0, 0.0, 0.0, 0.5,
	0.0, 0.0, 0.0, 0.5,
	0.0, 0.0, 0.0, 0.8}; // End color
	CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
	CGGradientRef shadowGradient = CGGradientCreateWithColorComponents(colorspace, shadowGradientComponents, shadowGradientLocations, shadowGradientNumLocations);
	CGContextDrawLinearGradient(currentContext, shadowGradient, CGPointZero, CGPointMake(0.0, kAppListCellHeight), 0);
	CGGradientRelease(shadowGradient);
	CGColorSpaceRelease(colorspace);
	CGContextRestoreGState(currentContext);
}

- (void)build
{
	self.backgroundColor = [UIColor grayColor];
	[self addButton:@"ViewProfile" withTitle:@"Voir son profil"];

	self.buttonTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0, -4.0, [UIScreen mainScreen].bounds.size.width, 30.0)];
	[self.buttonTitleLabel release];
	self.buttonTitleLabel.textColor = [UIColor whiteColor];
	self.buttonTitleLabel.shadowColor = [UIColor blackColor];
	self.buttonTitleLabel.shadowOffset = CGSizeMake(2, 2);
	self.buttonTitleLabel.font = [UIFont boldSystemFontOfSize:17.0];
	self.buttonTitleLabel.backgroundColor = [UIColor clearColor];
	self.buttonTitleLabel.textAlignment = UITextAlignmentCenter;
	self.buttonTitleLabel.alpha = 0.0;
	self.buttonTitleLabel.layer.transform = CATransform3DMakeTranslation(0, -7, 0);
	[self addSubview:self.buttonTitleLabel];
}

- (void)addButton:(NSString *)name withTitle:(NSString*)title
{
	UIButton* someButton = [UIButton buttonWithType:UIButtonTypeCustom];
	[someButton setImage:[UIImage imageNamed:[NSString stringWithFormat:@"actionView%@Normal.png", name]] forState:UIControlStateNormal];
	//[someButton setImage:[UIImage imageNamed:[NSString stringWithFormat:@"actionView%@Highlighted.png", name]] forState:UIControlStateHighlighted];
	//[someButton setImage:[UIImage imageNamed:[NSString stringWithFormat:@"actionView%@Selected.png", name]] forState:UIControlStateSelected];
	[someButton setTitle:title forState:UIControlStateNormal];
	/*
	someButton.layer.shadowColor = [UIColor redColor].CGColor;
	someButton.layer.shadowOffset = CGSizeZero;
	someButton.layer.shadowRadius = 2.0;
	someButton.layer.shadowOpacity = 1.0;
	 */
	[someButton addTarget:self action:@selector(setLabelText:) forControlEvents:UIControlEventTouchDown];
	[someButton addTarget:self action:@selector(clearLabelText) forControlEvents:UIControlEventTouchUpInside];
	[someButton addTarget:self action:@selector(clearLabelText) forControlEvents:UIControlEventTouchUpOutside];
	[self.actionButtons setObject:someButton forKey:name];
	[self.actionButtonsOrder addObject:name];
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
			x_offset = imageSize.width * self.actionButtonsOrder.count * 2.0 - imageSize.width;
			x_offset = ([UIScreen mainScreen].bounds.size.width - x_offset) / 2.0;
		}
		actionButton.frame = CGRectMake(x_offset, y_offset, imageSize.width, imageSize.height);
		x_offset += imageSize.width * 2.0;
		actionButton.layer.transform = CATransform3DMakeTranslation(0, 0, 0);
		[self addSubview:actionButton];
	}
}

- (void)removeButton:(NSString *)name
{
	[self.actionButtons removeObjectForKey:name];
	[self.actionButtonsOrder removeObject:name];
}

- (UIButton*)buttonForName:(NSString *)name
{
	return [self.actionButtons objectForKey:name];
}

- (void)removeAllButtons
{
	[self.actionButtons removeAllObjects];
	[self.actionButtonsOrder removeAllObjects];
}

- (void)setLabelText:(UIButton*)sender
{
	self.buttonTitleLabel.text = sender.titleLabel.text;
	[UIView beginAnimations:@"tooltipOpacity" context:nil];
	[UIView setAnimationDuration: 0.3];
	self.buttonTitleLabel.alpha = 1.0;
	self.buttonTitleLabel.layer.transform = CATransform3DMakeTranslation(0, 0, 0);
	[UIView commitAnimations];
}

- (void)clearLabelText
{
	[UIView beginAnimations:@"tooltipOpacity" context:nil];
	[UIView setAnimationDuration: 0.3];
	self.buttonTitleLabel.alpha = 0.0;
	self.buttonTitleLabel.layer.transform = CATransform3DMakeTranslation(0, -7, 0);
	[UIView commitAnimations];
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

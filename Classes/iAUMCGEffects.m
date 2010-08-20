//
//  iAUMCGEffects.m
//  iAUM
//
//  Created by John Doe on 17/08/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "iAUMCGEffects.h"

@implementation iAUMCGEffects

+ (void)addRoundedRectToPath:(CGContextRef)context rect:(CGRect)rect width:(float)ovalWidth height:(float)ovalHeight
{
	float fw, fh;
	if (ovalWidth == 0 || ovalHeight == 0) {
		CGContextAddRect(context, rect);
		return;
	}
	CGContextSaveGState(context);
	CGContextTranslateCTM (context, CGRectGetMinX(rect), CGRectGetMinY(rect));
	CGContextScaleCTM (context, ovalWidth, ovalHeight);
	fw = CGRectGetWidth (rect) / ovalWidth;
	fh = CGRectGetHeight (rect) / ovalHeight;
	CGContextMoveToPoint(context, fw, fh / 2);
	CGContextAddArcToPoint(context, fw, fh, fw / 2, fh, 1);
	CGContextAddArcToPoint(context, 0, fh, 0, fh / 2, 1);
	CGContextAddArcToPoint(context, 0, 0, fw / 2, 0, 1);
	CGContextAddArcToPoint(context, fw, 0, fw, fh / 2, 1);
	CGContextClosePath(context);
	CGContextRestoreGState(context);
}

+ (UIImage*)roundCornersOfImage:(UIImage*)source withRadius:(float)radius
{
	if (source == nil)
		return source;
	if (radius <= 0)
		radius = 0.0001;
	int w = source.size.width;
    int h = source.size.height;
	
	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	CGContextRef context = CGBitmapContextCreate(NULL, w, h, 8, 4 * w, colorSpace, kCGImageAlphaPremultipliedFirst);
	
	CGContextBeginPath(context);
	CGRect rect = CGRectMake(0, 0, w, h);
	// Set the oval width and height to be quarter of the image width and height
	[iAUMCGEffects addRoundedRectToPath:context rect:rect width:radius height:radius];
	CGContextClosePath(context);
	CGContextClip(context);
	
	CGContextDrawImage(context, rect, source.CGImage);
	
	CGImageRef imageMasked = CGBitmapContextCreateImage(context);
	UIImage *newImage = [UIImage imageWithCGImage:imageMasked];
	
	CGContextRelease(context);
	CGColorSpaceRelease(colorSpace);
	CGImageRelease(imageMasked);
	
	return newImage;
}

+ (void)drawWithShadow:(SEL)someDrawing onTarget:(id)object inContext:(CGContextRef)context
{
	if ([object respondsToSelector:someDrawing] == NO)
		return ;
	// shadow start
	if (context == nil)
		context = UIGraphicsGetCurrentContext();
    float shadowColorRGBA[4] = {0, 0, 0, 1};
    CGContextSaveGState(context);
    CGColorSpaceRef shadowColorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef shadowColor = CGColorCreate(shadowColorSpace, shadowColorRGBA);
    CGContextSetShadowWithColor (context, CGSizeZero/*offset*/, 5/*blur*/, shadowColor);
	// init shadow end
	
	[object performSelector:someDrawing];
	
	// shadow end
    CGColorRelease(shadowColor);
    CGColorSpaceRelease(shadowColorSpace);
    CGContextRestoreGState(context);
	// release shadow end
}

@end

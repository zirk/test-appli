//
//  iAUMCGEffects.h
//  iAUM
//
//  Created by John Doe on 17/08/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import <CoreGraphics/CoreGraphics.h>

@interface iAUMCGEffects : NSObject {

}

+ (UIImage*)roundCornersOfImage:(UIImage*)source withRadius:(float)radius;
+ (void)addRoundedRectToPath:(CGContextRef)context rect:(CGRect)rect width:(float)ovalWidth height:(float)ovalHeight;
+ (void)drawWithShadow:(SEL)someDrawing onTarget:(id)object inContext:(CGContextRef)context;

@end

//
//  MiniProfileCell.h
//  iAUM
//
//  Created by dirk on 11/08/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "iAUMCell.h"
#import "iAUMModelMiniProfile.h"

@interface MiniProfileCell : iAUMCell {
	UIImage* picture;
	iAUMModelMiniProfile* profile;
}

@property (nonatomic, retain) UIImage* picture;
@property (nonatomic, retain) iAUMModelMiniProfile* profile;

@end

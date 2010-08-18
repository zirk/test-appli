//
//  PhysicalView.h
//  iAUM
//
//  Created by dirk on 18/08/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ABTableViewCell.h"

@interface ProfileListViewCell : ABTableViewCell {
	NSMutableDictionary* fields;
}

-(void) setField:(NSString*)fieldName withValue:(NSString*)fieldValue;

@property (retain) NSMutableDictionary* fields;


@end

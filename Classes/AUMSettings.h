//
//  AUMSettings.h
//  iAUM
//
//  Created by Dirk Amadori on 11/08/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface AUMSettings : NSObject {

}

+ (void) set:(NSString*)key withValue:(NSString*)value;
+ (NSString*) get:(NSString*)key;

@end

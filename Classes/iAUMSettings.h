//
//  AUMSettings.h
//  iAUM
//
//  Created by dirk on 11/08/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface iAUMSettings : NSObject {

}

+ (void) set:(NSString*)key withValue:(id)value;
+ (NSString*) get:(NSString*)key;
+ (id) apiConfig:(NSString*)key;

@end

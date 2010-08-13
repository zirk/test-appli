//
//  NSSortableDictionary.h
//  iAUM
//
//  Created by Dirk Amadori on 8/08/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface AumTools : NSObject {
	
}

+(NSMutableArray*) getSortedKeysWithDictionary:(NSDictionary*) dico;
+(NSString*) serializeDictionary:(NSDictionary *)dico withKeys:(NSArray *)keys;
+(NSString*) hashMD5:(NSString *)data;
+(void)queueOperation:(SEL)selector withTarget:(id)target withObject:(id)object;

@end

//
//  NSSortableDictionary.h
//  iAUM
//
//  Created by dirk on 8/08/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface iAUMTools : NSObject {
	
}

+(NSMutableArray*) getSortedKeysWithDictionary:(NSDictionary*) dico;
+(NSString*) serializeDictionary:(NSDictionary *)dico withKeys:(NSArray *)keys;
+(NSString*) hashMD5:(NSString *)data;
+(NSString*) hashSHA1:(NSString *)data;
+(void)queueOperation:(SEL)selector withTarget:(id)target withObject:(id)object;

@end

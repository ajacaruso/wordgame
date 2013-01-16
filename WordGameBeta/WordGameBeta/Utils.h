//
//  Utils.h
//  WordGameBeta
//
//  Created by Adam Jacaruso on 6/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Utils : NSObject

+(NSString *)randomizeLetter;
+(BOOL)isValidWord:(NSString *) word;
+(NSDictionary *)getRandomLevel;
+(NSDictionary *)getLevel:(NSString *)level;
+(NSMutableDictionary *)createLetterDictionary;

@end

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
+(NSString *)randomizeVowl;
+(BOOL)isValidWord:(NSString *) word;
+(bool)isRealWord:(NSString *)currentWord;
+(bool)isAllowedWordType:(NSString *)currentWord;

+(NSDictionary *)getRandomLevel;
+(NSDictionary *)getLevel:(NSString *)level;
+(NSMutableDictionary *)createLetterDictionary;
+(NSMutableDictionary *)createVowlDictionary;
+(int)getLevelSpeed;
+(void)setLevelSpeed:(int)speed;

@end

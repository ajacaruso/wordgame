//
//  GameData.m
//  WordGame
//
//  Created by Adam Jacaruso on 5/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GameData.h"

@implementation GameData

#pragma mark NSCoding

#define kBoardKey     @"Board"
#define kBankKey      @"Bank"
/*
- (void) encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:boardArray forKey:kBoardKey];
    [encoder encodeObject:letterArray forKey:kBankKey];
}

- (id)initWithCoder:(NSCoder *)decoder {
    NSMutableArray *board = [decoder decodeObjectForKey:kBoardKey];
    NSMutableArray *letters = [decoder decodeObjectForKey:kBankKey];
    return [self initWithTitle:title rating:rating];
}
*/
@end

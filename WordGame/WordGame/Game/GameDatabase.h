//
//  GameDatabase.h
//  WordGame
//
//  Created by Adam Jacaruso on 5/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameDatabase : NSObject
+ (NSMutableArray *)loadGameDocs;
+ (NSString *)nextWordGameDocPath;
@end

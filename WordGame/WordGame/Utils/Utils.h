//
//  Utils.h
//  WordGame
//
//  Created by Adam Jacaruso on 3/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utils : NSObject

-(NSString *)randomizeLetter;
-(Boolean)isValidWord:(NSString *) word;

@end

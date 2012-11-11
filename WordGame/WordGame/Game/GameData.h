//
//  GameData.h
//  WordGame
//
//  Created by Adam Jacaruso on 5/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameData : NSObject <NSCoding> {
    NSMutableArray *letterArray;
    NSMutableArray *boardArray;
}
@property (nonatomic, retain) NSMutableArray *letterArray;
@property (nonatomic, retain) NSMutableArray *boardArray;

@end

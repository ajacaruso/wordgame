//
//  Tile.h
//  WordGame
//
//  Created by Adam Jacaruso on 4/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"

@interface Tile : CCSprite
{
    BOOL _useable;
    int _PosX;
    int _PosY;
}

@property (nonatomic, assign) BOOL useable;
@property (nonatomic, assign) int PosX;
@property (nonatomic, assign) int PosY;


- (Tile*)initWithFile:(NSString *)file;

//Setters
-(void)setUseable:(BOOL)newUseable;
-(void)setPosX:(int)newPosX;
-(void)setPosY:(int)newPosY;
-(void) goToSetPosition;

//Getters
-(BOOL)getUseable;
-(int)getPosX;
-(int)getPosY;

@end

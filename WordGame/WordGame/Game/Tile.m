//
//  Tile.m
//  WordGame
//
//  Created by Adam Jacaruso on 4/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Tile.h"

@implementation Tile
@synthesize useable = _useable, PosX = _PosX, PosY = _PosY;

//Constructor
- (Tile*)initWithFile:(NSString *)file {
    if ((self = [super initWithFile:file])) {
       //After Created Run This Code
        self.anchorPoint=ccp(0,0);
    }
    return self;
}

-(void)goToSetPosition{
    self.position = ccp(_PosX, _PosY);
}

//Setters
-(void)setUseable:(BOOL)newUseable{
    _useable = newUseable;
}

-(void)setPosX:(int)newPosX{
    _PosX = newPosX;
}
-(void)setPosY:(int)newPosY{
    _PosY = newPosY;
}

//Getters

-(BOOL)getUseable{
    return _useable;
}

-(int)getPosX{
    return _PosX;
}

-(int)getPosY{
    return _PosY;
}

@end

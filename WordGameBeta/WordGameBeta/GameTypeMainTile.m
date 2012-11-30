//
//  GameTypeMainTiles.m
//  WordGameBeta
//
//  Created by Adam Jacaruso on 6/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GameTypeMainTile.h"

@implementation GameTypeMainTile
@synthesize useable, special, specialOne, specialTwo, useableOne, useableTwo;

- (GameTypeMainTile*)initWithFile:(NSString *)file starting:(int)starting image1:(NSString *)image1 isUseable1:(BOOL)isUseable1 special1:(NSString *)special1 image2:(NSString *)image2 isUseable2:(BOOL)isUseable2 special2:(NSString *)special2; {
    if ((self = [super initWithFile:file rect:CGRectMake(0, 0, 40, 40)])) {
        //After Created Run This Code
        self.anchorPoint=ccp(0,0);
        
        
        specialOne = [[NSString alloc] initWithString:special1];
        specialTwo = [[NSString alloc] initWithString:special2];
        
        useableOne = isUseable1;
        useableTwo = isUseable2;
        
        if(starting == 1){
            [self setTileTexture:image1];
            useable = isUseable1;
            special = [[NSString alloc] initWithString:special1];
        }else{
            [self setTileTexture:image2];
            useable = isUseable2;
            special = [[NSString alloc] initWithString:special2];
        }
        
    }
    return self;
}

#pragma mark - Getter / Setter

- (void)setUseable:(BOOL)newUseable{
    useable = newUseable;
}

- (BOOL)getUseable{
    return useable;
}

- (void)setSpecial:(NSString *)newSpecial{
    special = newSpecial;
}

- (NSString *)getSpecial{
    return special;
}

- (void)setTileTexture:(NSString *)file{
    CCTexture2D* tex = [[CCTextureCache sharedTextureCache] addImage:file];
    [self setTexture: tex];
}

- (void)setAsEmpty{
    [self setUseable:YES];
    [self setTileTexture:@"no_background.png"];
}

@end

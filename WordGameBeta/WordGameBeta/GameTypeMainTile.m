//
//  GameTypeMainTiles.m
//  WordGameBeta
//
//  Created by Adam Jacaruso on 6/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GameTypeMainTile.h"

@implementation GameTypeMainTile
@synthesize useable;

- (GameTypeMainTile*)initWithFile:(NSString *)file isUsable:(BOOL)isUseable {
    if ((self = [super initWithFile:file rect:CGRectMake(0, 0, 40, 40)])) {
        //After Created Run This Code
        self.anchorPoint=ccp(0,0);
        
        useable = isUseable;
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

- (void)setTileTexture:(NSString *)file{
    CCTexture2D* tex = [[CCTextureCache sharedTextureCache] addImage:file];
    [self setTexture: tex];
}
- (void)setAsEmpty{
    [self setUseable:YES];
    [self setTileTexture:@"no_background.png"];
}

@end

//
//  GameTypeMainTiles.m
//  WordGameBeta
//
//  Created by Adam Jacaruso on 6/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GameTypeMainTile.h"
#import "GameTypeMainConstants.h"

@implementation GameTypeMainTile
@synthesize currentState, useable, special, imageOne, specialOne, specialTwo, imageTwo, useableOne, useableTwo, overlaySprite, edgeTop, edgeRight, edgeBottom, edgeLeft;

- (GameTypeMainTile*)initWithFile:(NSString *)file starting:(int)starting image1:(NSString *)image1 isUseable1:(BOOL)isUseable1 special1:(NSString *)special1 image2:(NSString *)image2 isUseable2:(BOOL)isUseable2 special2:(NSString *)special2; {
    if ((self = [super initWithFile:file rect:CGRectMake(0, 0, tileSize, tileSize)])) {
        //After Created Run This Code
        self.anchorPoint=ccp(0,0);
        
        imageOne = [[NSString alloc] initWithString:image1];
        imageTwo = [[NSString alloc] initWithString:image2];
        
        specialOne = [[NSString alloc] initWithString:special1];
        specialTwo = [[NSString alloc] initWithString:special2];
        
        useableOne = isUseable1;
        useableTwo = isUseable2;
        
        currentState = starting;
        
        overlaySprite = [[CCSprite alloc] initWithFile:@"game_type_main_preview_overlay.png"];
        overlaySprite.anchorPoint = ccp(0,0);
        [self addChild:overlaySprite];
        [self togglePreviewMode:FALSE];
        
        edgeTop = [[CCSprite alloc] initWithFile:@"tile_edge_top.png"];
        edgeTop.anchorPoint = ccp(0, 0);
        edgeTop.position = ccp(0, tileSize - edgeTop.contentSize.height);
        [self addChild:edgeTop];
        
        edgeBottom = [[CCSprite alloc] initWithFile:@"tile_edge_bottom.png"];
        edgeBottom.anchorPoint = ccp(0, 0);
        edgeBottom.position = ccp(0, 0);
        [self addChild:edgeBottom];
        
        edgeLeft = [[CCSprite alloc] initWithFile:@"tile_edge_left.png"];
        edgeLeft.anchorPoint = ccp(0, 0);
        edgeLeft.position = ccp(0, 0);
        [self addChild:edgeLeft];
        
        edgeRight = [[CCSprite alloc] initWithFile:@"tile_edge_right.png"];
        edgeRight.anchorPoint = ccp(0, 0);
        edgeRight.position = ccp(tileSize - edgeRight.contentSize.width, 0);
        [self addChild:edgeRight];
        
        [self setAllEdgesVisible:false];
        
        if(currentState == 1){
            [self setAsOne];
        }else{
            [self setAsTwo];
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

- (BOOL)getUseableTwo{
    return useableTwo;
}

- (void)setCurrentState:(int)state{
    currentState = state;
}
- (int)getCurrentState{
    return currentState;
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

- (void)setStateTo:(int)state{
    if(state == 1){
        [self setAsOne];
    }else if(state == 2){
        [self setAsTwo];
        if(![imageOne isEqualToString:@"no_background.png"]){
            CCParticleSystem *emitter = [CCParticleExplosion node];
            emitter.position = ccp(20, 20);
            emitter.scale = 0.4;
            [emitter setTexture:[[CCTextureCache sharedTextureCache] addImage:imageOne]];
            [emitter setLife:0.2f];
            [self addChild: emitter];
        }
    }
}

-(void)setAsOne{
    [self setCurrentState:1];
    [self setTileTexture:imageOne];
    [self setUseable:useableOne];
    [self setSpecial:specialOne];
}

-(void)setAsTwo{
    [self setCurrentState:2];
    [self setTileTexture:imageTwo];
    [self setUseable:useableTwo];
    [self setSpecial:specialTwo];
}

-(void)setAllEdgesVisible: (BOOL)toggle{
    [edgeTop setVisible:toggle];
    [edgeBottom setVisible:toggle];
    [edgeLeft setVisible:toggle];
    [edgeRight setVisible:toggle];
}

- (void)setTopEdgeVisible: (BOOL)toggle{
    [edgeTop setVisible:toggle];
}

- (void)setBottomEdgeVisible: (BOOL)toggle{
    [edgeBottom setVisible:toggle];
}

- (void)setRightEdgeVisible: (BOOL)toggle{
    [edgeRight setVisible:toggle];
}

- (void)setLeftEdgeVisible: (BOOL)toggle{
    [edgeLeft setVisible:toggle];
}

- (void)togglePreviewMode:(bool)previewEnabled{
     [overlaySprite setVisible:previewEnabled];
}

@end

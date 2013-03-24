//
//  GameTypeMainPlayArea.m
//  WordGameBeta
//
//  Created by Adam Jacaruso on 9/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GameTypeMainPlayArea.h"
#import "SimpleAudioEngine.h"

@implementation GameTypeMainPlayArea
@synthesize gameBoard, wordBank;

- (GameTypeMainPlayArea *)initPlayArea{
    
    self = [super initWithFile:@"no_background.png" rect:CGRectMake(0, 0, 320, 380)];

    //Build Game Word Bank
    wordBank = [[[GameTypeMainWordBank alloc] initWordBank] autorelease];
    wordBank.anchorPoint = ccp(0,0);
    wordBank.position = ccp(0, 0);
    [self addChild:wordBank z:2];
    
    //Build Game Board
    gameBoard = [[[GameTypeMainBoard alloc] initWithBoard:@"World"] autorelease];
    gameBoard.anchorPoint = ccp(1,0);
    gameBoard.position = ccp(gameBoard.contentSize.width, wordBank.contentSize.height);
    [self addChild:gameBoard z:1];
    
    return self;
}

-(void)submitWord:(NSString *)specialAbility{
    
    if([gameBoard checkForWord]){
        NSLog(@"Valid Word On Board!");
        [gameBoard removePreviewFromAllTiles];
        [gameBoard changeTilesForActiveLetters:specialAbility];
        [gameBoard removeAllLetters];
        [gameBoard displayEdges];
        [wordBank updateWordBank];
        [[SimpleAudioEngine sharedEngine] playEffect:@"game_type_main_submit_explosion.mp3"];
    }else{
        //ToDo: Create Some Kind of Visual Failure MSG for the user
        NSLog(@"No Valid Word On Board");
    }
    
    
}
-(void)updateBoardState:(NSString *)specialAbility{
    [gameBoard removePreviewFromAllTiles];
    
    if([gameBoard checkForWord]){
        //set all tiles to valid
        [gameBoard toggleBoardLettersToCorrectState:TRUE];
        [gameBoard updatePreviewTilesAndShow:TRUE withAbility:specialAbility];
        
    }else{
        //set all tile to invalid
        [gameBoard toggleBoardLettersToCorrectState:FALSE];
        [gameBoard updatePreviewTilesAndShow:FALSE withAbility:specialAbility];
    }
}

@end

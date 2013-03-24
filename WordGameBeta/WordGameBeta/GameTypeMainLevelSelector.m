//
//  GameTypeMainLevelSelector.m
//  WordGameBeta
//
//  Created by Adam Jacaruso on 3/8/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "GameTypeMainLevelSelector.h"
#import "GameTypeMainConstants.h"
#import "Utils.h"

@implementation GameTypeMainLevelSelector
@synthesize backMenu, selectMenu;

+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
	GameTypeMainLevelSelector *layer = [GameTypeMainLevelSelector node];
	[scene addChild: layer];
	
	return scene;
}

-(id) init
{
	if( (self=[super init])) {
		
        selectMenu = [CCMenu menuWithItems:nil];
        backMenu = [CCMenu menuWithItems:nil];
        
        //Level Select Menu
        CCMenuItemImage * playE = [CCMenuItemImage itemFromNormalImage:@"easy_button.png"
                                                        selectedImage: @"easy_button.png"
                                                               target:self
                                                             selector:@selector(startGameEasy:)];
        
        CCMenuItemImage * playM = [CCMenuItemImage itemFromNormalImage:@"medium_button.png"
                                                         selectedImage: @"medium_button.png"
                                                                target:self
                                                              selector:@selector(startGameMedium:)];
        
        CCMenuItemImage * playH = [CCMenuItemImage itemFromNormalImage:@"hard_button.png"
                                                         selectedImage: @"hard_button.png"
                                                                target:self
                                                              selector:@selector(startGameHard:)];
        selectMenu = [CCMenu menuWithItems: playE, playM, playH, nil];
        [selectMenu alignItemsVerticallyWithPadding: 20.0f];
        
        [self addChild:selectMenu];
        
        
        //Back Menu
        CCMenuItemImage *backBtn = [CCMenuItemImage itemFromNormalImage:@"BackArrow_Button.png"
                                                          selectedImage: @"BackArrow_Button.png"
                                                                 target:self
                                                               selector:@selector(back:)];
        [backMenu addChild:backBtn];
        backMenu.position = ccp(45, 45);
        
        [self addChild:backMenu];
        
    }
	return self;
}

- (void) startGameEasy : (CCMenuItem *) menuItem{
    [Utils setLevelSpeed:boardScrollRateEasy];
    [GameManager createGameTypeMain];
}

- (void) startGameMedium : (CCMenuItem *) menuItem{
    [Utils setLevelSpeed:boardScrollRateMedium];
    [GameManager createGameTypeMain];
}

- (void) startGameHard : (CCMenuItem *) menuItem{
    [Utils setLevelSpeed:boardScrollRateHard];
    [GameManager createGameTypeMain];
}

- (void) back: (CCMenuItem  *) menuItem
{
    [MenuManager goToMainMenu];
}


- (void) dealloc
{
	[super dealloc];
}
@end
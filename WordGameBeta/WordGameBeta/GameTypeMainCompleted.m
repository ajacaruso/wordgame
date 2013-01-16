//
//  GameTypeMainCompleted.m
//  WordGameBeta
//
//  Created by Adam Jacaruso on 6/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GameTypeMainCompleted.h"
#import "SimpleAudioEngine.h"

@implementation GameTypeMainCompleted
@synthesize completedMenu, gameManager;

- (GameTypeMainCompleted*)initMenuOverlay:manager{
    
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    self = [super initWithFile:@"overlay_background.png" rect:CGRectMake(0, 0, 320, 480)];
    self.position = ccp(winSize.width/2, winSize.height/2);
    
    // Header Text
    CCLabelTTF *label = [CCLabelTTF labelWithString:@"GAME OVER" fontName:@"Marker Felt" fontSize:32];
    CGSize size = [[CCDirector sharedDirector] winSize];
    label.position =  ccp( size.width /2 , size.height/2+70 );
    [self addChild: label];
    
    // Menu
    
    CCMenuItemImage * quit = [CCMenuItemImage itemFromNormalImage:@"quit_button"
                                                    selectedImage: @"quit_button"
                                                           target:self
                                                         selector:@selector(quit:)];
    
    completedMenu = [CCMenu menuWithItems: quit, nil];
    [completedMenu alignItemsVerticallyWithPadding: 10.0f];
    completedMenu.position = ccp(self.contentSize.width/2, self.contentSize.height/2);
    
    [self addChild:completedMenu];
    
    gameManager = manager;
    [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
    
    return self;
}

- (void) quit: (CCMenuItem  *) menuItem
{
    [MenuManager goToMainMenu];
}

-(void)dealloc{
    
    [super dealloc];
    
}

@end


//
//  GameTypeMainOverlay.m
//  WordGameBeta
//
//  Created by Adam Jacaruso on 6/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GameTypeMainOverlay.h"

@implementation GameTypeMainOverlay
@synthesize pauseMenu, gameManager;

- (GameTypeMainOverlay*)initMenuOverlay:manager{
    
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    self = [super initWithFile:@"overlay_background.png" rect:CGRectMake(0, 0, 320, 480)];
    self.position = ccp(winSize.width/2, winSize.height/2);
     
    // Menu
    
     CCMenuItemImage * resume = [CCMenuItemImage itemFromNormalImage:@"resume_button"
                                                      selectedImage: @"resume_button"
                                                             target:self
                                                           selector:@selector(resume:)];
    
    CCMenuItemImage * options = [CCMenuItemImage itemFromNormalImage:@"options_button"
                                                      selectedImage: @"options_button"
                                                             target:self
                                                           selector:@selector(showOptions:)];
    
    CCMenuItemImage * quit = [CCMenuItemImage itemFromNormalImage:@"quit_button"
                                                      selectedImage: @"quit_button"
                                                             target:self
                                                           selector:@selector(quit:)];
    
    pauseMenu = [CCMenu menuWithItems: resume, options, quit, nil];
    [pauseMenu alignItemsVerticallyWithPadding: 10.0f];
    pauseMenu.position = ccp(self.contentSize.width/2, self.contentSize.height/2);
    
    [self addChild:pauseMenu];
    
    gameManager = manager;
    
    return self;
}

- (void) quit: (CCMenuItem  *) menuItem 
{
    [MenuManager goToMainMenu];
}

-(void) showOptions: (CCMenuItem *) menuItem
{
    /* Reaveal Basic Options Inside this window, not the Games Settings Page */
}

-(void) resume: (CCMenuItem *) menuItem
{
    [gameManager closeMenu];
    [self removeFromParentAndCleanup:(TRUE)];
}

-(void)dealloc{
    
    [super dealloc];
    
}

@end

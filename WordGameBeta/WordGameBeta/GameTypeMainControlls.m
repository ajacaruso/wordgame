//
//  GameTypeMainControlls.m
//  WordGameBeta
//
//  Created by Adam Jacaruso on 6/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
#import "GameTypeMainControlls.h"


@implementation GameTypeMainControlls
@synthesize controllMenu, gameManager;

- (GameTypeMainControlls*)initWithControlls:(NSString *)Controlls withManager:manager{
    
    self = [super initWithFile:@"controlls_background.png" rect:CGRectMake(0, 0, 320, 80)];
    
    //Controll Menu
    CCMenuItemImage *menuButton = [CCMenuItemImage itemFromNormalImage:@"BackArrow_Button.png"
                                                      selectedImage: @"BackArrow_Button.png"
                                                             target:self
                                                           selector:@selector(openMenu:)];
    
    CCMenuItemImage *submitButton = [CCMenuItemImage itemFromNormalImage:@"controls_submit_btn.png"
                                                         selectedImage: @"controls_submit_btn.png"
                                                                target:self
                                                              selector:@selector(submitWord:)];

    controllMenu = [CCMenu menuWithItems:menuButton, submitButton, nil];
    [controllMenu alignItemsHorizontallyWithPadding: 20.0f];
    controllMenu.position  = ccp(65, 45);
    [self addChild:controllMenu];

    gameManager = manager;
    
    return self;
}

//ToDo: Find Simpler way to call gameMager
- (void) openMenu: (CCMenuItem  *) menuItem 
{
    [gameManager openMenu];
}

- (void) submitWord: (CCMenuItem  *) menuItem
{
    [gameManager submitWord];
}

- (void) enableControls:(BOOL)enable {
    self.controllMenu.isTouchEnabled = enable;
}


@end

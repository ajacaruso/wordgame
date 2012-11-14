//
//  GameTypeMainControlls.m
//  WordGameBeta
//
//  Created by Adam Jacaruso on 6/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
#import "GameTypeMainControlls.h"
#import "GameTypeMainConstants.h"

@implementation GameTypeMainControlls
@synthesize controllMenu, gameManager, specialAbility, specialItemButton;

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
   
    specialItemButton = [CCMenuItemImage itemFromNormalImage:@"arrow_up_button.png"
                                                           selectedImage: @"arrow_up_button.png"
                                                                  target:self
                                                                selector:@selector(changeSpecial:)];
    
    controllMenu = [CCMenu menuWithItems:menuButton, submitButton, specialItemButton, nil];
    [controllMenu alignItemsHorizontallyWithPadding: 20.0f];
    controllMenu.position  = ccp(105, 45);
    [self addChild:controllMenu];

    gameManager = manager;
    specialAbility = specialUp;
    return self;
}

//ToDo: Find Simpler way to call gameMager
- (void) openMenu: (CCMenuItem  *) menuItem 
{
    [gameManager openMenu];
}

- (void) submitWord: (CCMenuItem  *) menuItem
{
    [gameManager submitWord:specialAbility];
}

- (void) changeSpecial: (CCMenuItem  *) menuItem
{
    
    CCSprite *updatedSpriteNormal;
    CCSprite *updatedSpriteSelected;
    
    if ([specialAbility isEqual:specialUp]) {
        
        specialAbility = specialRight;
        updatedSpriteNormal = [CCSprite spriteWithFile:@"arrow_right_button.png"];
        updatedSpriteSelected = [CCSprite spriteWithFile:@"arrow_right_button.png"];
        
    }else if ([specialAbility isEqual:specialRight]) {
        
        specialAbility = specialDown;
        updatedSpriteNormal = [CCSprite spriteWithFile:@"arrow_down_button.png"];
        updatedSpriteSelected = [CCSprite spriteWithFile:@"arrow_down_button.png"];
        
    }else if ([specialAbility isEqual:specialDown]) {
        specialAbility = specialLeft;
        updatedSpriteNormal = [CCSprite spriteWithFile:@"arrow_left_button.png"];
        updatedSpriteSelected = [CCSprite spriteWithFile:@"arrow_left_button.png"];
        
    }else {
        specialAbility = specialUp;
        updatedSpriteNormal = [CCSprite spriteWithFile:@"arrow_up_button.png"];
        updatedSpriteSelected = [CCSprite spriteWithFile:@"arrow_up_button.png"];
        
    }
    
    [specialItemButton setNormalImage:updatedSpriteNormal];
    [specialItemButton setSelectedImage:updatedSpriteSelected];
    
}

- (void) enableControls:(BOOL)enable {
    self.controllMenu.isTouchEnabled = enable;
}


@end

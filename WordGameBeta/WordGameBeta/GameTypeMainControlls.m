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
    
    self = [super initWithFile:@"controlls_background.png" rect:CGRectMake(0, 0, 320, controlsHeight)];
    
    //Controll Menu
    CCMenuItemImage *submitButton = [CCMenuItemImage itemFromNormalImage:@"controls_submit_btn.png"
                                                         selectedImage: @"controls_submit_btn.png"
                                                                target:self
                                                              selector:@selector(submitWord:)];
    CCMenuItemImage *recallButton = [CCMenuItemImage itemFromNormalImage:@"controls_recall_btn.png"
                                                           selectedImage: @"controls_recall_btn.png"
                                                                  target:self
                                                                selector:@selector(recall:)];
    
    CCMenuItemImage *shuffleButton = [CCMenuItemImage itemFromNormalImage:@"controls_shuffle_btn.png"
                                                           selectedImage: @"controls_shuffle_btn.png"
                                                                  target:self
                                                                selector:@selector(shuffle:)];
   
    specialItemButton = [CCMenuItemImage itemFromNormalImage:@"arrow_down_button.png"
                                                           selectedImage: @"arrow_down_button.png"
                                                                  target:self
                                                                selector:@selector(changeSpecial:)];
    
    controllMenu = [CCMenu menuWithItems: submitButton, recallButton, shuffleButton, specialItemButton, nil];
    [controllMenu alignItemsHorizontallyWithPadding: 30.0f];
    controllMenu.position  = ccp(160, 30);
    [self addChild:controllMenu];

    gameManager = manager;
    specialAbility = specialDown;
    return self;
}

- (void) recall: (CCMenuItem  *) menuItem{
    [gameManager recall];
}
- (void) shuffle: (CCMenuItem  *) menuItem{
    [gameManager shuffle];
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
    
    [gameManager updateBoardState];

}

- (NSString *)getSpecialAbility{
    return specialAbility;
}


@end

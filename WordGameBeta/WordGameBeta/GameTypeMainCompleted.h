//
//  GameTypeMainCompleted.h
//  WordGameBeta
//
//  Created by Adam Jacaruso on 6/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//


#import "cocos2d.h"
#import "MenuManager.h"

@interface GameTypeMainCompleted : CCSprite{
    
    CCMenu *completedMenu;
    GameTypeMain *gameManager;
}

@property (nonatomic, assign) CCMenu *completedMenu;
@property (nonatomic, retain) GameTypeMain *gameManager;

- (GameTypeMainCompleted *)initMenuOverlay:manager;
- (void) quit: (CCMenuItem  *) menuItem;

@end

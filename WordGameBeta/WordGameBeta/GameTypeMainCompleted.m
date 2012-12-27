//
//  GameTypeMainCompleted.m
//  WordGameBeta
//
//  Created by Adam Jacaruso on 6/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GameTypeMainCompleted.h"

@implementation GameTypeMainCompleted
@synthesize completedMenu, gameManager;

- (GameTypeMainCompleted*)initMenuOverlay:manager{
    
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    self = [super initWithFile:@"overlay_background.png" rect:CGRectMake(0, 0, 320, 480)];
    self.position = ccp(winSize.width/2, winSize.height/2);
    
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


//
//  OptionsLayer.m
//  WordGame
//
//  Created by Adam Jacaruso on 3/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "OptionsLayer.h"

@implementation OptionsLayer
@synthesize optionsMenu;

- (id)init {
    if ((self = [super init])) {
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        CCMenu *mainMenuInit = [CCMenu menuWithItems:nil];
        CCMenuItemImage *menuBtn = [CCMenuItemImage itemFromNormalImage:@"menu_btn.png"
                                                          selectedImage: @"menu_btn.png"
                                                                 target:self
                                                               selector:@selector(backToMenu:)];
        [mainMenuInit addChild:menuBtn];
        mainMenuInit.position = ccp(50, (winSize.height-40));
        
        [self addChild:mainMenuInit];
    }
    return self;
}

- (void) backToMenu: (CCMenuItem  *) menuItem 
{
    GameManager *MainMenu = [MenuLayer node];
    [[CCDirector sharedDirector] replaceScene:
	 [CCTransitionFade transitionWithDuration:0.5f scene:MainMenu]];
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}
@end

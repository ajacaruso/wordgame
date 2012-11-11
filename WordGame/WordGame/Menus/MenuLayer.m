//
//  MenuLayer.m
//  WordGame
//
//  Created by Adam Jacaruso on 3/25/12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//


// Import the interfaces
#import "MenuLayer.h"

// MenuLayer implementation
@implementation MenuLayer
@synthesize mainMenu;

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	MenuLayer *layer = [MenuLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init])) {
		
        CCMenuItemImage * newGame = [CCMenuItemImage itemFromNormalImage:@"menu_newgame.png"
            selectedImage: @"menu_newgame.png"
            target:self
            selector:@selector(startGame:)];
         
        CCMenuItemImage * continueGame = [CCMenuItemImage itemFromNormalImage:@"menu_continuegame.png"
            selectedImage: @"menu_continuegame.png"
            target:self
            selector:@selector(startGame:)];
        
        CCMenuItemImage * options = [CCMenuItemImage itemFromNormalImage:@"menu_options.png"
            selectedImage: @"menu_options.png"
            target:self
            selector:@selector(showOptions:)];
        
        CCMenuItemImage * about = [CCMenuItemImage itemFromNormalImage:@"menu_about.png"
            selectedImage: @"menu_about.png"
            target:self
            selector:@selector(showAbout:)];
        
        CCMenuItemImage * stats = [CCMenuItemImage itemFromNormalImage:@"menu_stats.png"
            selectedImage: @"menu_stats.png"
            target:self
            selector:@selector(showStats:)];
        
       
        mainMenu = [CCMenu menuWithItems:newGame, continueGame, options, about, stats, nil];
        [mainMenu alignItemsVerticallyWithPadding: 20.0f];
        
        [self addChild:mainMenu];
        
	}
	return self;
}

- (void) startGame: (CCMenuItem  *) menuItem 
{
    GameManager *Game = [GameManager node];
    [[CCDirector sharedDirector] replaceScene:
	 [CCTransitionFade transitionWithDuration:0.5f scene:Game]];
}

-(void) showOptions: (CCMenuItem *) menuItem
{
    OptionsLayer *Opts = [OptionsLayer node];
    [[CCDirector sharedDirector] replaceScene:
	 [CCTransitionFade transitionWithDuration:0.5f scene:Opts]];
}

-(void) showAbout: (CCMenuItem *) menuItem
{
    AboutLayer *About = [AboutLayer node];
    [[CCDirector sharedDirector] replaceScene:
	 [CCTransitionFade transitionWithDuration:0.5f scene:About]];
}

-(void) showStats: (CCMenuItem *) menuItem
{
    StatsLayer *Stats = [StatsLayer node];
    [[CCDirector sharedDirector] replaceScene:
	 [CCTransitionFade transitionWithDuration:0.5f scene:Stats]];
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

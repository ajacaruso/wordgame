//
//  MenuLayer.h
//  WordGame
//
//  Created by Adam Jacaruso on 3/25/12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
#import "GameManager.h"
#import "OptionsLayer.h"
#import "AboutLayer.h"
#import "StatsLayer.h"
#import <UIKit/UIKit.h>

// HelloWorldLayer
@interface MenuLayer : CCLayer
{
    CCMenu *mainMenu;
}
@property (nonatomic, retain) CCMenu *mainMenu;

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@end

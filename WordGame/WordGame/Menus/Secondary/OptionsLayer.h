//
//  OptionsLayer.h
//  WordGame
//
//  Created by Adam Jacaruso on 3/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"
#import "GameManager.h"
#import "MenuLayer.h"
#import <UIKit/UIKit.h>

@interface OptionsLayer : CCScene {
    CCMenu *optionsMenu;
}
@property (nonatomic, retain) CCMenu *optionsMenu;

@end

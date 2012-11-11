//
//  AboutLayer.h
//  WordGame
//
//  Created by Adam Jacaruso on 3/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"
#import "GameManager.h"
#import "MenuLayer.h"
#import <UIKit/UIKit.h>

@interface AboutLayer : CCScene {
    CCMenu *aboutMenu;
}
@property (nonatomic, retain) CCMenu *aboutMenu;

@end

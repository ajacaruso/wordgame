//
//  GameTypeMainHeader.m
//  WordGameBeta
//
//  Created by Adam Jacaruso on 2/28/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "GameTypeMainHeader.h"
#import "GameTypeMainConstants.h"


@implementation GameTypeMainHeader
@synthesize controllMenu, gameManager, timer, scoreLabel;

- (GameTypeMainHeader*)initWithManager:manager{
    
    self = [super initWithFile:@"controlls_background.png" rect:CGRectMake(0, 0, 320, 40)];
    
    //Controll Menu
    CCMenuItemImage *menuButton = [CCMenuItemImage itemFromNormalImage:@"controls_pause_btn.png"
                                                         selectedImage: @"controls_pause_btn.png"
                                                                target:self
                                                              selector:@selector(openMenu:)];
    controllMenu = [CCMenu menuWithItems:menuButton, nil];
    [controllMenu alignItemsHorizontallyWithPadding: 20.0f];
    controllMenu.position  = ccp(27, 20);
    [self addChild:controllMenu];
        
    timer = [[CCProgressTimer alloc] initWithFile:@"progress_bar.png"];
    timer.type = kCCProgressTimerTypeHorizontalBarLR;
    timer.percentage = 100;
    timer.position = ccp(self.contentSize.width/2, self.contentSize.height/2);
    [self addChild:timer];
    [self scheduleUpdate];

    scoreLabel = [CCLabelTTF labelWithString:@"" dimensions:CGSizeMake(60, 24) alignment:UITextAlignmentRight fontName:@"Marker Felt" fontSize:24];
    //scoreLabel = [CCLabelTTF labelWithString:@"0" fontName:@"Marker Felt" fontSize:32];
    scoreLabel.position = ccp((self.contentSize.width-5)-(scoreLabel.contentSize.width/2), self.contentSize.height/2);
    [self addChild:scoreLabel];
    [self setScore:@"0"];
    
    gameManager = manager;
    return self;
}

-(void)update:(ccTime)dt {
    float scrollRate = (100.0 / (float)boardScrollRate);
    timer.percentage -= dt * scrollRate;
    if (timer.percentage <= 0) {
        timer.percentage = 100;
    }
}

- (void) openMenu: (CCMenuItem  *) menuItem
{
    [gameManager openMenu];
}

- (void) enableControls:(BOOL)enable {
    self.controllMenu.isTouchEnabled = enable;
}

- (void) setScore:(NSString *) newScore{
    [scoreLabel setString:newScore];
}

- (NSString *) getScore{
    return [scoreLabel string];
}


@end

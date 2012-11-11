//
//  GameTypeMainPlayArea.h
//  WordGameBeta
//
//  Created by Adam Jacaruso on 9/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"
#import "GameTypeMainWordBank.h"
#import "GameTypeMainBoard.h"

@interface GameTypeMainPlayArea : CCSprite {
    GameTypeMainBoard *gameBoard;
    GameTypeMainWordBank *wordBank;
}
@property (nonatomic, retain) GameTypeMainBoard *gameBoard;
@property (nonatomic, retain) GameTypeMainWordBank *wordBank;

- (GameTypeMainPlayArea *)initPlayArea;
- (void)submitWord;

@end

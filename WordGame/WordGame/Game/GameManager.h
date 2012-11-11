//
//  GameManager.h
//  WordGame
//
//  Created by Adam Jacaruso on 3/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
#import "Board.h"
#import "Tile.h"

@interface GameManager : CCScene {
    Board *_BoardLayer;
    CCLabelTTF *_ScoreLbl;
    int _Score;
    NSDictionary *_Level;
    NSString *_DocPath;
}
@property (nonatomic, retain) Board *_BoardLayer;
@property (nonatomic, retain) CCLabelTTF *ScoreLbl;
@property (nonatomic, assign) int Score;
@property (nonatomic, retain) NSDictionary *Level;
@property (copy) NSString *DocPath;

- (id) initFromPrevious:(NSString *)DocPath;
- (void) saveData;
- (void) deleteDoc;
- (void) initLevelJson:(NSString *)levelString;
- (void) submitBoard: (CCMenuItem  *) menuItem;
- (void) backToMenu: (CCMenuItem  *) menuItem;

@end

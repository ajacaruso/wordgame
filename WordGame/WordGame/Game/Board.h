//
//  Board.h
//  WordGame
//
//  Created by Adam Jacaruso on 3/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"
#import "Utils.h"
#import "Letter.h"
#import "Tile.h"

@interface Board : CCLayerColor {
    CCSprite *boardSprite;
    NSMutableArray *letterArray;
    NSMutableArray *boardArray;
    NSMutableArray *tileArray;
    Letter *selLetter;
    int boardWidth;
    int boardHeight;
    int tileWidth;
    int tileHeight;
    int currentLetterZIndex;
}

@property (nonatomic, retain) NSMutableArray *letterArray;
@property (nonatomic, retain) NSMutableArray *boardArray;
@property (nonatomic, retain) NSMutableArray *tileArray;
@property (nonatomic, retain) CCSprite *boardSprite;

- (void)initBoard:(NSDictionary *)level;
- (void)panForTranslation:(CGPoint)translation;
- (NSMutableArray *)submitBoard;
- (void)clearBoard;
- (NSMutableArray *)invertArray:(NSMutableArray *)originalArray;
- (void)lockLetters;
- (void)organiseLetterBank;
- (BOOL)isWin:(NSMutableArray *) wordArray;
- (BOOL)isWordAttached:(NSMutableArray *) wordArray;
- (void)handlePanFrom:(UIPanGestureRecognizer *)recognizer;
- (BOOL)checkOnBoard:(Letter *)letterSprite;
-(Letter *)checkOnLetter:(Letter *)letterSprite;
-(void) swapLettersInBank:(Letter *)firstLetter with:(Letter *)secondLetter;
-(void) clearLetterBank;
@end

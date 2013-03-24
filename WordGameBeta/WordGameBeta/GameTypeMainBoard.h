
#import "cocos2d.h"
#import "GameTypeMainLetter.h"
#import "GameTypeMainTile.h"
#import "GameTypeMainConstants.h"
#import "Utils.h"

@interface GameTypeMainBoard : CCSprite{
    CCSprite *boardLayer;
    NSMutableArray *boardArray;
    NSMutableArray *boardLetters;
    int boardOffset;
    int currentC;
}

@property (nonatomic, retain) CCSprite *boardLayer;
@property (nonatomic, retain) NSMutableArray *boardArray;
@property (nonatomic, retain) NSMutableArray *boardLetters;
@property (nonatomic, assign) int boardOffset;
@property (nonatomic, assign) int currentC;

- (GameTypeMainBoard*) initWithBoard:(NSString *)World;
- (void) createStartingBoard;
- (void) addRandomLevel;
- (void) addStartingLevel;
- (void) addTiles:(NSDictionary *)board;
- (BOOL) addLetterToBoard:(GameTypeMainLetter *)Letter;

- (GameTypeMainTile *) closestTileToLetter:(GameTypeMainLetter *)Letter;
- (NSMutableArray *) generateCurrentLetterPositionArray;
- (GameTypeMainTile *) tileAtCol:(int)Col andRow:(int)Row;
- (void) setTileArrayState:(NSMutableArray *)tileArray To:(int)state;

- (void) cleanupBoard;
- (BOOL) hasEmptySpace;
- (BOOL) checkForWord;
- (BOOL) positionIsRowAndValidWord:(NSMutableArray *)positionArray;
- (BOOL) positionIsColAndValidWord:(NSMutableArray *)positionArray;
- (void) changeTilesForActiveLetters:(NSString *)specialAbility;
- (void) removeAllLetters;

- (void) setBoardMoveOffset:(int)newOffset;
- (void) addBoardMoveOffset:(int)addNumber;
- (int) getBoardMoveOffset;

- (void) toggleBoardLettersToCorrectState:(bool)isCorrect;
- (void) updatePreviewTilesAndShow:(bool)showTiles withAbility:(NSString *)specialAbility;
- (void) removePreviewFromAllTiles;
- (void) displayEdges;

@end

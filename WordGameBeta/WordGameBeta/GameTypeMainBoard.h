
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
}

@property (nonatomic, retain) CCSprite *boardLayer;
@property (nonatomic, retain) NSMutableArray *boardArray;
@property (nonatomic, retain) NSMutableArray *boardLetters;
@property (nonatomic, assign) int boardOffset;

- (GameTypeMainBoard*)initWithBoard:(NSString *)World;
- (void) createStartingBoard;
- (void) addTiles:(NSDictionary *)board;
- (BOOL) addLetterToBoard:(GameTypeMainLetter *)Letter;

- (GameTypeMainTile *) closestTileToLetter:(GameTypeMainLetter *)Letter;
- (NSMutableArray *)generateCurrentLetterPositionArray;
- (GameTypeMainTile *)tileAtCol:(int)Col andRow:(int)Row;
- (void)setTileArrayState:(NSMutableArray *)tileArray To:(int)state;

- (BOOL)checkForWord;
- (BOOL)positionIsRowAndValidWord:(NSMutableArray *)positionArray;
- (BOOL)positionIsColAndValidWord:(NSMutableArray *)positionArray;
- (void)changeTilesForActiveLetters:(NSString *)specialAbility;
- (void)removeAllLetters;

- (void) setBoardMoveOffset:(int)newOffset;
- (void) addBoardMoveOffset:(int)addNumber;
- (int) getBoardMoveOffset;
@end

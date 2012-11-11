
#import "cocos2d.h"
#import "GameTypeMainLetter.h"
#import "GameTypeMainTile.h"
#import "GameTypeMainConstants.h"
#import "Utils.h"

@interface GameTypeMainBoard : CCSprite{
    CCSprite *boardLayer1;
    CCSprite *boardLayer2;
    NSMutableArray *boardArray1;
    NSMutableArray *boardArray2;
    NSMutableArray *boardLetters;
}

@property (nonatomic, retain) CCSprite *boardLayer1;
@property (nonatomic, retain) CCSprite *boardLayer2;
@property (nonatomic, retain) NSMutableArray *boardArray1;
@property (nonatomic, retain) NSMutableArray *boardArray2;
@property (nonatomic, retain) NSMutableArray *boardLetters;

- (GameTypeMainBoard*)initWithBoard:(NSString *)World;
- (void) createStartingBoard;
- (BOOL) addLetterToBoard:(GameTypeMainLetter *)Letter;

- (GameTypeMainTile *) closestTileToLetter:(GameTypeMainLetter *)Letter;
- (NSMutableArray *)generateCurrentLetterPositionArray;
- (GameTypeMainTile *)tileAtCol:(NSNumber *)Col andRow:(NSNumber *)Row;
- (void)setTileArray:(NSMutableArray *)tileArray To:(NSString *)state;

- (BOOL)checkForWord;
- (BOOL)positionIsRowAndValidWord:(NSMutableArray *)positionArray;
- (BOOL)positionIsColAndValidWord:(NSMutableArray *)positionArray;
- (void)changeTilesForActiveLetters;
- (void)removeAllLetters;
@end

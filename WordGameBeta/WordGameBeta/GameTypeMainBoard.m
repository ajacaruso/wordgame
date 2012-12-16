
#import "GameTypeMainBoard.h"
#import "GameTypeMainPlayArea.h"

@implementation GameTypeMainBoard
@synthesize boardLayer, boardArray, boardLetters;


- (GameTypeMainBoard*)initWithBoard:(NSString *)World{
    
    self = [super initWithFile:@"board_background.png" rect:CGRectMake(0, 0, boardWidth, boardHeight)];
    
    boardLayer = [CCSprite spriteWithFile:@"no_background.png" rect:CGRectMake(0, 0, boardWidth, boardHeight)];
    boardLayer.anchorPoint = ccp(0,0);
    
    /* Board Array is a 2DArrays */
    boardArray = [[NSMutableArray alloc] init];
    boardLetters = [[NSMutableArray alloc] init];
    
    [self addChild: boardLayer];
    
    [self createStartingBoard];
    
    return self;
}

#pragma mark - Create / Modify Board Layers

- (void) createStartingBoard{
    NSDictionary *startingLevel = [[NSDictionary alloc] init];
    NSError *error;
    
    startingLevel = [NSJSONSerialization
              JSONObjectWithData:[NSData dataWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"gametypemain_1" ofType:@"json"]]
              options:kNilOptions
              error:&error];
    
    [self addTiles: startingLevel];
    
}


- (void) addTiles:(NSDictionary *)board{

    /* Could pull / set info, but for now using Constants
    
    int boardId = [[board objectForKey:@"tileArray"] intValue];
    int rowSize = [[board objectForKey:@"rowSize"] intValue];
    NSString *isUseable = [board objectForKey:@"useable"];
     
    */

    NSMutableArray *tiles = [[NSMutableArray alloc] init];
    int counter = 0;
    tiles = [board objectForKey:@"tiles"];
 
    for( int c = 0; c <  (boardHeight / tileSize); c++){
        
        NSMutableArray *colArray = [[NSMutableArray alloc]init];
        
        for (int r = 0; r < (boardWidth / tileSize); r++) {
            
            NSDictionary *tile = [tiles objectAtIndex:counter];
            counter++;
            
            int starting = [[tile objectForKey:@"starting"] intValue];
            BOOL useable1 = [[tile objectForKey:@"useable1"] boolValue];
            NSString *image1 = [tile objectForKey:@"image1"];
            NSString *special1 = [tile objectForKey:@"special1"];
            
            BOOL useable2 = [[tile objectForKey:@"useable2"] boolValue];
            NSString *image2 = [tile objectForKey:@"image2"];
            NSString *special2 = [tile objectForKey:@"special2"];
           
            GameTypeMainTile *newTile1 = [[[GameTypeMainTile alloc] initWithFile:image1 starting:starting image1:image1 isUseable1:useable1 special1:special1 image2:image2 isUseable2:useable2 special2:special2] autorelease];
            newTile1.position =  ccp((tileSize*r), (((tileSize*c)*-1)+boardHeight-tileSize));
            [boardLayer addChild: newTile1];
            [colArray addObject:newTile1];
             
        }
        
        [boardArray addObject:colArray];
    }
    
}
//Remove Tiles within a radius of the letter positions
/* 
 Position Array:
 0 = boardLettersObject (MutableArray)
    0 = Letter
    1 = Tile
 1 = col (NSNumber)
 2 = row (NSNumber)
 */
- (void)changeTilesForActiveLetters:(NSString *)specialAbility{
   
    NSMutableArray *tilesToChange = [[NSMutableArray alloc] init];
    
    //Find The Radius based on word length
    
    NSMutableArray *positionArray = [self generateCurrentLetterPositionArray];
    
    int maxDistance = ceil([positionArray count]/2.0);
   
    
    for(NSMutableArray *objectArray in positionArray){
        int col = [[objectArray objectAtIndex:1] intValue];
        int row = [[objectArray objectAtIndex:2] intValue];
        bool isBlocked = false;
        
        GameTypeMainTile *tileCurrent = [self tileAtCol:col andRow:row];
        if(![tilesToChange containsObject:tileCurrent]){
            [tilesToChange addObject:tileCurrent];
        }
        
        if ([specialAbility isEqual:specialUp]) {
            for(int c = 1; c <= maxDistance; c++){
                if(col-c >= 0 && !isBlocked){
                    GameTypeMainTile *tileUpdate = [self tileAtCol:col-c andRow:row];
                    if(![tilesToChange containsObject:tileUpdate]){
                        [tilesToChange addObject:tileUpdate];
                    }
                    if(![tileUpdate getUseableTwo]){
                        isBlocked = true;
                    }
                }
                
            }
        }else if ([specialAbility isEqual:specialDown]) {
            for(int c = 1; c <= maxDistance; c++){
                if(col+c < tilesInRow && !isBlocked){
                    GameTypeMainTile *tileUpdate = [self tileAtCol:col+c andRow:row];
                    if(![tilesToChange containsObject:tileUpdate]){
                        [tilesToChange addObject:tileUpdate];
                    }
                    if(![tileUpdate getUseableTwo]){
                        isBlocked = true;
                    }
                }
            }
        }else if ([specialAbility isEqual:specialLeft]) {
            for(int r = 1; r <= maxDistance; r++){
                if(row-r >= 0 && !isBlocked){
                    GameTypeMainTile *tileUpdate = [self tileAtCol:col andRow:row-r];
                    if(![tilesToChange containsObject:tileUpdate]){
                        [tilesToChange addObject:tileUpdate];
                    }
                    if(![tileUpdate getUseableTwo]){
                        isBlocked = true;
                    }
                }
                
            }
        }else if ([specialAbility isEqual:specialRight]) {
             for(int r = 1; r <= maxDistance; r++){
                 if(row+r < tilesInRow && !isBlocked){
                     GameTypeMainTile *tileUpdate = [self tileAtCol:col andRow:row+r];
                     if(![tilesToChange containsObject:tileUpdate]){
                         [tilesToChange addObject:tileUpdate];
                     }
                     if(![tileUpdate getUseableTwo]){
                         isBlocked = true;
                     }
                 }
             }
        }
    }
    
    [self setTileArrayState:tilesToChange To:2];
    
    NSLog(@"Tiles in Array %d, maxDistance Value is : %d, Changed Tiles : %d, Ability is : %@", [positionArray count], maxDistance, [tilesToChange count], specialAbility);
}

- (void)removeAllLetters{
    for(NSMutableArray *array in boardLetters){
        [[array objectAtIndex:0] setActive:FALSE];
        [[array objectAtIndex:0] removeFromParentAndCleanup:YES];
    }
    [boardLetters removeAllObjects];
}

#pragma mark - Letter to Board Functions

//Finds Closest open space, if empty space found place letter in spot return true. If no possible empty spot return false
- (BOOL) addLetterToBoard:(GameTypeMainLetter *)Letter{
    
    GameTypeMainTile *closestTile = [self closestTileToLetter:Letter];
    
    if([closestTile getUseable]){
        Letter.position = closestTile.position;
        [closestTile setUseable:false];
        
        BOOL entryExists = false;
        
        //Update Entry if it Exists and Add New One
        for(NSMutableArray *array in boardLetters){
            if([array objectAtIndex:0] == Letter){
                entryExists = true;
                [array replaceObjectAtIndex:1 withObject:closestTile];
                break;
            }
        }
        
        //Add the Letter / Tile as an Array object to boardLetters
        if(!entryExists){
            NSMutableArray *newLetterEntry = [[NSMutableArray alloc] init];
            [newLetterEntry addObject:Letter];
            [newLetterEntry addObject:closestTile];
            [boardLetters addObject:newLetterEntry];
        }
        
        return true;
        
    }else{
        //If Entry did exist remove it as we are going to send it back to Wordbank
        for(NSMutableArray *array in boardLetters){
            if([array objectAtIndex:0] == Letter){
                [boardLetters removeObject:array];
                break;
            }
        }
        
        return false;
    }
}



#pragma mark - Utils

//Returns Closest Tile
- (GameTypeMainTile *) closestTileToLetter:(GameTypeMainLetter *)Letter{
    GameTypeMainTile *tile = nil;
    
    float highestValue = 2.0f;
    for(NSMutableArray *array in boardArray){
        for (GameTypeMainTile *sprite in array) {
            //CGRect TileRect = CGRectMake(sprite.position.x, sprite.position.y, sprite.contentSize.width, sprite.contentSize.height);
            //CGRect LetterRect = CGRectMake(Letter.position.x, Letter.position.y, Letter.contentSize.width, Letter.contentSize.height);
            
            
            //CGRect TileRect = sprite.boundingBox;
            //CGRect LetterRect = Letter.boundingBox;
            
            //CGRect TileRect = sprite.boundingBox;
            //CGRect LetterRect = CGRectMake(Letter.position.x, Letter.position.y, Letter.contentSize.width, Letter.contentSize.height);
            
            //CGRect TileRect = CGRectMake(sprite.position.x, sprite.position.y, sprite.contentSize.width, sprite.contentSize.height);
            //CGRect LetterRect = [Letter boundingBox];
            
            CGPoint worldPointL = [Letter convertToWorldSpace:Letter.position];
            CGRect LetterRect = [Letter boundingBox];
            LetterRect.origin = worldPointL;
            
            CGPoint worldPointT = [sprite convertToWorldSpace:sprite.position];
            CGRect TileRect = [sprite boundingBox];
            TileRect.origin = worldPointT;

            //Check On Letter
            if (CGRectIntersectsRect(TileRect, LetterRect)) {
                float interSectionNumber = CGRectGetWidth(CGRectIntersection(TileRect, LetterRect)) * CGRectGetHeight(CGRectIntersection(TileRect, LetterRect));
                
                if(highestValue <= interSectionNumber && [sprite getUseable]){
                    tile = sprite;
                    highestValue = interSectionNumber;
                    NSLog(@"X1: %f, Y1: %f, X2: %f, Y2: %f", sprite.position.x, sprite.position.y, Letter.position.x, Letter.position.y);
                    
                }
            }
            
        }
    }
    
    NSLog(@"Highest Letter Intersect Value : %f", highestValue);
    return tile;
}

//Return a Position Array of all active Letters
-(NSMutableArray *)generateCurrentLetterPositionArray{
    
    NSMutableArray *positionArray = [[NSMutableArray alloc]init];
    
    //Build an array of positions for the letters in word array
    for( int c = 0; c < [boardArray count]; c++){
        
        NSMutableArray *colArray = [boardArray objectAtIndex:c];
        
        for (int r = 0; r < [colArray count]; r++) {
            
            //Detect Letter Space At Location
            for (int p = 0; p < [boardLetters count]; p++){
                
                //Tile Found - Build Word Array Off Letter
                if([colArray objectAtIndex:r] == [[boardLetters objectAtIndex:p] objectAtIndex:1]){
                    NSLog(@"C : %d - R : %d", c, r);
                    
                    //Add Letter To Position Array
                    NSMutableArray *positionArrayBuilder = [[NSMutableArray alloc] init];
                    [positionArrayBuilder addObject:[boardLetters objectAtIndex:p]];
                    [positionArrayBuilder addObject:[NSNumber numberWithInt:c]];
                    [positionArrayBuilder addObject:[NSNumber numberWithInt:r]];
                    [positionArray addObject: positionArrayBuilder];
                }
            }
        }
        
    }
    /*
     0 = boardLettersObject (MutableArray)
     1 = col (NSNumber)
     2 = row (NSNumber)
     */
    return positionArray;
}

- (GameTypeMainTile *)tileAtCol:(int)Col andRow:(int)Row{
    
    GameTypeMainTile *returnTile = [[boardArray objectAtIndex:Col]  objectAtIndex:Row];
    
    return returnTile;
}

- (void)setTileArrayState:(NSMutableArray *)tileArray To:(int)state{
    for(GameTypeMainTile *tile in tileArray){
        [tile setStateTo:state];
    }
}


#pragma mark - Submit Functions - Word Detect

- (BOOL)checkForWord{
    
    NSMutableArray *positionArray = [self generateCurrentLetterPositionArray];

    //Check for Valid Word in Row
    if([self positionIsRowAndValidWord:positionArray]){
        return true;
    }
    
    //Check for Vlaid Word in Col
    if([self positionIsColAndValidWord:positionArray]){
        return true;
    }
    
    //No Valid State Found
    return false;
}

//ToDo: Both Positions Functions are similar enough to be one function
-(BOOL)positionIsRowAndValidWord:(NSMutableArray *)positionArray{
    
    NSString *word = [[NSString alloc]init];
    
    //If no letters are on the board Return False;
    if ([positionArray count] == 0) {
        return false;
    }
    
    //Set values to determine row
    int rowCount = 0;
    int initialCol = [[[positionArray objectAtIndex:0] objectAtIndex:1] intValue];
    int initialRow = [[[positionArray objectAtIndex:0] objectAtIndex:2] intValue];
    
    //Check if word is all in one row
    for(int p = 0; p < [positionArray count]; p++){
        if(initialCol == [[[positionArray objectAtIndex:p] objectAtIndex:1] intValue] && initialRow == ([[[positionArray objectAtIndex:p] objectAtIndex:2] intValue] - p)){
            rowCount++;
            NSString *tempLetter = [[[[positionArray objectAtIndex:p] objectAtIndex:0] objectAtIndex:0] getLetter];
            word = [word stringByAppendingFormat:@"%@",tempLetter];
        }
    }
    
    //NSLog(@"Letters Row : %d - Letters Board : %d", rowCount, [positionArray count]);
    
    //ToDo : is valid word always returns true...(its actually a bug in this version of the SDK)
    if (rowCount == [positionArray count] && [Utils isValidWord:word] && [positionArray count] > 1) {
        return true;
    }else{
        return false;
    }
    
}

-(BOOL)positionIsColAndValidWord:(NSMutableArray *)positionArray{
    
    NSString *word = [[NSString alloc]init];
    
    //If no letters are on the board Return False;
    if ([positionArray count] == 0) {
        return false;
    }
    
    //Set values to determine row
    int colCount = 0;
    int initialCol = [[[positionArray objectAtIndex:0] objectAtIndex:1] intValue];
    int initialRow = [[[positionArray objectAtIndex:0] objectAtIndex:2] intValue];
    
    //Check if word is all in one row
    for(int p = 0; p < [positionArray count]; p++){
        if(initialCol == ([[[positionArray objectAtIndex:p] objectAtIndex:1] intValue] - p) && initialRow == [[[positionArray objectAtIndex:p] objectAtIndex:2] intValue]){
            colCount++;
            NSString *tempLetter = [[[[positionArray objectAtIndex:p] objectAtIndex:0] objectAtIndex:0] getLetter];
            word = [word stringByAppendingFormat:@"%@",tempLetter];
        }
    }
    
    //NSLog(@"Letters Col : %d - Letters Board : %d", colCount, [positionArray count]);
    
    //ToDo : is valid word always returns true...(its actually a bug in this version of the SDK)
    if (colCount == [positionArray count] && [Utils isValidWord:word] && [positionArray count] > 1) {
        return true;
    }else{
        return false;
    }
    
}


@end

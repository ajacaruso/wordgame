
#import "GameTypeMainBoard.h"
#import "GameTypeMainPlayArea.h"

@implementation GameTypeMainBoard
@synthesize boardLayer1, boardLayer2, boardArray1, boardArray2, boardLetters;


- (GameTypeMainBoard*)initWithBoard:(NSString *)World{
    
    self = [super initWithFile:@"board_background.png" rect:CGRectMake(0, 0, boardWidth, boardHeight)];
    
    boardLayer1 = [CCSprite spriteWithFile:@"no_background.png" rect:CGRectMake(0, 0, boardWidth, boardHeight)];
    boardLayer2 = [CCSprite spriteWithFile:@"no_background.png" rect:CGRectMake(0, 0, boardWidth, boardHeight)];
    
    boardLayer1.anchorPoint = ccp(0,0);
    boardLayer2.anchorPoint = ccp(0,0);
    
    /* Board Array 1 and 2 are 2DArrays */
    boardArray1 = [[NSMutableArray alloc] init];
    boardArray2 = [[NSMutableArray alloc] init];
    
    boardLetters = [[NSMutableArray alloc] init];
    
    [self addChild: boardLayer1];
    [self addChild: boardLayer2];
    
    [self createStartingBoard];
    
    return self;
}

#pragma mark - Create / Modify Board Layers

- (void) createStartingBoard{
    
    //Create Layer 1
    for( int c = 0; c <  (boardHeight / tileSize); c++){
        
         NSMutableArray *colArray = [[NSMutableArray alloc]init];
        
        for (int r = 0; r < (boardWidth / tileSize); r++) {
            GameTypeMainTile *newTile = [[[GameTypeMainTile alloc] initWithFile:@"no_background.png" isUsable:YES] autorelease];
            newTile.position =  ccp((tileSize*r), (tileSize*c));
            [boardLayer1 addChild: newTile];
            [colArray addObject:newTile];
        }
        [boardArray1 addObject: colArray];
    }
    
    //Create Layer 2
    for( int c = 0; c <  (boardHeight / tileSize); c++){
        
        NSMutableArray *colArray = [[NSMutableArray alloc]init];
        
        for (int r = 0; r < (boardWidth / tileSize); r++) {
            
            if(c < ((boardHeight / tileSize)-3) || r > 2){
                GameTypeMainTile *newTile = [[[GameTypeMainTile alloc] initWithFile:@"BrownTile.png" isUsable:NO] autorelease];
                newTile.position =  ccp((tileSize*r), (tileSize*c));
                [boardLayer2 addChild: newTile];
                [colArray addObject: newTile];
            }else{
                //Leave Blank
                GameTypeMainTile *newTile = [[[GameTypeMainTile alloc] initWithFile:@"no_background.png" isUsable:YES] autorelease];
                newTile.position =  ccp((tileSize*r), (tileSize*c));
                [boardLayer2 addChild: newTile];
                [colArray addObject: newTile];
            }
        }
        [boardArray2 addObject:colArray];
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

//ToDo - Revamp Detection to be more optimal and fun for user. Radius isnt the best Option.
- (void)changeTilesForActiveLetters{
   
    NSMutableArray *tilesToChange = [[NSMutableArray alloc] init];
    
    //Find The Radius based on word length
    int radius = 0;
    NSMutableArray *positionArray = [self generateCurrentLetterPositionArray];
    radius = (int)floorf([positionArray count]/2);
    
    //Use Radius to build a tile Array of all letters within the radius of the word
    for(NSMutableArray *objectArray in positionArray){
        int col = [[objectArray objectAtIndex:1] intValue];
        int row = [[objectArray objectAtIndex:2] intValue];
        
        for(int r = 1; r <= radius; r++){
           
            NSNumber *tileCol = [[NSNumber alloc]initWithInt:(col)];
            NSNumber *tileRow = [[NSNumber alloc]initWithInt:(row)];
            NSNumber *tileColPos = [[NSNumber alloc]initWithInt:(col+r)];
            NSNumber *tileRowPos = [[NSNumber alloc]initWithInt:(row+r)];
            NSNumber *tileColNeg = [[NSNumber alloc]initWithInt:(col-r)];
            NSNumber *tileRowNeg = [[NSNumber alloc]initWithInt:(row-r)];
            
            //Top
            if([tileColPos intValue] < tilesInRow){
                GameTypeMainTile *tileTop = [self tileAtCol:tileColPos andRow:tileRow];
                if(![tilesToChange containsObject:tileTop]){
                    [tilesToChange addObject:tileTop];
                }  
            }
            //TR
            if([tileRowPos intValue] < tilesInRow && [tileColPos intValue] < tilesInRow){
                GameTypeMainTile *tileTR = [self tileAtCol:tileColPos andRow:tileRowPos];
                if(![tilesToChange containsObject:tileTR]){
                    [tilesToChange addObject:tileTR];
                }
            }
            
            //Right
            if([tileRowPos intValue] < tilesInRow){
                GameTypeMainTile *tileRight = [self tileAtCol:tileCol andRow:tileRowPos];
                if(![tilesToChange containsObject:tileRight]){
                    [tilesToChange addObject:tileRight];
                }
            }
            
            //BR
            if([tileRowPos intValue] < tilesInRow && [tileColNeg intValue] >= 0){
                GameTypeMainTile *tileBR = [self tileAtCol:tileColNeg andRow:tileRowPos];
                if(![tilesToChange containsObject:tileBR]){
                    [tilesToChange addObject:tileBR];
                }
            }
            
            //Bottom
            if([tileColNeg intValue] >= 0){
                GameTypeMainTile *tileBottom = [self tileAtCol:tileColNeg andRow:tileRow];
                if(![tilesToChange containsObject:tileBottom]){
                    [tilesToChange addObject:tileBottom];
                }
            }
            //BL
            if([tileRowNeg intValue] >= 0 && [tileColNeg intValue] >= 0){
                GameTypeMainTile *tileBL = [self tileAtCol:tileColNeg andRow:tileRowNeg];
                if(![tilesToChange containsObject:tileBL]){
                    [tilesToChange addObject:tileBL];
                }
            }
            
            //Left
            if([tileRowNeg intValue] >= 0){
                GameTypeMainTile *tileLeft = [self tileAtCol:tileCol andRow:tileRowNeg];
                if(![tilesToChange containsObject:tileLeft]){
                    [tilesToChange addObject:tileLeft];
                }
            }
            //TL
            if([tileRowNeg intValue] >= 0 && [tileColPos intValue] < tilesInRow){
                GameTypeMainTile *tileBL = [self tileAtCol:tileColPos andRow:tileRowNeg];
                if(![tilesToChange containsObject:tileBL]){
                    [tilesToChange addObject:tileBL];
                }
            }
        }
    }
    
    [self setTileArray:tilesToChange To:@"empty"];
    
    NSLog(@"Radius Value is : %d, Count is : %d", radius, [tilesToChange count]);
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
    for(NSMutableArray *array in boardArray2){
        for (GameTypeMainTile *sprite in array) {
            CGRect TileRect = CGRectMake(sprite.position.x, sprite.position.y, sprite.contentSize.width, sprite.contentSize.height);
            CGRect LetterRect = CGRectMake(Letter.position.x, Letter.position.y, Letter.contentSize.width, Letter.contentSize.height);
            
            //Check On Letter
            if (CGRectIntersectsRect(TileRect, LetterRect)) {
                float interSectionNumber = CGRectGetWidth(CGRectIntersection(TileRect, LetterRect)) * CGRectGetHeight(CGRectIntersection(TileRect, LetterRect));
                
                if(highestValue <= interSectionNumber){
                    tile = sprite;
                    highestValue = interSectionNumber;
                }
            }
            
        }
    }
    
    //NSLog(@"Highest Letter Intersect Value : %f", highestValue);
    return tile;
}

//Return a Position Array of all active Letters
-(NSMutableArray *)generateCurrentLetterPositionArray{
    
    NSMutableArray *positionArray = [[NSMutableArray alloc]init];
    
    //Build an array of positions for the letters in word array
    for( int c = 0; c < [boardArray2 count]; c++){
        
        NSMutableArray *colArray = [boardArray2 objectAtIndex:c];
        
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

- (GameTypeMainTile *)tileAtCol:(NSNumber *)Col andRow:(NSNumber *)Row{
    
    GameTypeMainTile *returnTile = [[boardArray2 objectAtIndex:[Col intValue]]  objectAtIndex:[Row intValue]];
    
    return returnTile;
}

- (void)setTileArray:(NSMutableArray *)tileArray To:(NSString *)state{
    
    if(state == @"empty"){
        for(GameTypeMainTile *tile in tileArray){
            [tile setAsEmpty];
        }
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

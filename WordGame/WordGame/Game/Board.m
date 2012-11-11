//
//  Board.m
//  WordGame
//
//  Created by Adam Jacaruso on 3/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
#import "Board.h"

#define numberOfLettersInBank 14
#define boardXMargin 20

@implementation Board
@synthesize boardSprite, letterArray, boardArray, tileArray;


- (void)dealloc {

    boardSprite = nil;
    [boardSprite release];

    letterArray = nil;
    [letterArray release];
    
    boardArray = nil;
    [boardArray release];
    
    tileArray = nil;
    [tileArray release];
    
    [super dealloc];
}

-(id) init
{
    if( (self=[super initWithColor:ccc4(255,255,255,255)] )) {
        
        letterArray = [[NSMutableArray alloc] init];
        
        [self schedule:@selector(addLetter:) interval:1.0];
    }	
    return self;
}


#pragma mark - Letter Bank

-(void)clearLetterBank{
    [self clearBoard];
    for(int i=0; i<[letterArray count]; i++)
    {
        [self removeChild:[letterArray objectAtIndex:(i)] cleanup:YES];
        //[[letterArray objectAtIndex:(i)] release];
    }
    [letterArray removeAllObjects];
    
}

-(void)addLetter:(ccTime)dt {
    
    if([letterArray count] < numberOfLettersInBank){
        
        Letter *myLetter = [[Letter alloc] lock: false];
        
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        int offSetX = myLetter.contentSize.width/(numberOfLettersInBank/2);
        int offSetY = myLetter.contentSize.height / 3;
        int minX = myLetter.contentSize.width;
        int maxX = winSize.width + minX;
        
        int goToY = myLetter.contentSize.height + (offSetY * 2);
        int goToX = (minX + ((minX+offSetX) * [letterArray count]))-(myLetter.contentSize.width-offSetX);
        
        int travelTime = 1;
        
         if ([letterArray count] >= (numberOfLettersInBank/2)) {
            goToY = offSetY;
            goToX = (minX + ((minX+offSetX) * ([letterArray count] - (numberOfLettersInBank/2))))-(myLetter.contentSize.width-offSetX);
        }
        
        myLetter.position = ccp(maxX, goToY);
        id letterMove = [CCMoveTo actionWithDuration:travelTime position:ccp(goToX, goToY)];
        id letterMoveDone = [CCCallFuncN actionWithTarget:self selector:@selector(letterMoveFinished:)];
        [myLetter runAction:[CCSequence actions:letterMove, letterMoveDone, nil]];
        
        [myLetter setLetterBankX:goToX];
        [myLetter setLetterBankY:goToY];
        
        myLetter.tag = 1;
        [self addChild:myLetter];
        [letterArray addObject:myLetter];
    }
}

-(void) organiseLetterBank{
    NSMutableArray *newLetterArray = [[NSMutableArray alloc] init];
    for(int i = 0; i < [letterArray count]; i++){
        if([[letterArray objectAtIndex:i] isKindOfClass:[Letter class]]){
            [newLetterArray addObject:[letterArray objectAtIndex:i]];
        }
    }
    
    letterArray = newLetterArray;
    
    for(int i2 = 0; i2 < [letterArray count]; i2++){
        
        Letter *tempLetter = [letterArray objectAtIndex:i2];

        int offSetX = tempLetter.contentSize.width/(numberOfLettersInBank/2);
        int offSetY = tempLetter.contentSize.height / 3;
        int minX = tempLetter.contentSize.width;
        
        int goToY = tempLetter.contentSize.height + (offSetY * 2);
        int goToX = (minX + ((minX+offSetX) * i2))-(tempLetter.contentSize.width-offSetX);
        
        if (i2 >= (numberOfLettersInBank/2)) {
            goToY = offSetY;
            goToX = (minX + ((minX+offSetX) * (i2 - (numberOfLettersInBank/2))))-(tempLetter.contentSize.width-offSetX);
        }
        
        [[letterArray objectAtIndex:i2] stopAllActions];
        [[letterArray objectAtIndex:i2] setLetterBankX:goToX];
        [[letterArray objectAtIndex:i2] setLetterBankY:goToY];
        [[letterArray objectAtIndex:i2] goToSetPosition];
        
        tempLetter = nil;
        [tempLetter release];
    }
}

-(void)letterMoveFinished:(id)sender {
    
}

- (void)selectSpriteForTouch:(CGPoint)touchLocation {
    Letter *newSprite = nil;
        
    for (Letter *sprite in letterArray) {
        if (CGRectContainsPoint(sprite.boundingBox, touchLocation)) {            
            newSprite = sprite;
            break;
        }
    }    
    if (newSprite != selLetter) {
                   
        selLetter = newSprite;
        
        //Move Selected Letter from behind finger
        //selLetter.position = ccp(selLetter.position.x, (selLetter.position.y+tileHeight));
        selLetter.scale = 1.4f;
        selLetter.opacity = 150;
        
        //ToDo: Reword z-indexing
        //Make Selected Sprite the highest index
        //currentLetterZIndex++;
        //[self reorderChild:selLetter z:currentLetterZIndex];
        
    }
}

#pragma mark - Move Events

- (void)handlePanFrom:(UIPanGestureRecognizer *)recognizer {
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {    
        
        CGPoint touchLocation = [recognizer locationInView:recognizer.view];
        touchLocation = [[CCDirector sharedDirector] convertToGL:touchLocation];
        touchLocation = [self convertToNodeSpace:touchLocation];                
        [self selectSpriteForTouch:touchLocation];
        
    } else if (recognizer.state == UIGestureRecognizerStateChanged) {    
        
        CGPoint translation = [recognizer translationInView:recognizer.view];
        translation = ccp(translation.x, -translation.y);
        [self panForTranslation:translation];
        [recognizer setTranslation:CGPointZero inView:recognizer.view];    
        
    } else if (recognizer.state == UIGestureRecognizerStateEnded) {
        
        if(selLetter){
            selLetter.scale = 1.0f;
            selLetter.opacity = 255;
            
            //Check if Letter is Already in Array and Remove It
            for (int w = 0; w < boardWidth; w++) {
                NSMutableArray *rowArray = [boardArray objectAtIndex:w];
                for (int h = 0; h < boardHeight; h++) {
                    if([rowArray objectAtIndex:h] == selLetter){
                        [rowArray replaceObjectAtIndex:h withObject:[NSNull null]];
                    }
                }
            }
            
            if([self checkOnBoard:selLetter]){
                [self addSpriteToBoardArray:selLetter];
            }else if([[self checkOnLetter:selLetter] isKindOfClass:[Letter class]]){
                Letter *draggedLetter = [self checkOnLetter:selLetter];
                [self swapLettersInBank:selLetter with:draggedLetter];
            }else{
                selLetter.position = ccp([selLetter getLetterBankX], [selLetter getLetterBankY]);
            }
            
        }else if(boardSprite){
             
            float scrollDuration = 0.4;
            CGPoint velocity = [recognizer velocityInView:recognizer.view];
            CGPoint newPos = ccpAdd(self.boardSprite.position, ccpMult(velocity, scrollDuration));
            newPos = [self boardPos:newPos];
             
            int arrayCounter = 0;
            CGSize winSize = [CCDirector sharedDirector].winSize;
            for (NSMutableArray *letRow in boardArray){
                for (Letter *let in letRow) {
                    if([let isKindOfClass:[Letter class]]){
                        CGPoint newLetterPos = ccpAdd(let.position, ccpMult(velocity, scrollDuration));
                        newLetterPos.x = MIN(newLetterPos.x, ((arrayCounter * tileWidth) + boardXMargin));
                        newLetterPos.x = MAX(newLetterPos.x, ((-((boardWidth)*tileWidth)+winSize.width)+(arrayCounter * tileWidth)-boardXMargin)); 
                        newLetterPos.y = let.position.y;
                        [let stopAllActions];
                        CCMoveTo *moveLetTo = [CCMoveTo actionWithDuration:scrollDuration position:newLetterPos]; 
                        [let runAction:[CCEaseInOut actionWithAction:moveLetTo rate:1]]; 
                    }
                }
                arrayCounter++;
            }
            
            [self.boardSprite stopAllActions];
            CCMoveTo *moveTo = [CCMoveTo actionWithDuration:scrollDuration position:newPos];            
            [self.boardSprite runAction:[CCEaseInOut actionWithAction:moveTo rate:1]];    
        }
    }        
}

- (void)panForTranslation:(CGPoint)translation {    
    if (selLetter) {
        CGPoint newPos = ccpAdd(selLetter.position, translation);
        selLetter.position = newPos;
    }else if(boardSprite){
        CGPoint newPos = ccpAdd(boardSprite.position, translation);
        boardSprite.position = [self boardPos:newPos]; 
        
        int arrayCounter = 0;
        CGSize winSize = [CCDirector sharedDirector].winSize;
        for (NSMutableArray *letRow in boardArray){
            for (Letter *let in letRow) {
                if([let isKindOfClass:[Letter class]]){
                    CGPoint newLetterPos = ccpAdd(let.position, translation);
                    newLetterPos.x = MIN(newLetterPos.x, ((arrayCounter * tileWidth) + boardXMargin));
                    newLetterPos.x = MAX(newLetterPos.x, ((-((boardWidth)*tileWidth)+winSize.width)+(arrayCounter * tileWidth)-boardXMargin)); 
                    newLetterPos.y = let.position.y;
                    let.position = newLetterPos;
                }
            }
            arrayCounter++;
        }
    }
}

- (CGPoint)boardPos:(CGPoint)newPos {
    CGSize winSize = [CCDirector sharedDirector].winSize;
    CGPoint retval = newPos;
    retval.x = MIN(retval.x, (0 + boardXMargin));
    retval.x = MAX(retval.x, (-((boardWidth)*tileWidth)+winSize.width)-boardXMargin); 
    retval.y = boardSprite.position.y;
    return retval;
}

#pragma mark - Board Container Functions

-(void)initBoard:(NSDictionary *)level{
    
    int tileCounter = 0;
    NSMutableArray *tiles = [level objectForKey:@"tileArray"];
    tileArray = [[NSMutableArray alloc] init];
    
    boardWidth = [[level objectForKey:@"boardWidth"] intValue];
    boardHeight = [[level objectForKey:@"boardHeight"] intValue];
    tileWidth = [[level objectForKey:@"tileWidth"] intValue];
    tileHeight = [[level objectForKey:@"tileHeight"] intValue];
    
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    boardSprite = [CCSprite spriteWithFile:@"" rect:CGRectMake(0, 0, ((boardWidth)*tileWidth), (boardHeight*tileHeight))];
    boardSprite.anchorPoint = ccp(0, 0);
    boardSprite.position = ccp((0 + boardXMargin), ((winSize.height - (boardHeight*tileHeight))/2)+(tileHeight/2) );
    [self addChild:boardSprite];
    
    boardArray = [[NSMutableArray alloc] init];
    
    for (int w = 0; w < boardWidth; w++) {
        NSMutableArray *tempWidthArray = [[[NSMutableArray alloc] init] autorelease];
        for (int h = 0; h < boardHeight; h++) {
            
            NSDictionary *tileInformation = [tiles objectAtIndex:tileCounter];
            NSString *tileImage = [tileInformation objectForKey:@"image"];
            NSString *isUseable = [tileInformation objectForKey:@"useable"];
            
            Tile *newTile = [[[Tile alloc] initWithFile:tileImage] autorelease];
            
            [newTile setPosX:(tileWidth * w)];
            [newTile setPosY:(tileHeight * h)];
            [newTile goToSetPosition];
            [newTile setUseable:[isUseable boolValue]];
            [tileArray addObject:newTile];
            [boardSprite addChild:newTile];
            
            [tempWidthArray addObject:[NSNull null]];
            tileCounter++;
        }
        [boardArray addObject:tempWidthArray];
    }
    currentLetterZIndex = (tileCounter + 2);
}

-(void)addSpriteToBoardArray:(Letter *)letterSprite{
   
    //Calculate difference between where the piece is relative to the top left corner of the board
    
    int offsetX = letterSprite.position.x - boardSprite.position.x;
    int offsetY = letterSprite.position.y - boardSprite.position.y;
    
    //Calculate the closest Array Slot and Position based on tilesize / board size
    
    int rowX = round((double)offsetX / (double)tileWidth );
    int colY = round((double)offsetY / (double)tileHeight );
    
    //Check to make sure round doesn't move object out of the grid
    if(rowX < 0){
        rowX = 0;
    }else if(rowX >= boardWidth){
        rowX = (boardWidth-1);
    }
    
    if(colY < 0){
        colY = 0;
    }else if(colY >= boardHeight){
        colY = (boardHeight-1);
    }
    //NSLog(@"row is %d of %d", rowX , boardWidth);
    //NSLog(@"col is %d of %d", colY , boardHeight);
    
    int tileIndex = (rowX * boardHeight) + colY;
    
    //NSLog(@"Tile #: %d is useable? %d", tileIndex, [[tileArray objectAtIndex:tileIndex] getUseable]);
    
    //See if Array Slot is Open
    NSMutableArray *rowArray = [boardArray objectAtIndex:rowX];
    if([rowArray objectAtIndex:colY] != [NSNull null] || ![[tileArray objectAtIndex:tileIndex] getUseable]){
        //Is Not Available
        letterSprite.position = ccp([letterSprite getLetterBankX], [letterSprite getLetterBankY]);
    }else{
        //Is Available
        letterSprite.position = ccp((rowX * tileWidth)+boardSprite.position.x, (colY * tileHeight)+boardSprite.position.y);
        [rowArray replaceObjectAtIndex:colY withObject:selLetter];
    }
}


-(BOOL)checkOnBoard:(Letter *)letterSprite{
    
    CGRect boardRect = CGRectMake(boardSprite.position.x, boardSprite.position.y, boardSprite.contentSize.width, boardSprite.contentSize.height);
    
    CGRect letterRect = CGRectMake(letterSprite.position.x, letterSprite.position.y, letterSprite.contentSize.width, letterSprite.contentSize.height);
    
    //Check On Board
    if (CGRectIntersectsRect(boardRect, letterRect)) {
        return true;
    }else{
        return false;
    }
}

-(Letter *)checkOnLetter:(Letter *)letterSprite{
    
    float highestValue = 200.0f;
    Letter *returnSprite = nil;
    
    for (Letter *sprite in letterArray) {
        CGRect letterRect1 = CGRectMake(sprite.position.x, sprite.position.y, sprite.contentSize.width, sprite.contentSize.height);
        CGRect letterRect2 = CGRectMake(letterSprite.position.x, letterSprite.position.y, letterSprite.contentSize.width, letterSprite.contentSize.height);
        
        //Check On Letter
        if (CGRectIntersectsRect(letterRect1, letterRect2) && (sprite != letterSprite)) {
            float interSectionNumber = CGRectGetWidth(CGRectIntersection(letterRect1, letterRect2)) * CGRectGetHeight(CGRectIntersection(letterRect1, letterRect2));
            
            if(highestValue <= interSectionNumber){ returnSprite = sprite; highestValue = interSectionNumber; }
        }
    }
    
    NSLog(@"Highest Letter Intersect Value : %f", highestValue);
    return returnSprite;
}

-(void) swapLettersInBank:(Letter *)firstLetter with:(Letter *)secondLetter{

    CGPoint LetterPos1 = [firstLetter getLetterPosition];
    CGPoint LetterPos2 = [secondLetter getLetterPosition];
    
    [firstLetter setLetterBankX:LetterPos2.x];
    [firstLetter setLetterBankY:LetterPos2.y];
    
    [secondLetter setLetterBankX:LetterPos1.x];
    [secondLetter setLetterBankY:LetterPos1.y];

    [firstLetter goToSetPosition];
    [secondLetter goToSetPosition];
    
    [letterArray exchangeObjectAtIndex:[letterArray indexOfObject:firstLetter] withObjectAtIndex:[letterArray indexOfObject:secondLetter]];
}

#pragma mark - Board Events

-(NSMutableArray *)submitBoard{
    
    BOOL isFirstWordHasLetterInColOne = FALSE;
    BOOL isFirstWord = TRUE;
    int LetterCount = 0;
    
    for (int w = 0; w < boardWidth; w++) {
        NSMutableArray *rowArray = [boardArray objectAtIndex:w];
        for (int h = 0; h < boardHeight; h++) {
            if([rowArray objectAtIndex:h] != [NSNull null]){

                if(w == 0){
                    isFirstWordHasLetterInColOne = TRUE;
                }
                
                if([[rowArray objectAtIndex:h] getLocked]){
                    isFirstWord = FALSE;
                }else{
                    LetterCount++;
                }
            }
        }
    }
    
    
    NSMutableArray *returnWordArray = [[[NSMutableArray alloc] init] autorelease];
    NSMutableArray *word1 = [[[NSMutableArray alloc] init] autorelease];
    NSMutableArray *word2 = [[[NSMutableArray alloc] init] autorelease];
    NSMutableArray *empty = [[[NSMutableArray alloc] init] autorelease];
    
    
    //If first word does not contain a Letter in First Col, return empty array
    if(!isFirstWordHasLetterInColOne && isFirstWord){
        NSLog(@"No Letter Inside first col");
        
        NSString *errorString = [[[NSString alloc] initWithFormat:@"There Is No Letter Inside First Col"] autorelease];
        
        UIAlertView *newAlert = [[[UIAlertView alloc] initWithTitle:@"Sorry :(" message:errorString delegate:self cancelButtonTitle:@"Try Again" otherButtonTitles:nil, nil] autorelease];
        
        [newAlert show];
        newAlert = nil;
        
        [returnWordArray addObject:empty];
        return returnWordArray;
    }
    
    //Start is first word
    //Check For First unlocked Letter
    for (int w = 0; w < boardWidth; w++) {
        NSMutableArray *rowArray = [boardArray objectAtIndex:w];
        for (int h = 0; h < boardHeight; h++) {
            if([rowArray objectAtIndex:h] != [NSNull null]){
                if(![[rowArray objectAtIndex:h] getLocked]){
                    //Letter Found - See if Letter to right
                    NSLog(@"test: %@", [[rowArray objectAtIndex:h] getLetter]);
                    //Letter to right 
                    if(h+1 < boardHeight && h-1 >= 0){
                        //If Space is Letter
                        if([rowArray objectAtIndex:h+1] != [NSNull null] || [rowArray objectAtIndex:h-1] != [NSNull null]){
                            
                            //Check for previous letters
                            for(int h2 = h; h2 > 0; h2--){
                                if([rowArray objectAtIndex:(h2-1)] != [NSNull null]){
                                    //NSLog(@"Before Letter: %@", [[rowArray objectAtIndex:(h2-1)] getLetter]);
                                   [word1 addObject:[rowArray objectAtIndex:h2-1]];
                                }else{
                                    break;
                                }
                            }
                            
                            word1 = [self invertArray:word1];
                            
                            
                            BOOL hitNull = FALSE;
                            //Add continuous letters from here in this row
                            for(int h2 = h; h2 < boardHeight; h2++){
                              if([rowArray objectAtIndex:h2] != [NSNull null]){
                                  if(!hitNull){
                                      [word1 addObject:[rowArray objectAtIndex:h2]];
                                  }else{
                                      NSLog(@"Invalid0");
                                      [returnWordArray addObject:empty];
                                      return returnWordArray;
                                  }
                              }else{
                                  hitNull = true;
                              }
                            }
                            
                            
                            NSLog(@"LC: %d - ULC: %d", LetterCount, [word1 count]);
                            if(LetterCount <= [word1 count]){
                                NSLog(@"Valid1");
                                    //check for second word
                                    
                                    //Check for previous letters
                                    for(int w2 = w; w2 > 0; w2--){
                                        NSMutableArray *wRowArray = [boardArray objectAtIndex:(w2-1)];
                                        if([wRowArray objectAtIndex:h] != [NSNull null]){
                                            [word2 addObject:[wRowArray objectAtIndex:h]];
                                        }else{
                                            break;
                                        }
                                    }
                                
                                    word2 = [self invertArray:word2];
                                
                                    BOOL hitNull = FALSE;
                                    for(int w2 = w; w2 < boardWidth; w2++){
                                        NSMutableArray *wRowArray = [boardArray objectAtIndex:w2];
                                        if([wRowArray objectAtIndex:h] != [NSNull null]){
                                            if(!hitNull){
                                                [word2 addObject:[wRowArray objectAtIndex:h]];
                                            }else{
                                                [returnWordArray addObject:empty];
                                                return returnWordArray;
                                            }
                                        }else{
                                            hitNull = true;
                                        }
                                    }

                                //Inverse Letter Order
                                word1 = [self invertArray:word1];
                                [returnWordArray addObject:word1];
                               
                                //NSLog(@"word2 count : %d", [word2 count]);
                                if ([word2 count] > 1) {
                                    [returnWordArray addObject:word2];
                                }
                                return returnWordArray;
                            }else{
                                [returnWordArray addObject:empty];
                                return returnWordArray;
                            }
                            
                        //Check is Letter To Right
                        }else{
                            //Check for previous letters
                            for(int w2 = w; w2 > 0; w2--){
                                NSMutableArray *wRowArray = [boardArray objectAtIndex:(w2-1)];
                                if([wRowArray objectAtIndex:h] != [NSNull null]){
                                        [word1 addObject:[wRowArray objectAtIndex:h]];
                                }else{
                                    break;
                                }
                            }
                            
                            word1 = [self invertArray:word1];
                            
                            BOOL hitNull = FALSE;
                            for(int w2 = w; w2 < boardWidth; w2++){
                                NSMutableArray *wRowArray = [boardArray objectAtIndex:w2];
                                if([wRowArray objectAtIndex:h] != [NSNull null]){
                                    if(!hitNull){
                                        [word1 addObject:[wRowArray objectAtIndex:h]];
                                    }else{
                                        [returnWordArray addObject:empty];
                                        return returnWordArray;
                                    }
                                }else{
                                    hitNull = true;
                                }
                            }
                            
                            NSLog(@"LC: %d - ULC: %d", LetterCount, [word1 count]);
                            if(LetterCount <= [word1 count]){
                                NSLog(@"Valid4");
                                [returnWordArray addObject:word1];
                                return returnWordArray;
                            }else{
                                [returnWordArray addObject:empty];
                                return returnWordArray;
                            }

                        }
                    //Check is Letter To Right
                    }else{
                        //Check for previous letters
                        for(int w2 = w; w2 > 0; w2--){
                            NSMutableArray *wRowArray = [boardArray objectAtIndex:(w2-1)];
                            if([wRowArray objectAtIndex:h] != [NSNull null]){
                                [word1 addObject:[wRowArray objectAtIndex:h]];
                            }else{
                                break;
                            }
                        }
                        
                        word1 = [self invertArray:word1];
                        
                        BOOL hitNull = FALSE;
                        for(int w2 = w; w2 < boardWidth; w2++){
                            NSMutableArray *wRowArray = [boardArray objectAtIndex:w2];
                            if([wRowArray objectAtIndex:h] != [NSNull null]){
                                if(!hitNull){
                                    [word1 addObject:[wRowArray objectAtIndex:h]];
                                }else{
                                    [returnWordArray addObject:empty];
                                    return returnWordArray;
                                }
                            }else{
                                hitNull = true;
                            }
                        }
                        //NSLog(@"LC: %d - ULC: %d", LetterCount, [word1 count]);
                        if(LetterCount == [word1 count]){
                            NSLog(@"Valid7");
                            [returnWordArray addObject:word1];
                            return returnWordArray;
                        }else{
                            [returnWordArray addObject:empty];
                            return returnWordArray;
                        }
                    }
                }// If Locked
            }//If 
        }//For h 
    }//For w
    
    [returnWordArray addObject:empty];
    return returnWordArray;
}

-(void)clearBoard{
    for (int w = 0; w < boardWidth; w++) {
        NSMutableArray *rowArray = [boardArray objectAtIndex:w];
        for (int h = 0; h < boardHeight; h++) {
            if([rowArray objectAtIndex:h] != [NSNull null]){
                if(![[rowArray objectAtIndex:h] getLocked]){
                    //Reset Poisition to word bank and set board array slot to null(empty)
                    [[rowArray objectAtIndex:h] goToSetPosition];
                    [rowArray replaceObjectAtIndex:h withObject:[NSNull null]];
                
                }
            }
        }
    }
}

-(NSMutableArray *)invertArray:(NSMutableArray *)originalArray{
    NSMutableArray *newArray = [[[NSMutableArray alloc] init] autorelease];
    
    if([originalArray count] != 0){
        for(int i = [originalArray count]; i > 0; i--){
            [newArray addObject:[originalArray objectAtIndex:(i-1)]];
        }
    }
    return newArray;
}

-(void)lockLetters{
    //set all letters on board to locked
    NSArray *col = nil;
    
    for (int w = 0; w < boardWidth; w++) {
        col = [boardArray objectAtIndex:w];
        for (int h = 0; h < boardHeight; h++) {
            if([col objectAtIndex:h] != [NSNull null]){
                [[col objectAtIndex:h] setLocked:TRUE];
                [letterArray removeObject:[col objectAtIndex:h]];
            }
        }
    }
    [self organiseLetterBank]; 
}

- (BOOL)isWin:(NSMutableArray *) wordArray{
    BOOL didWin=FALSE;
    for (int w = 0; w < boardWidth; w++) {
        NSMutableArray *rowArray = [boardArray objectAtIndex:w];
        for (int h = 0; h < boardHeight; h++) {
            if([rowArray objectAtIndex:h] != [NSNull null]){
                if(w == boardWidth-1 && [[rowArray objectAtIndex:h] getLocked]){
                    didWin = TRUE;
                }
            }
        }
    }
    return didWin;
}
- (BOOL)isWordAttached:(NSMutableArray *) wordArray{
    BOOL isFirstWord = TRUE;
   
    for (int w = 0; w < boardWidth; w++) {
        NSMutableArray *rowArray = [boardArray objectAtIndex:w];
        for (int h = 0; h < boardHeight; h++) {
            if([rowArray objectAtIndex:h] != [NSNull null]){
                if([[rowArray objectAtIndex:h] getLocked]){
                    isFirstWord = FALSE;
                }
                 
            }
        }
    }
    
    if (isFirstWord) {
        return TRUE;
    }
    
    
    BOOL isAttached = TRUE;
    NSMutableArray *attachedArray = [[[NSMutableArray alloc] init] autorelease];
    
    for(NSMutableArray *word in wordArray)
    {
        bool wordHasLockedLetter = false;
        
        for(Letter *let in word)
        {
            NSLog(@"Testing %@", [let getLetter]);
            if([let getLocked]){
                wordHasLockedLetter = true;   
            }
        }
        [attachedArray addObject:[NSNumber numberWithBool:wordHasLockedLetter]];       
    }
    
    for(int i = 0; i < [attachedArray count]; i++){
        
        if(![[attachedArray objectAtIndex:i] boolValue]){
            isAttached = FALSE;
        }
    }
    
    return isAttached;
}

@end
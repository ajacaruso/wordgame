#import "GameTypeMain.h"
#import "GameTypeMainOverlay.h"
#import "GameTypeMainCompleted.h"

@implementation GameTypeMain
@synthesize backMenu, playArea, gameControlls, selLetter, lastDragPoint, currentResetPoint;

-(id) init
{
	if( (self=[super init])) {
        
        //Build Game Controlls
        gameControlls = [[[GameTypeMainControlls alloc] initWithControlls:@"Controlls" withManager:self] autorelease];
        gameControlls.anchorPoint = ccp(0,0);
        gameControlls.position = ccp(0,0);
        
        //Build Play Area
        playArea = [[GameTypeMainPlayArea alloc] initPlayArea];
        playArea.anchorPoint = ccp(0,0);
        playArea.position = ccp(0, gameControlls.contentSize.height);
        
        //Add Game Controlls on top of play area to hide tiles.
        [self addChild:playArea z:1];
        [self addChild:gameControlls z:1];
        
        currentResetPoint = 0;
        
        //Set Timers
        [self schedule:@selector(moveBoard:) interval:boardScrollRate];
    }
	return self;
}

- (void) dealloc
{
	[super dealloc];
}

#pragma mark - Controls

-(void)openMenu
{
    GameTypeMainOverlay *OverlayMenu = [[[GameTypeMainOverlay alloc] initMenuOverlay:self] autorelease];
    [self addChild:OverlayMenu z:2];
    [gameControlls enableControls:(FALSE)];
}

-(void)closeMenu
{
    [gameControlls enableControls:(TRUE)];
}

-(void)submitWord:(NSString *)specialAbility{
    [playArea submitWord:specialAbility];
}

#pragma mark - Move Events / Functions

- (void)moveBoard:(ccTime)dt{
    CCSprite *theBoard = playArea.gameBoard.boardLayer;
    int newX = theBoard.position.x;
    int newY = theBoard.position.y + tileSize;
    // Create the actions
    CCMoveTo * actionMove = [CCMoveTo actionWithDuration:1 position:ccp(newX, newY)];
    CCCallBlockN * actionMoveDone = [CCCallBlockN actionWithBlock:^(CCNode *node) {
        [playArea.gameBoard addBoardMoveOffset:tileSize];
        [self checkMoveCompleted];
    }];
    [theBoard runAction:[CCSequence actions:actionMove, actionMoveDone, nil]];
}

- (void)handlePanFrom:(UIPanGestureRecognizer *)recognizer {
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        CGPoint touchLocation = [recognizer locationInView:recognizer.view];
        touchLocation = [[CCDirector sharedDirector] convertToGL:touchLocation];
        touchLocation = [self convertToNodeSpace:touchLocation];
        [self selectSpriteForTouch:touchLocation];
        
    } else if (recognizer.state == UIGestureRecognizerStateChanged) {
        /*
        Check if in play area
        True - Move Sprite
        False - Do not Move Sprite
         */
       
        CGPoint translation = [recognizer translationInView:recognizer.view];
        translation = ccp(translation.x, -translation.y);
        [self panForTranslation:translation];
        [recognizer setTranslation:CGPointZero inView:recognizer.view];
        
        if([self spriteIsInPlayArea:selLetter]){
            //NSLog(@"In Play Area");
        }else{
            //NSLog(@"Not In Play Area");
            selLetter.position = lastDragPoint;
        }
        
    } else if (recognizer.state == UIGestureRecognizerStateEnded) {
        if(selLetter){
            selLetter.opacity = 255;
            
            //Check If on Board or Word Bank
            if([self spriteIsInWordBank:selLetter]){
                
                [self changeContainerOfSprite:selLetter to:playArea.wordBank];
                [self returnToWordBank:selLetter];
                
            }else if([self spriteIsInBoard:selLetter]){
                
                [self changeContainerOfSprite:selLetter to:playArea.gameBoard.boardLayer];
                
                //If Can't Be Placed On Board Return to WordBank
                if(![playArea.gameBoard addLetterToBoard:selLetter]){
                    [self changeContainerOfSprite:selLetter to:playArea.wordBank];
                    [selLetter goToOriginalPosition];
                }
                
            }
            
            NSLog(@"Board Letter Count : %d", [playArea.gameBoard.boardLetters count]);
        }//end if sel letter
    }
}

- (void)panForTranslation:(CGPoint)translation {
    if (selLetter) {
        lastDragPoint = selLetter.position;
        CGPoint newPos = ccpAdd(selLetter.position, translation);
        selLetter.position = newPos;
    }
}

- (void)selectSpriteForTouch:(CGPoint)touchLocation {
    
    GameTypeMainLetter *newSprite = nil;
   
    for (GameTypeMainLetter *sprite in [playArea.wordBank getLetterBankArray]) {
        
        //Conversion Steps for Absolute Point
        CGRect boundingBox = [sprite boundingBox];
        boundingBox.origin = CGPointZero;
        
        GameTypeMainLetter *shape = sprite;
        CGPoint touchLocationRelativeToShape = [shape convertToNodeSpace: touchLocation];
        
        //Check if Letters boundingBox is in relative touch location
        if(CGRectContainsPoint(boundingBox, touchLocationRelativeToShape)){
            newSprite = sprite;
            NSLog(@"1 - In Box");
            break;
        }else{
            NSLog(@"2 - Not In Box");
        }
    }
    
    //If Letter Sprite Found, Set it to move. Else Deselect the last selLetter
    if (newSprite != nil) {
        selLetter = newSprite;
        selLetter.opacity = 150;
        [self changeContainerOfSprite:selLetter to:playArea];
        
        
        //Check If Letter Was On Board and Remove it from boardLetters if so
        //Also set its tile to useable true
        for(NSMutableArray *array in playArea.gameBoard.boardLetters){
            if([array objectAtIndex:0] == selLetter){
                [[array objectAtIndex:1] setUseable:true];
                [playArea.gameBoard.boardLetters removeObject:array];
                
                break;
            }
        }
        
    }else{
        selLetter = nil;
    }
}

#pragma mark - Game Logic

- (void)checkMoveCompleted{
    if(![playArea.gameBoard hasEmptySpace]){
        [self unschedule:@selector(moveBoard:)];
        GameTypeMainCompleted *CompletedMenu = [[[GameTypeMainCompleted alloc] initMenuOverlay:self] autorelease];
        [self addChild:CompletedMenu z:2];
        [gameControlls enableControls:(FALSE)];
    }else{
        [playArea.gameBoard cleanupBoard];
    }
    
    if(currentResetPoint > tilesInRow){
        currentResetPoint++;
    }else{
        currentResetPoint = 0;
        [playArea.gameBoard addRandomLevel];
    }
}

#pragma mark - Placement Checks

- (BOOL)spriteIsInPlayArea:(CCSprite *)sprite{
   
    //Conversion Steps for Absolute Point
    CGRect playAreaRect = CGRectMake(playArea.position.x, playArea.position.y-gameControlls.contentSize.height, playArea.contentSize.width, playArea.contentSize.height);
    CGRect letterRect = [sprite boundingBox];
    
    //Check In Play Area
    if (CGRectContainsRect(playAreaRect, letterRect)) {
        //NSLog(@"pa 1");
        return true;
    }else{
        //NSLog(@"pa 2");
        return false;
    }
}

-(BOOL)spriteIsInWordBank:(CCSprite *)sprite{
   
   CGRect wordRect = [playArea.wordBank boundingBox];
   CGRect letterRect = [sprite boundingBox];
    
    //Check In Play Area
    if (CGRectContainsRect(wordRect, letterRect)) {
        return true;
    }else{
        return false;
    }
}

-(BOOL)spriteIsInBoard:(CCSprite *)sprite{
   
    CGRect boardRect = playArea.gameBoard.boundingBox;
    CGRect letterRect = CGRectMake(sprite.position.x, sprite.position.y, sprite.contentSize.width, sprite.contentSize.height);
    
    //Check In Play Area
    if (CGRectIntersectsRect(boardRect, letterRect)) {
        return true;
    }else{
        return false;
    }
}

- (void) changeContainerOfSprite:(CCSprite *)sprite to:(CCSprite *)container{
    
    // NSLog(@"Offset Container %f - Parent %f ",  container.position.y, sprite.parent.position.y);
    
    //Calcualte X/Y Offset for Board / WB / PlayArea 
    if(container == playArea.gameBoard.boardLayer && sprite.parent == playArea){
        [sprite setPosition:ccp(sprite.position.x, sprite.position.y-playArea.wordBank.contentSize.height)];
    }else if(container == playArea && sprite.parent == playArea.gameBoard.boardLayer){
        [sprite setPosition:ccp(sprite.position.x, sprite.position.y+playArea.wordBank.contentSize.height)];
    }else{
        [sprite setPosition:ccp(sprite.position.x, sprite.position.y)];
    }
    
    //Move Sprite
    [sprite removeFromParentAndCleanup:NO];
    [container addChild:sprite z:999];
}

#pragma mark - Snap To Functions

-(void)returnToWordBank:(GameTypeMainLetter*)Letter{
    [Letter goToOriginalPosition];
}


@end
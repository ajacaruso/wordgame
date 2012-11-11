

#import "GameManager.h"
#import "MenuLayer.h"
#import "Letter.h"
#import "Utils.h"
//#import "GameDatabase.h"

//#define kDataKey @"Data"
//#define kDataFile @"Data.plist"

@implementation GameManager
@synthesize _BoardLayer, ScoreLbl = _ScoreLbl, Level = _Level, Score = _Score, DocPath = _DocPath;

- (void)dealloc {
    
    _BoardLayer = nil;
    [_BoardLayer release];
    
    _ScoreLbl = nil;
    [_ScoreLbl release];
    
    _DocPath = nil;
    [_DocPath release];
    
    [super dealloc];
}

- (id)init {
    
    if ((self = [super init])) {
        
        [self initLevelJson:@"level2"];

        //Init Board
        self._BoardLayer = [Board node];
        self._BoardLayer.anchorPoint=ccp(0,0);
        [_BoardLayer initBoard:_Level];
        
        [self addChild:_BoardLayer];
        
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        
        //InitScore
        NSString *scoreStr =@"Score: ";
        _Score=0;
        self.ScoreLbl = [CCLabelTTF labelWithString:[scoreStr stringByAppendingString:[NSString stringWithFormat:@"%d",_Score]] fontName:@"Arial" fontSize:20];
        _ScoreLbl.color = ccc3(225,0,0);
        _ScoreLbl.position = ccp((winSize.width-75), (winSize.height-40));
        [self addChild:_ScoreLbl];
        
        
        //Create Menu
        CCMenuItemImage *menuBtn = [CCMenuItemImage itemFromNormalImage:@"menu_btn.png"
                                                            selectedImage: @"menu_btn.png"
                                                                   target:self
                                                                 selector:@selector(backToMenu:)];
        
        CCMenuItemImage *checkBtn = [CCMenuItemImage itemFromNormalImage:@"submit_btn.png"
                                                          selectedImage: @"submit_btn.png"
                                                                 target:self
                                                               selector:@selector(submitBoard:)];
        
        CCMenuItemImage *clearBtn = [CCMenuItemImage itemFromNormalImage:@"clear_btn.png"
                                                           selectedImage: @"clear_btn.png"
                                                                  target:self
                                                                selector:@selector(clearBoard:)];
        
        CCMenu *mainMenuInit = [CCMenu menuWithItems: menuBtn, checkBtn, clearBtn, nil];
        [mainMenuInit alignItemsHorizontallyWithPadding:18.0f];
        
        mainMenuInit.position = ccp(90, (winSize.height-40));
        
        [self addChild:mainMenuInit];
    }
    return self;
}
/*
- (id)initFromPrevious: (NSString *) DocPath {
    if ((self = [super init])) {
        _DocPath = [DocPath copy];
    }
    return self;
}

-(BOOL)createDataPath {
    if(_DocPath == nil) {
        self.DocPath = [GameDatabase nextWordGameDocPath];
    }
    
    NSError *err;
    BOOL success = [[NSFileManager defaultManager] createDirectoryAtPath:_DocPath withIntermediateDirectories:YES attributes:nil error:&err];
    if(!success)
    {
        NSLog(@"Error creating data path: %@", [err localizedDescription]);
    }
    
    return success;
}

- (GameData *)data {
    
    if (_data != nil) return _data;
    
    NSString *dataPath = [_DocPath stringByAppendingPathComponent:kDataFile];
    NSData *codedData = [[[NSData alloc] initWithContentsOfFile:dataPath] autorelease];
    if (codedData == nil) return nil;
    
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:codedData];
    _data = [[unarchiver decodeObjectForKey:kDataKey] retain];    
    [unarchiver finishDecoding];
    [unarchiver release];
    
    return _data;
    
}

- (void)saveData {
    
    if (_data == nil) return;
    
    [self createDataPath];
    
    NSString *dataPath = [_DocPath stringByAppendingPathComponent:kDataFile];
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];          
    [archiver encodeObject:_data forKey:kDataKey];
    [archiver finishEncoding];
    [data writeToFile:dataPath atomically:YES];
    [archiver release];
    [data release];
    
}

- (void)deleteDoc {
    
    NSError *error;
    BOOL success = [[NSFileManager defaultManager] removeItemAtPath:_DocPath error:&error];
    if (!success) {
        NSLog(@"Error removing document path: %@", error.localizedDescription);
    }
    
}
*/

- (void) backToMenu: (CCMenuItem  *) menuItem 
{
    GameManager *MainMenu = [MenuLayer node];
    [[CCDirector sharedDirector] replaceScene:
	 [CCTransitionFade transitionWithDuration:0.5f scene:MainMenu]];
}

- (void) submitBoard: (CCMenuItem  *) menuItem 
{
    
    Utils *utils = [[[Utils alloc] init] autorelease];
    NSMutableArray *wordArray = [self._BoardLayer submitBoard];
    
    //Check If Word Connect to Previous
    if (![self._BoardLayer isWordAttached:wordArray]) {
        NSLog(@"Word is not attached to another word");
        NSString *errorString = [[[NSString alloc] initWithFormat:@"Word is not attached to another word"] autorelease];
        
        UIAlertView *newAlert = [[[UIAlertView alloc] initWithTitle:@"Sorry :(" message:errorString delegate:self cancelButtonTitle:@"Try Again" otherButtonTitles:nil, nil] autorelease];
        
        [newAlert show];
        newAlert = nil;
        return;
    }
    
    if([wordArray count] == 1)
    {
        NSMutableArray *wordArray1 = [wordArray objectAtIndex:0];
        NSString *word = @"";
        int wordVal = 0;
        
        for(Letter *let in wordArray1)
        {
            NSString *newLetter = [let getLetter];
            wordVal = wordVal + [let getPointVal];
            word = [word stringByAppendingString:newLetter];
        }
        
        if([utils isValidWord:word])
        {
            //good word. lock the board
            NSLog(@"%@ : Is Valid", word);
            [self._BoardLayer lockLetters];
            
            //Update score
            _Score = _Score + wordVal;
            [self updateScore];
            
            //check for win...
            if ([self._BoardLayer isWin:wordArray]) {
                NSLog(@"EPIC WIN");
                NSString *errorString = [[[NSString alloc] initWithFormat:@"A WINNER IS YOU!"] autorelease];
                
                UIAlertView *newAlert = [[[UIAlertView alloc] initWithTitle:@"w00t! :D" message:errorString delegate:self cancelButtonTitle:@"Woo Hoo!" otherButtonTitles:nil, nil] autorelease];
                
                [newAlert show];
                newAlert = nil;
                return;
            }
        }
        else {
            //bad word... error
            NSLog(@"%@ : Is Not Valid", word);
            NSString *errorString = [[[NSString alloc] initWithFormat:@" %@ - Is Not A Valid Word", word] autorelease];
            
            UIAlertView *newAlert = [[[UIAlertView alloc] initWithTitle:@"Sorry :(" message:errorString delegate:self cancelButtonTitle:@"Try Again" otherButtonTitles:nil, nil] autorelease];
            
            [newAlert show];
            newAlert = nil;
        }
        
    }else if([wordArray count] == 2){
        
        NSMutableArray *wordArray1 = [wordArray objectAtIndex:0];
        NSMutableArray *wordArray2 = [wordArray objectAtIndex:1];
        
        NSString *word1 = @"";
        NSString *word2 = @"";
        
        int wordVal = 0;
        int wordVal2 = 0;
        
        for(Letter *let in wordArray1)
        {
            NSString *newLetter = [let getLetter];
            wordVal = wordVal + [let getPointVal];
            word1 = [word1 stringByAppendingString:newLetter];
        }
        
        for(Letter *let in wordArray2)
        {
            NSString *newLetter = [let getLetter];
            wordVal2 = wordVal2 + [let getPointVal];
            word2 = [word2 stringByAppendingString:newLetter];
        }
        
        if([utils isValidWord:word1] && [utils isValidWord:word2])
        {
            //good word. lock the board
            NSLog(@"Word 1 - %@ : Is Valid", word1);
            NSLog(@"Word 2 - %@ : Is Valid", word2);
            [self._BoardLayer lockLetters];
            
            //Update score
            _Score = _Score + wordVal + wordVal2;
            [self updateScore];
            
            //check for win...
            if ([self._BoardLayer isWin:wordArray]) {
                NSLog(@"EPIC WIN");
                NSString *errorString = [[[NSString alloc] initWithFormat:@"A WINNER IS YOU!"] autorelease];
                
                UIAlertView *newAlert = [[[UIAlertView alloc] initWithTitle:@"w00t! :D" message:errorString delegate:self cancelButtonTitle:@"Woo Hoo!" otherButtonTitles:nil, nil] autorelease];
                
                [newAlert show];
                newAlert = nil;
                return;
            }
        }else if(![utils isValidWord:word1] && ![utils isValidWord:word2]){
            NSLog(@"Word 1 - %@ : Is Not Valid", word1);
            NSLog(@"Word 2 - %@ : Is Not Valid", word2);
            
            NSString *errorString = [[[NSString alloc] initWithFormat:@" Both Words Are Not Valid Word"] autorelease];
            
            UIAlertView *newAlert = [[[UIAlertView alloc] initWithTitle:@"Sorry :(" message:errorString delegate:self cancelButtonTitle:@"Try Again" otherButtonTitles:nil, nil] autorelease];
            
            [newAlert show];
            newAlert = nil;
            
        }else if(![utils isValidWord:word1]){
            //bad word... error
            NSLog(@"%@ : Is Not Valid", word1);
            NSString *errorString = [[[NSString alloc] initWithFormat:@" %@ - Is Not A Valid Word", word1] autorelease];
            
            UIAlertView *newAlert = [[[UIAlertView alloc] initWithTitle:@"Sorry :(" message:errorString delegate:self cancelButtonTitle:@"Try Again" otherButtonTitles:nil, nil] autorelease];
            
            [newAlert show];
            newAlert = nil;
        }else if(![utils isValidWord:word2]){
            //bad word... error
            NSLog(@"%@ : Is Not Valid", word2);
            NSString *errorString = [[[NSString alloc] initWithFormat:@" %@ - Is Not A Valid Word", word2] autorelease];
            
            UIAlertView *newAlert = [[[UIAlertView alloc] initWithTitle:@"Sorry :(" message:errorString delegate:self cancelButtonTitle:@"Try Again" otherButtonTitles:nil, nil] autorelease];
            
            [newAlert show];
            newAlert = nil;
        }
        
        
    }else{
        //positioning erorr or no word entered
        NSLog(@"Positioning Error Or No Word Submited");
        NSString *errorString = [[[NSString alloc] initWithFormat:@"There Is A Positioning Error"] autorelease];
        
        UIAlertView *newAlert = [[[UIAlertView alloc] initWithTitle:@"Sorry :(" message:errorString delegate:self cancelButtonTitle:@"Try Again" otherButtonTitles:nil, nil] autorelease];
        
        [newAlert show];
        newAlert = nil;
    }
    
    utils = nil;
    [utils release];
}

- (void) clearBoard: (CCMenuItem  *) menuItem 
{
    [self._BoardLayer clearLetterBank];
}

- (void) initLevelJson:(NSString *)levelString{
    NSError *error;
    _Level = [NSJSONSerialization 
                               JSONObjectWithData:[NSData dataWithContentsOfFile: [[NSBundle mainBundle] pathForResource:levelString ofType:@"json"]]
                               options:kNilOptions 
                               error:&error];
}

- (void) updateScore
{
    NSString *scoreStr =@"Score: ";
    
    self.ScoreLbl.string = [scoreStr stringByAppendingString:[NSString stringWithFormat:@"%d",_Score]];
}

@end
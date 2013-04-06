//
//  GameTypeMainWordBank.m
//  WordGameBeta
//
//  Created by Adam Jacaruso on 9/14/12.
//
//

#import "GameTypeMainWordBank.h"
#import "GameTypeMainLetter.h"
#import "Utils.h"

@implementation GameTypeMainWordBank
@synthesize letterBankArray;

- (GameTypeMainWordBank *)initWordBank{
    
    self = [super initWithFile:@"wordbank_background.png" rect:CGRectMake(0, 0, 320, 60)];
    
    letterBankArray = [[NSMutableArray alloc] init];
    
    [self createInitialWordBank];
    
    return self;
}

- (void)createInitialWordBank{
    
    for(GameTypeMainLetter *letter in letterBankArray){
        [letter removeFromParentAndCleanup:YES];
    }
    
    letterBankArray = [[NSMutableArray alloc] init];
    
    for(int i = 0; i < 7; i++){
        GameTypeMainLetter *newLetter = [[GameTypeMainLetter alloc] initLetter];
        newLetter.position =  ccp(((newLetter.contentSize.width+5)*i)+((newLetter.contentSize.width/4)-5), ((self.contentSize.height/2) - (newLetter.contentSize.height/2)));
        
        [newLetter setOriginalPosition:newLetter.position];
        
        [letterBankArray addObject:newLetter];
        [self addChild: newLetter];
    }
    
    if(![self bankContainsVowl]){
        [self createInitialWordBank];
    }
     
}

- (void)updateWordBank{
    
    bool setFirstUpdateToBeVowl = false;
    
    if(![self bankContainsVowl]){
        setFirstUpdateToBeVowl = true;
    }
    
    //Check for Inactive Letters
    for(int l = 0; l < [letterBankArray count]; l++){
        if(![[letterBankArray objectAtIndex:l] getActive]){
            GameTypeMainLetter *Letter = [letterBankArray objectAtIndex:l];
            GameTypeMainLetter *newLetter;
            
            if(setFirstUpdateToBeVowl){
                NSString *randomVowl = [Utils randomizeVowl];
                newLetter = [[GameTypeMainLetter alloc] initLetterWithLetter:randomVowl];
                setFirstUpdateToBeVowl = false;
            }else{
                newLetter = [[GameTypeMainLetter alloc] initLetter];
            }
            
            newLetter.position =  Letter.origPosition;
            [newLetter setOriginalPosition:newLetter.position];
            [letterBankArray replaceObjectAtIndex:l withObject:newLetter];
            [self addChild: newLetter];
            
        }
    }
        
}


- (void)setAllLetterOverlaysOff{
    for(int l = 0; l < [letterBankArray count]; l++){
        [[letterBankArray objectAtIndex:l] toggleOverlayVisible:false];
    }
}

- (NSMutableArray *)getLetterBankArray{
    return letterBankArray;
}


- (bool)bankContainsVowl{
    
    for(GameTypeMainLetter *letter in letterBankArray){
        if([self stringContainsVowl:[letter getLetter]] && [letter getActive]){
            return true;
        }
    }
    return false;
}

- (bool)stringContainsVowl:(NSString *)letterString{
    NSMutableArray *vowlArray = [[NSMutableArray alloc] initWithObjects: @"a", @"e", @"i", @"o", @"u", nil];
    
    for(NSString *letter in vowlArray){
        if ([letterString isEqualToString:letter]) {
            return true;
        }
    }
    return false;
}

@end

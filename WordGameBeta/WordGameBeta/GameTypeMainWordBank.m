//
//  GameTypeMainWordBank.m
//  WordGameBeta
//
//  Created by Adam Jacaruso on 9/14/12.
//
//

#import "GameTypeMainWordBank.h"
#import "GameTypeMainLetter.h"
@implementation GameTypeMainWordBank
@synthesize letterBankArray;

- (GameTypeMainWordBank *)initWordBank{
    
    self = [super initWithFile:@"wordbank_background.png" rect:CGRectMake(0, 0, 320, 80)];
    
    letterBankArray = [[NSMutableArray alloc] init];
    
    [self createInitialWordBank];
    
    return self;
}

- (void)createInitialWordBank{
    
    for(int i = 0; i < 7; i++){
        GameTypeMainLetter *newLetter = [[GameTypeMainLetter alloc] initLetter];
        newLetter.position =  ccp(((newLetter.contentSize.width+5)*i)+((newLetter.contentSize.width/4)-5), ((self.contentSize.height/2) - (newLetter.contentSize.height/2)));
        
        [newLetter setOriginalPosition:newLetter.position];
        
        [letterBankArray addObject:newLetter];
        [self addChild: newLetter];
    }
     
}

- (void)updateWordBank{
    
    //Check for Inactive Letters
    for(int l = 0; l < [letterBankArray count]; l++){
        if(![[letterBankArray objectAtIndex:l] getActive]){
            GameTypeMainLetter *Letter = [letterBankArray objectAtIndex:l];
            GameTypeMainLetter *newLetter = [[GameTypeMainLetter alloc] initLetter];
            
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

@end

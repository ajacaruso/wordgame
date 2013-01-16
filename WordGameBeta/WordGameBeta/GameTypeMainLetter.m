//
//  GameTypeMainLetter.m
//  WordGameBeta
//
//  Created by Adam Jacaruso on 9/20/12.
//
//
#import "Utils.h"
#import "GameTypeMainLetter.h"

@implementation GameTypeMainLetter
@synthesize letter, origPosition, lastPosition, active;

- (GameTypeMainLetter*)initLetter{
    
    NSString *randomLetter = [Utils randomizeLetter];
    NSString *letterImage = [NSString stringWithFormat:@"%@.png", randomLetter];
    
    self = [super initWithFile:letterImage rect:CGRectMake(0, 0, 40, 40)];
    
    letter = [[NSString alloc] initWithString:randomLetter];

    self.anchorPoint=ccp(0,0);
    active = TRUE;
    
    return self;
}

- (void)setLetter:(NSString *)newLetter{
    letter = newLetter;
}

- (NSString *)getLetter{
    return letter;
}

- (BOOL)getActive{
    return active;
}

- (void)setActive:(BOOL)activeState{
    active = activeState;
}

-(void)setOriginalPosition:(CGPoint)originalPosition{
    origPosition = originalPosition;
    lastPosition = originalPosition;
}
-(void)setLastPosition:(CGPoint)lPosition{
    lastPosition = lPosition;
}

-(void)goToOriginalPosition{
    self.position = origPosition;
}

-(void)goToLastPosition{
    self.position = lastPosition;
}

@end

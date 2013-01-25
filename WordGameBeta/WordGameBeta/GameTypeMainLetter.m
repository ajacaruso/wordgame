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
@synthesize letter, origPosition, lastPosition, active, overlaySprite;

- (GameTypeMainLetter*)initLetter{
    
    NSString *randomLetter = [Utils randomizeLetter];
    NSString *letterImage = [NSString stringWithFormat:@"%@.png", randomLetter];
    
    self = [super initWithFile:letterImage rect:CGRectMake(0, 0, 40, 40)];
    
    letter = [[NSString alloc] initWithString:randomLetter];

    self.anchorPoint=ccp(0,0);
    active = TRUE;
    
    overlaySprite = [[CCSprite alloc] initWithFile:@"game_type_main_invalid_overlay.png"];
    overlaySprite.anchorPoint = ccp(0,0);
    [self addChild:overlaySprite];
    [self toggleOverlayVisible:FALSE];
    
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

- (CGPoint)getLastPosition{
    return lastPosition;
}
- (CGPoint)getOriginalPosition{
    return origPosition;
}

-(void)goToOriginalPosition{
    self.position = origPosition;
}

-(void)goToLastPosition{
    self.position = lastPosition;
}

- (void)toggleOverlayState:(bool)isCorrect{
    
    [self toggleOverlayVisible:TRUE];
    CCTexture2D* tex = [[CCTextureCache sharedTextureCache] addImage:@"game_type_main_valid_overlay.png"];
    if(!isCorrect){
        tex = [[CCTextureCache sharedTextureCache] addImage:@"game_type_main_invalid_overlay.png"];
    }
    [overlaySprite setTexture:tex];
    
}

- (void)toggleOverlayVisible:(bool)previewEnabled{
    [overlaySprite setVisible:previewEnabled];
}

@end

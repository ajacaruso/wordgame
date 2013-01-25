

#import "cocos2d.h"

@interface GameTypeMainLetter : CCSprite{
    NSString *letter;
    CGPoint origPosition;
    CGPoint lastPosition;
    BOOL active;
    CCSprite *overlaySprite;
}

@property (nonatomic, assign) NSString *letter;
@property (assign) CGPoint origPosition;
@property (assign) CGPoint lastPosition;
@property (nonatomic, assign) BOOL active;
@property (nonatomic, assign) CCSprite *overlaySprite;

- (GameTypeMainLetter*)initLetter;
- (void)setLetter:(NSString *)newLetter;
- (NSString *)getLetter;
- (void)setOriginalPosition:(CGPoint)originalPosition;
- (void)setLastPosition:(CGPoint)lPosition;
- (CGPoint)getLastPosition;
- (CGPoint)getOriginalPosition;
- (void)goToOriginalPosition;
- (void)goToLastPosition;
- (void)setActive:(BOOL)activeState;
- (BOOL)getActive;
- (void)toggleOverlayState:(bool)isCorrect;
- (void)toggleOverlayVisible:(bool)previewEnabled;

@end

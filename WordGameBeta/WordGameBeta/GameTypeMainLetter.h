

#import "cocos2d.h"

@interface GameTypeMainLetter : CCSprite{
    NSString *letter;
    CGPoint origPosition;
    BOOL active;
}

@property (nonatomic, assign) NSString *letter;
@property (assign) CGPoint origPosition;
@property (nonatomic, assign) BOOL active;

- (GameTypeMainLetter*)initLetter;
- (void)setLetter:(NSString *)newLetter;
- (NSString *)getLetter;
- (void)setOriginalPosition:(CGPoint)originalPosition;
- (void)goToOriginalPosition;
- (void)setActive:(BOOL)activeState;
- (BOOL)getActive;

@end

//
//  GameTypeMain.h
//  WordGameBeta
//
//  Created by Adam Jacaruso on 9/13/12.
//
//

#import "cocos2d.h"
#import "GameTypeMainPlayArea.h"
#import "GameTypeMainControlls.h"
#import "GameTypeMainLetter.h"
#import "GameTypeMainTile.h"

@interface GameTypeMain : CCScene
{
    
    CCMenu *backMenu;
    GameTypeMainPlayArea *playArea;
    GameTypeMainControlls *gameControlls;
    GameTypeMainLetter *selLetter;
    CGPoint lastDragPoint;
}

@property (nonatomic, retain) CCMenu *backMenu;
@property (nonatomic, retain) GameTypeMainPlayArea *playArea;
@property (nonatomic, retain) GameTypeMainControlls *gameControlls;
@property (nonatomic, retain) GameTypeMainLetter *selLetter;
@property (assign) CGPoint lastDragPoint;

- (void)openMenu;
- (void)closeMenu;
- (void)submitWord:(NSString *)specialAbility;
- (void)handlePanFrom:(UIPanGestureRecognizer *)recognizer;
- (void)selectSpriteForTouch:(CGPoint)touchLocation;
- (void)panForTranslation:(CGPoint)translation;

- (BOOL)spriteIsInPlayArea:(CCSprite *)sprite;
- (BOOL)spriteIsInWordBank:(CCSprite *)sprite;
- (BOOL)spriteIsInBoard:(CCSprite *)sprite;

- (void) changeContainerOfSprite:(CCSprite *)sprite to:(CCSprite *)container;

- (void)returnToWordBank:(GameTypeMainLetter*)Letter;

@end

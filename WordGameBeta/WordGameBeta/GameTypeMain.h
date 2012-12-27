//
//  GameTypeMain.h
//  WordGameBeta
//
//  Created by Adam Jacaruso on 9/13/12.
//
//
#import <GameKit/GameKit.h>
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
    int currentResetPoint;
}

@property (nonatomic, retain) CCMenu *backMenu;
@property (nonatomic, retain) GameTypeMainPlayArea *playArea;
@property (nonatomic, retain) GameTypeMainControlls *gameControlls;
@property (nonatomic, retain) GameTypeMainLetter *selLetter;
@property (assign) CGPoint lastDragPoint;
@property (nonatomic, assign) int currentResetPoint;

- (void)openMenu;
- (void)closeMenu;
- (void)submitWord:(NSString *)specialAbility;
- (void)moveBoard:(ccTime)dt;
- (void)handlePanFrom:(UIPanGestureRecognizer *)recognizer;
- (void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer;
- (void)selectSpriteForTouch:(CGPoint)touchLocation;
- (void)panForTranslation:(CGPoint)translation;

- (void)checkMoveCompleted;
- (BOOL)spriteIsInPlayArea:(CCSprite *)sprite;
- (BOOL)spriteIsInWordBank:(CCSprite *)sprite;
- (BOOL)spriteIsInBoard:(CCSprite *)sprite;

- (void) changeContainerOfSprite:(CCSprite *)sprite to:(CCSprite *)container;

- (void)returnToWordBank:(GameTypeMainLetter*)Letter;

@end

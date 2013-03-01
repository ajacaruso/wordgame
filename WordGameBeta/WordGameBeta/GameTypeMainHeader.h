#import <GameKit/GameKit.h>
#import "cocos2d.h"
#import "CCProgressTimer.h"

@interface GameTypeMainHeader : CCSprite{
    CCMenu *controllMenu;
    CCScene *gameManager;
    CCProgressTimer *timer;
    CCLabelTTF *scoreLabel;
}
@property (nonatomic, retain) CCMenu *controllMenu;
@property (nonatomic, retain) CCScene *gameManager;
@property (nonatomic, retain) CCProgressTimer *timer;
@property (nonatomic, retain) CCLabelTTF *scoreLabel;

- (GameTypeMainHeader*)initWithManager:manager;
- (void) openMenu: (CCMenuItem  *) menuItem;
- (void) enableControls:(BOOL) enable;
- (void)updateProgressBar:(ccTime)dt;
- (void) setScore:(NSString *) newScore;
- (NSString *) getScore;

@end

#import "cocos2d.h"
#import "MenuManager.h"

@interface GameTypeMainOverlay : CCSprite{

    CCMenu *pauseMenu;
    GameTypeMain *gameManager;
}

@property (nonatomic, assign) CCMenu *pauseMenu;
@property (nonatomic, retain) GameTypeMain *gameManager;

- (GameTypeMainOverlay*)initMenuOverlay:manager;
- (void) resume: (CCMenuItem  *) menuItem;
- (void) showOptions: (CCMenuItem  *) menuItem;
- (void) quit: (CCMenuItem  *) menuItem;

@end

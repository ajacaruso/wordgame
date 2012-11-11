
#import "cocos2d.h"


@interface GameTypeMainControlls : CCSprite{
    CCMenu *controllMenu;

}
@property (nonatomic, retain) CCMenu *controllMenu;
@property (nonatomic, retain) CCLayer *gameManager;

- (GameTypeMainControlls*)initWithControlls:(NSString *)Controlls withManager:manager;
- (void) openMenu: (CCMenuItem  *) menuItem;
- (void) enableControls:(BOOL) enable;

@end


#import "cocos2d.h"


@interface GameTypeMainControlls : CCSprite{
    CCMenu *controllMenu;

}
@property (nonatomic, retain) CCMenu *controllMenu;
@property (nonatomic, retain) CCLayer *gameManager;
@property (nonatomic, retain) NSString *specialAbility;
@property (nonatomic, retain) CCMenuItemImage *specialItemButton;

- (GameTypeMainControlls*)initWithControlls:(NSString *)Controlls withManager:manager;
- (NSString *)getSpecialAbility;

@end

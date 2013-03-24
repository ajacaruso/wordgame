
#import "MenuManager.h"
#import "GameManager.h"
#import "cocos2d.h"

@interface GameTypeMainLevelSelector : CCLayer {
    CCMenu *backMenu;
    CCMenu *selectMenu;
}

@property (nonatomic, retain) CCMenu *backMenu;
@property (nonatomic, retain) CCMenu *selectMenu;

+(CCScene *) scene;

@end
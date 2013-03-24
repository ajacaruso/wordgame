
#import "cocos2d.h"
#import "MenuManager.h"
#import "GameManager.h"

@interface MainMenu : CCLayer
{
    CCMenu *mainMenu;
}

@property (nonatomic, retain) CCMenu *mainMenu;

+(CCScene *) scene;

@end

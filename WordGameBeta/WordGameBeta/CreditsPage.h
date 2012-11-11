
#import "cocos2d.h"
#import "MainMenu.h"

@interface CreditsPage : CCLayer
{
    CCMenu *backMenu;
}

@property (nonatomic, retain) CCMenu *backMenu;

+(CCScene *) scene;

@end